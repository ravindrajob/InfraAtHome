import paho.mqtt.client as mqtt
import requests
import json
import os

# Webhook simulé pour le lab public
WEBHOOK_URL = os.getenv("WEBHOOK_URL", "https://n8n.lab-simulation.local/webhook/zigbee-alert")
MQTT_BROKER = os.getenv("MQTT_BROKER", "localhost")

def on_message(client, userdata, msg):
    try:
        data = json.loads(msg.payload.decode())
        
        # Détection du type d'événement
        if msg.topic == "honeypot/zigbee2mqtt/bridge/event":
            if data.get("type") == "device_joined":
                mac_address = data["data"]["device"]["ieee_address"]
                print(f"[!] ALERTE INTRUSION : Appareil suspect connecté ({mac_address})")
                
                # 1. Alerte N8N
                requests.post(WEBHOOK_URL, json={"alerte": "Intrusion Zigbee", "mac": mac_address})
                
                # 2. Fermeture d'urgence du réseau
                client.publish("honeypot/zigbee2mqtt/bridge/request/permit_join", '{"value": false}')
                
    except Exception as e:
        pass

if __name__ == "__main__":
    print(f"[*] Démarrage du watcher MQTT sur {MQTT_BROKER}...")
    client = mqtt.Client()
    client.on_message = on_message
    client.connect(MQTT_BROKER, 1883, 60)
    client.subscribe("honeypot/zigbee2mqtt/#")
    client.loop_forever()