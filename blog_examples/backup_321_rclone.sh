#!/bin/bash
# ==============================================================================
# Script : backup_321_rclone.sh
# Description : Automatisation de la règle 3-2-1 via Rclone vers Azure Blob / S3
# Environnement : Lab public de démonstration
# ==============================================================================
set -euo pipefail

# Variables de configuration
SOURCE_DIR="/var/opt/data_production"
NAS_DEST_DIR="/mnt/nas_local/backups"
CLOUD_DEST="azure_blob_remote:backup-container"

TIMESTAMP=$(date +'%Y-%m-%d_%H%M%S')
BACKUP_ARCHIVE="backup_${TIMESTAMP}.tar.gz"

echo "[*] Début du processus de sauvegarde 3-2-1..."

# 1. Création de la copie "Chaude" (Archive locale)
echo "[1/3] Compression des données..."
tar -czf "/tmp/${BACKUP_ARCHIVE}" -C "${SOURCE_DIR}" .

# 2. Transfert vers le NAS Local (Copie 2 sur support physique différent)
echo "[2/3] Transfert rsync vers le NAS local..."
rsync -avz --progress "/tmp/${BACKUP_ARCHIVE}" "${NAS_DEST_DIR}/"

# 3. Exfiltration chiffrée vers le Cloud (Copie 3 Hors site)
# L'utilisation de rclone permet le chiffrement natif avant l'upload (via rclone crypt)
echo "[3/3] Upload chiffré vers Azure Blob Storage (via Rclone)..."
rclone copy "/tmp/${BACKUP_ARCHIVE}" "${CLOUD_DEST}" --progress

# Nettoyage
rm -f "/tmp/${BACKUP_ARCHIVE}"

echo "[*] Opération 3-2-1 terminée avec succès !"