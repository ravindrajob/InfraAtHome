############################################################################
# On applique le DNS 8.8.8.8 à notre VM Docker pour installer les containers
#####

systemctl start systemd-resolved.service
rm /etc/netplan/00-installer-config.yaml
cat > /etc/netplan/00-installer-config.yaml << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    ens3:
        dhcp4: no
        addresses: [10.0.1.2/24]
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

echo "On test influxdb.ravin-cloud.fr"
dig +short influxdb.ravin-cloud.fr | tail -n1

#What is my DNS ?
#systemd-resolve --status | grep 'DNS Servers' -A2

cd /home/ravin/docker/bind9
systemctl stop systemd-resolved.service
docker-compose up -d

cd /home/ravin/docker/next-cloud
#docker-compose down --volumes && docker-compose stop &&
docker-compose up -d
#cat local_file.sh | docker exec -i container_name bash
cd /home/ravin/docker/mirobo
docker-compose up -d

cd /home/ravin/docker/gitea
docker-compose up -d

cd /home/ravin/docker/supervision
docker-compose up -d

cd /home/ravin/docker/plex
docker-compose up -d


###################################################
# On applique le DNS bind 10.0.1.2  à notre VM Docker
####

rm /etc/netplan/00-installer-config.yaml
cat > /etc/netplan/00-installer-config.yaml << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    ens3:
        dhcp4: no
        addresses: [10.0.1.2/24]
        gateway4: 10.0.1.1
        nameservers:
            addresses: [10.0.1.2]
EOF
netplan apply
systemctl restart systemd-networkd
systemctl restart systemd-resolved.service


echo "les serveur DNS sur cette VM sont : "
grep "nameserver" /etc/resolv.conf

echo "On test google.fr"
dig +short google.fr | tail -n1

echo "On test influxdb.ravin-cloud.fr"
dig +short influxdb.ravin-cloud.fr | tail -n1

