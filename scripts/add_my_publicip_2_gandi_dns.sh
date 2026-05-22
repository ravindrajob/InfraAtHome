#!/bin/bash
################################################################
# Titre: add_my_publicip_2_gandi_dns.sh
# Description : Composant technique du Lab de Simulation
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
. /home/ravindra/scripts/credential # Comprend les identifiants de mon API GANDI

API="https://dns.api.gandi.net/api/v5/"
IP_SERVICE="http://me.gandi.net"
#IP4="1.1.1.1"
IP4=$(curl https://ipinfo.io/ip)

DOMAIN="ravindra-job.com"
RECORD='@'

DATA='{"rrset_values": ["'$IP4'"]}'
curl -s -XPUT -d "$DATA" \
        -H"X-Api-Key: $APIKEY" \
        -H"Content-Type: application/json" \
        "$API/domains/$DOMAIN/records/$RECORD/A"
