#!/bin/bash
IP4=$(curl https://ipinfo.io/ip)
currentIP=$(cat /etc/nginx/whitelist-allow.conf|sed 's/.*allow //'| tail -f -n 1 | awk -F';' '{print $1}')

if [ "$IP4" = "$currentIP" ]; then
  echo "IP deja whistelist dans NGINX"
else
  echo "IP public non identique"
  echo IP: $IP4
  echo currentIP: $currentIP
  echo "correction dans la whiteliste"
  rm /etc/nginx/whitelist-allow.conf
  cat <<- EOF > /etc/nginx/whitelist-allow.conf
allow $IP4;
EOF
  nginx -t >/dev/null 2>&1
  if [ $? -eq 0 ]; then
   echo "success donc Reload NginX configuration"
   sudo service nginx reload
  else
    echo "failure, because: $out"
    # Notification telegram dans la prochaine version
  fi
fi
