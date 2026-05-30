#!/bin/bash
HOSTNAME=$(hostname) #nom de la machine
IP_LOCALE=$(hostname -I | awk '{print $1}') #adresses IP de la machine 
IP_PUBLIQUE=$(curl -s --max-time 4 ifconfig.me) #IP d'un site -s: silencieux tsisy barre de progression
#--max-timz 4 ifconfig.me : affiche l'IP pendant 4 secondes 
MAC=$(ip a | grep 'link/ether' | awk '{print $2}' | head -1) #adresse mac
INTERFACE_ACTIVE=$(ip -o link show up | awk -F': ' '{print $2}' | grep -v 'lo') # ip-o link show up : affiche une seule ligne par interface active
echo "HOSTNAME=$HOSTNAME"
echo "IP_LOCALE=$IP_LOCALE"
echo "IP_PUBLIQUE=$IP_PUBLIQUE"
echo "MAC=$MAC"
echo "INTERFACE=$INTERFACE_ACTIVE"
# trafic réseau 
echo "TRAFFIC_BEGIN"
tail -n+3 /proc/net/dev | while read -r ligne; #trafic de toutes les interfaces 
do 
	INTERFACE=$(echo "$ligne" | awk -F':' '{print $1}')
	STATS=$(echo "$ligne" | awk -F':' '{print $2}')
	RX_BYTES=$(echo "$STATS" | awk '{print $1}')
	TX_BYTES=$(echo "$STATS" | awk '{print $9}')
	echo "$INTERFACE|$RX_BYTES|$TX_BYTES"
done
echo "TRAFFIC_END"
#RX_MO=$(echo "$RX_BYTES/1048576" | bc)
#TX_MO=$(echo "$TX_BYTES/1048576" | bc)
#echo "Interface(s) active(s):$INTERFACE_ACTIVE"

#test internet
ping -c 1 8.8.8.8 >/dev/null 2>&1 #envoie un paquet DNS 
if [ $? -eq 0 ] ;then 
	echo "INTERNET=OK"
else
	echo "INTERNET=KO"
fi
#connexions
NB_ESTABLISHED=$(ss -tn | grep -c 'ESTAB')
NB_TIME_WAIT=$(ss -tn | grep -c 'TIME-WAIT')
NB_CLOSE_WAIT=$(ss -tn | grep -c 'CLOSE-WAIT')

echo "ESTABLISHED=$NB_ESTABLISHED"
echo "TIME_WAIT=$NB_TIME_WAIT"
echo "CLOSE_WAIT=$NB_CLOSE_WAIT"
