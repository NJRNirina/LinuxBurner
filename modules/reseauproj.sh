#!/bin/bash
echo "ETAPE 1: IDENTITE DE LA MACHINE"
echo ""
HOSTNAME=$(hostname)
echo "Nom d de la machine:$HOSTNAME"
IP_LOCALE=$(hostname -I | awk '{print $1}')
echo "IP local:$IP_LOCALE"
IP_PUBLIQUE=$(curl -s --max-time 4 ifconfig.me)
if [ -n "IP publique" ];then
	echo "IP publique (WAN):$IP_PUBLIQUE"
else 
	echo "IP PUBLIQUE (wan): you should install curl"
fi
MAC=$(ip a | grep 'link/ether' | awk '{print $2}' | head -1)
echo "Adresse MAC:$MAC"
INTERFACE_ACTIVE=$(ip -o link show up | awk -F': ' '{print $2}' | grep -v 'lo')
echo "Interface(s) active(s):$INTERFACE_ACTIVE"
echo ""
echo "ETAPE 2: TRAFFIC RESEAU (OCTETS RECUS ET ENVOYES)"
echo ""
tail -n+3 /proc/net/dev | while read -r ligne;do 
INTERFACE=$(echo "$ligne" | awk -F':' '{print $1}')
STATS=$(echo "$ligne" | awk -F':' '{print $2}')
RX_BYTES=$(echo "$STATS" | awk '{print $1}')
TX_BYTES=$(echo "$STATS" | awk '{print $9}')
RX_MO=$(echo "$RX_BYTES/1048576" | bc)
TX_MO=$(echo "$TX_BYTES/1048576" | bc)
#echo "Interface(s) active(s):$INTERFACE_ACTIVE"
echo "Octets envoyes (en Mo): $RX_MO"
echo "Octets recus (en Mo): $TX_MO"
done
echo ""
echo "ETAPE 3: TEST CONNECTIVITE"
echo ""
echo "Test de connectivite vers google:"
ping -c 3 8.8.8.8
echo ""
if [ $? -eq 0 ] ;then 
	echo "Internet accessible."
else
	echo "Pas d'acces internet"
fi
echo ""
echo "Test DNS:"
DNS=$(nslookup google.com | grep -A1 'Name:' | grep 'Address:' |  head -1 | awk '{print $2}')
if [ -n "$DNS" ] ;then 
	echo "DNS fonctionne."
else
	echo "DNS ne fonctionne pas!Sites webs non accessibles."
fi 
echo ""
RESULT=$(ping -c 3 8.8.8.8)
if [ $? -eq 0 ] ;then
	LATENCE=$(echo "$RESULT" | tail -1 | awk -F'/' '{print $5}')
	if [ $(echo "$LATENCE < 50") ] ;then
		echo "Connexion rapide."
	elif [ $(echo "$LATENCE > 150") ] ;then
		echo "Connexion normale."
	else
		echo "Connexion lente."
	fi
fi
echo ""
echo "ETAPE 4: SERVICES EN ECOUTE (PORTS OUVERTS ET CONNEXIONS ACTIVES)"
echo ""
NB_PORTS_EN_ECOUTE=$(ss -tuln | tail -n+2 | wc -l)
echo "Le nombre de connexion(s) active(s):"
NB_ESTABLISHED=$(ss -tn | grep -c 'ESTAB')
NB_TIME_WAIT=$(ss -tn | grep -c 'TIME-WAIT')
NB_CLOSE_WAIT=$(ss -tn | grep -c 'CLOSE-WAIT')
echo "Nombre de connexion active en cours:$NB_ESTABLISHED"
echo "Nombre de connexion en fermeture:$NB_TIME_WAIT"
echo "Nombre de connexion en attente de fermeture:$NB_CLOSE_WAIT"
echo "Date : $(date + "%d/%m/%Y %H:%M:%S")"

