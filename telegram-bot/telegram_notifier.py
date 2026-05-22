################################################################
# Titre: telegram_notifier.py
# Description : Script Python autonome pour envoyer des alertes sur Telegram
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
import requests
import json
import os

# ==============================================================================
# Script : telegram_notifier.py
# Description : Script Python autonome pour envoyer des alertes sur Telegram
# Environnement : Lab public de démonstration
# ==============================================================================

# Variables d'environnement (Pas de secrets en clair dans le code)
TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")
TELEGRAM_CHAT_ID = os.getenv("TELEGRAM_CHAT_ID")

def send_telegram_alert(message_title: str, message_body: str, is_critical: bool = False):
    """
    Envoie un message formaté sur un canal ou groupe Telegram via l'API.
    """
    if not TELEGRAM_BOT_TOKEN or not TELEGRAM_CHAT_ID:
        print("[!] Erreur: Token ou Chat ID manquant dans l'environnement.")
        return

    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendMessage"
    
    icon = "🚨" if is_critical else "ℹ️"
    formatted_text = f"*{icon} {message_title}*\n\n{message_body}"

    payload = {
        "chat_id": TELEGRAM_CHAT_ID,
        "text": formatted_text,
        "parse_mode": "Markdown"
    }

    try:
        response = requests.post(url, json=payload, timeout=5)
        response.raise_for_status()
        print("[+] Message Telegram envoyé avec succès.")
    except requests.exceptions.RequestException as e:
        print(f"[!] Erreur lors de l'envoi du message : {e}")

if __name__ == "__main__":
    # Test d'intégration (Simulation)
    send_telegram_alert(
        message_title="Alerte Domotique",
        message_body="La machine à laver (Prise Connectée ZB) a terminé son cycle.",
        is_critical=False
    )