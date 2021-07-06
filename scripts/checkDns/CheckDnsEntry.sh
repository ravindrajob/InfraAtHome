#!/bin/bash
FILESPRD=fqdn-prd.txt
RJPRD="10.32.12.1"

# On verifie chaque ligne du fichier si FQDN = 10.32.12.1
while read line; do
echo $line
a=$(dig +short  $line | tail -n1)
if [ "$a" == "$RJPRD" ]; then
	#echo "FQDN $line = $RJPRD "
    echo "ok"
else
	echo "FQDN $line NOT EQUAL $RJPRD">./CARE-GWC-PRD.txt
	echo "ko"
fi
done < $FILESPRD
