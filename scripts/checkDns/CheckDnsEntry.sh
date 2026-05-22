#!/bin/bash
################################################################
# Titre: CheckDnsEntry.sh
# Description : Composant technique du Lab de Simulation
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
FILESPRD=fqdn-prd.txt
RJPRD="10.32.12.1"

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# On vérifie que l'on arrive bien à résoudre chaque FQDN présent dans le fichier
while read line; do
	a=$(dig +short  $line | grep $RJPRD)

	if [ "$a" == "$RJPRD" ]; then
		echo "${green}$line OK${reset}"
	else
		echo "FQDN $line NOT EQUAL $RJPRD" > resolution_failed.txt
		echo "${red}$line KO${reset}"
	fi
done < $FILESPRD