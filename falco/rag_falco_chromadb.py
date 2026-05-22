################################################################
# Titre: rag_falco_chromadb.py
# Description : Composant technique du Lab de Simulation
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
from langchain_community.vectorstores import Chroma
from langchain_huggingface import HuggingFaceEmbeddings
import json

# Configuration de la base Chroma locale
embeddings = HuggingFaceEmbeddings(model_name="all-MiniLM-L6-v2")
vector_db = Chroma(persist_directory="./falco_db", embedding_function=embeddings)

def ingest_falco_alert(json_log_line):
    log_data = json.loads(json_log_line)
    
    # Création du document enrichi (Metadata = contexte K8s)
    texte = f"Alerte Falco: {log_data.get('output')} (Règle: {log_data.get('rule')})"
    metadonnees = {
        "namespace": log_data.get("k8s.ns.name", "unknown"),
        "pod": log_data.get("k8s.pod.name", "unknown"),
        "severity": log_data.get("priority", "unknown"),
        "time": log_data.get("time")
    }
    
    # Ajout dans la base vectorielle
    vector_db.add_texts(texts=[texte], metadatas=[metadonnees])

# Simulation d'ingestion d'un flux d'événements pour le lab de démonstration
if __name__ == "__main__":
    print("[*] Ingestion des logs simulés dans ChromaDB...")
    ingest_falco_alert('{"output": "Warning File /etc/shadow opened", "rule": "Read sensitive file", "priority": "Warning", "k8s.ns.name": "backend"}')
    print("[+] Terminé.")