#!/bin/bash
######################################################################################
# Titre:  Route my logs 2 Qnap
# Description : Router mes logs vers notre concentrateur
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 19/10/2015 [RJ]
######################################################################################

# Attention bien configurere votre serveurs RSYSLOG avant, dans notre cas, activer le rsyslog sur votre QNAP

#Configurer sur les serveurs la redirection des logs sur notre rsyslog
grep -qxF '*.* @myqnap.ravindra-job.com:514 # en UDP'  /etc/rsyslog.conf || echo '*.* @myqnap.ravindra-job.com:514 # en UDP' >>  /etc/rsyslog.conf

# On génére une log	pour tester l'envoi
logger  -p local1.info -T -n myqnap.ravindra-job.com -P 514 "Test envoi de log par Ravindra"
