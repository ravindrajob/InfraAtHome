#!/bin/bash
################################################################
# Titre: Sauvegarde de la carte SD / ou clef USB du RPI
# Description : Sauvegarde la carte SD/clefUSB du RPI pour la sauvegarder via SMB 
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 05/08/2014 [RJ]
# Update: 09/11/2020 [RJ]
################################################################

# SI on souhaite automatiser la tache toutes les semaines :
# chmod +x /home/ravindra/scripts/SavMyRpi.sh
# @weekly bash /home/ravindra/scripts/SavMyRpi.sh

#Comprend les identifiants pour accéder au qnap
. /home/ravindra/creds/include_passwd

# Formatage de la date debut et de l'heure
DATE_DEBUT=`date +%d-%m-%Y`
H_DEPART=`date +%H:%M:%S`
DEBUT_EN_SEC=$(($(echo $H_DEPART | cut -d':' -f1)*3600+$(echo $H_DEPART | cut -d':' -f2)*60+$(echo $H_DEPART | cut -d':' -f3)))

# Montage du Qnap
echo "Montage du Qnap"
mkdir -p /mnt/qnap/Backup_raspberry
/sbin/mount.cifs //qnap.ravindra-job.com/Backup_raspberry/ /mnt/qnap/Backup_raspberry -o user=$user_qnap,pass=$pass_qnap  --verbose

# Sauvegarde du Qnap
echo "Sauvegarde du Qnap"
dd if=/dev/mmcblk0 | gzip -9 > /mnt/qnap/Backup_raspberry/srv-rpi-${DATE_DEBUT}'-'$H_DEPART.img.gz

# Démontage du Qnap
echo "Démontage du Qnap"
/bin/umount /mnt/qnap/Backup_raspberry
