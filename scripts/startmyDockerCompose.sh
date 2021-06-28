#!/bin/bash

################################################################
# Titre: Mini orchestrator de containers
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 01/02/2021 [RJ]
# Attention ce script ne fonctionne qu'à partir d'ubuntu 20.04
################################################################

# On applique le DNS 8.8.8.8 à notre VM Docker pour installer les containers
systemctl start systemd-resolved.service
rm /etc/netplan/00-installer-config.yaml
cat > /etc/netplan/00-installer-config.yaml << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    ens3:
        dhcp4: no
        addresses: [10.0.1.9/24]
        gateway4: 10.0.1.1
        nameservers:
            addresses: [8.8.8.8, 8.8.4.4]
EOF
netplan apply
systemctl restart systemd-networkd
echo "les serveur DNS sur cette VM sont : "
grep "nameserver" /etc/resolv.conf

echo "On test google.fr"
dig +short google.fr | tail -n1

echo "On test influxdb.ravindra-job.com"
dig +short influxdb.ravindra-job.com | tail -n1

# Sur quel serveur DNS suis-je ?
#systemd-resolve --status | grep 'DNS Servers' -A2

cd /home/ravindrajob/docker/bind9
systemctl stop systemd-resolved.service
docker-compose up -d

# Quels ports sont exposés ?
#netstat -tunlp

#On démarre d'abord notre serveur DNS BIND
cd /home/ravin/docker/bind9
systemctl stop systemd-resolved.service
docker-compose up -d

cd /home/ravin/docker
#on se déplace chacun des dossiers où sont nos docker-compose

FolderDetected=$(ls -d */ | cut -f1 -d'/')

for dockerFolder in $FolderDetected; do 
  cd /home/ravin/docker/$dockerFolder
  echo "Nous sommes dans le dossier"
  echo "starting $FolderDetected ..."
  docker-compose up --build -d
done

#######################################################
# On applique le DNS bind 10.0.1.9 à notre VM Docker  #
#######################################################

rm -f /etc/netplan/00-installer-config.yaml
cat > /etc/netplan/00-installer-config.yaml << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    ens3:
        dhcp4: no
        addresses: [10.0.1.9/24]
        gateway4: 10.0.1.1
        nameservers:
            addresses: [10.0.1.9]
EOF
netplan apply
systemctl restart systemd-networkd
systemctl restart systemd-resolved.service

echo "les serveur DNS sur cette VM sont : "
grep "nameserver" /etc/resolv.conf

echo "On test google.fr"
dig +short google.fr | tail -n1

echo "On test influxdb.ravindra-job.com"
dig +short influxdb.ravindra-job.com | tail -n1

