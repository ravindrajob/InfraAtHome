#!/bin/bash
# Tester nos alerter AlertManager avec un simple CURL.
# Record cherti -->  https://gist.github.com/cherti/61ec48deaaab7d288c9fcf17e700853a

name=SendAlert2Alexa
url='https://alertmanager.ravindra-job.com/api/v1/alerts'

echo "Alert $name en cours ..."

# change url o
curl -k -XPOST $url -d "[{
        \"status\": \"firing\",
        \"labels\": {
                \"alertname\": \"$name\",
                \"service\": \"my-service\",
                \"severity\":\"critical\",
                \"instance\": \"$name.example.net\"
        },
        \"annotations\": {
                \"summary\": \"Test en cours\"
        },
        \"generatorURL\": \"https://prometheus.ravindra-job.com/<generating_expression>\"
}]"

echo ""

echo "Appuyer sur ENTER pour résoudre l'incident"
read

echo "Resolution de l'alerte"
curl -k -XPOST $url -d "[{
        \"status\": \"resolved\",
        \"labels\": {
                \"alertname\": \"$name\",
                \"service\": \"my-service\",
                \"severity\":\"critical\",
                \"instance\": \"$name.example.net\"
        },
        \"annotations\": {
                \"summary\": \"Test en cours\"
        },
        \"generatorURL\": \"https://prometheus.ravindra-job.com/<generating_expression>\"
}]"

echo ""
