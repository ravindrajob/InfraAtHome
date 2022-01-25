#!/bin/bash
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
