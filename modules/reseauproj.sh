#!/bin/bash
#exec >>(tee -a reseauproj.log) 2>&1
#Etape 1:identité de la machine
#main() {
echo  "ETAPE 1: IDENTITÉ DE LA MACHINE"
echo ""

#hostname=nom de la machine
HOSTNAME=$(hostname)
echo "nom de la machine:$HOSTNAME"

#IP local (LAN) =IP publique
IP_LOCALE=$(hostname -I | awk '{print $1}')
echo "IP local:$IP_LOCALE"

#IP publique (WAN)
IP_PUBLIQUE=$(curl -s --max-time 4 ifconfig.me)
if [ -n "IP publique" ]; then
	echo "IP publique (WAN):$IP_PUBLIQUE"
else
	echo "IP publique (WAN):pas d'internet"
       echo sudo apt install curl	
fi

#adresse MAC
MAC=$(ip a | grep 'link/ether' | awk '{print $2}' | head -1)
echo "adresse MAC:$MAC"

#inteface réseau active
INTERFACE_ACTIVE=$(ip link show | awk -F': ' '{print $2}')
echo "interface active:$INTERFACE_ACTIVE"
#bol mila condition ra tsy mande
echo ""


#Etape 2:traffic réseau (octets reçus et envoyés)
echo "ETAPE 2: TRAFFIC RESEAU (OCTETS REÇUS ET ENVOYÉS)"
echo ""

tail -n +3 /proc/net/dev | while read -r ligne;do
INTERFACE=$(echo "$ligne" | awk -F':' '{print $1}')
STATS=$(echo "$ligne" | awk -F':' '{print $2}')
RX_BYTES=$(echo "$STATS" | awk '{print $1}') #ocets envoyés
TX_BYTES=$(echo "$STATS" | awk '{print $9}') #octets reçus

#conversion en mo , 1mo =1 048 576 | bc=bash calculator
RX_MO=$(echo "$RX_BYTES/1048576" | bc)
TX_MO=$(echo "$TX_BYTES/1048576" | bc)
echo "Interfaces actives: $INTERFACE"
echo "Octets envoyés (en Mo): $RX_MO"
echo "Octets reçus (en Mo): $TX_MO"
done
echo ""
#bol afaka apina vitesse en temps reel

#Etape 3:test connectivité
echo "ETAPE 3: TEST CONNECTIVITÉ"
echo ""

#test ping,DNS,latence

#test connectivité vers google
echo "Test connectivité vers google:"
ping -c 3 8.8.8.8
echo ""
if [ $? -eq 0 ] ;then #$? code de retour en bash,0=succès,1=échec
	echo "Internet accessible."
else
	echo "Pas d'accès à internet"	
fi

#test DNS
echo ""
echo "Test DNS:"
DNS=$(nslookup google.com | grep -A1 'Name:' | grep 'Address:' | head -1 | awk '{print $2}') #-A:affiche une ligne après celle que l'on atrouvé (After)
if [ -n "$DNS" ]; then #-n vérifie si la chaine n'est pas vide
	echo "DNS fonctionne."
else
	echo "DNS ne fonctionne pas! Sites web inaccessibles."
fi
echo ""

#test latence vers google
#latence(temps de réponse): temps que met un paquet pour aller et revenir d'une machine
#Faible latence (< 50ms)  → connexion rapide
#Latence moyenne (50-150ms) → connexion correcte
#Latence élevée (> 150ms)   → connexion lente ou surchargée

RESULT=$(ping -c 3 8.8.8.8) #8.8.8.8=IP de google
if [ $? -eq 0 ] ;then
	LATENCE=$(echo "$RESULT" | tail -1 | awk -F'/' '{print $5}')
	if [ $(echo "$LATENCE < 50") ]; then
		echo "Connexion rapide."
	elif [ $(echo "$LATENCE > 150") ]; then
		echo "Connexion normale."
	else
		echo "Connexion lente."
	fi
else
	echo "Pas d'accès à google.com"
fi
echo ""

#étape 4:services en écoutes (ports et connexions)
echo "ETAPE 4: SERVICES EN ÉCOUTE (PORTS OUVERTS ET CONNEXIONS ACTIVES)"
echo ""
#ports en écoute
#ss -tulp

LISTE_DE_PORTS_EN_ECOUTE=$(ss -tulp | awk '{n=split($5, a, ":"); print a[n]}')
echo "-Liste des ports en écoute:$LISTE_DE_PORTS_EN_ECOUTE"
echo ""
NB_DE_PORTS_EN_ECOUTE=$(ss -tuln | awk '{n=split($5, a, ":"); print a[n]}' | wc -l)
echo "-Le nombre de ports en ecoute:$NB_DE_PORTS_EN_ECOUTE"
echo ""

#connexions ouverts
echo "Le nombre de connexions actives:"
echo ""
NB_ESTABLISHED=$(ss -tn | grep -c 'ESTAB') #-c compte le nb qui contient le mot
NB_TIME_WAIT=$(ss -tn | grep -c 'TIME-WAIT')
NB_CLOSE_WAIT=$(ss -tn | grep -c 'CLOSE-WAIT')
echo "-Nombre de connexion active en cours:$NB_ESTABLISHED"
echo "-Nombre de connexion en fermeture:$NB_TIME_WAIT"
echo "-Nombre de connexion en attente de fermeture:$NB_CLOSE_WAIT"

#commande (exemple:echo "texte") | tee -a fichier.log : affiche dans le terminalet sauvegarde en meme temps
#fichier.log pour afficher en même dans le terminal et dans le fichier
#date '%d/%m/%Y %H:%M:%S'
echo ""
echo "Date:$(date +"%d/%m/%Y %H:%M:%S")"
#echo "x" | tee -a reseauproj.log 
#}
#main | zenity --text-info --title "RESEAU" --width=1000 --height=1000 --auto-scroll



