#!/bin/bash

JAUNE_VIF='\033[0;93m'
BLEU_VIF='\033[0;94m'
MAGENTA_VIF='\033[0;95m'
CYAN_VIF='\033[0;96m'
ROUGE_GRAS='\033[1;31m'
VERT_GRAS='\033[1;32m'
RESET='\033[0m'

#Etape 1:identité de la machine
echo -e "\t${CYAN_VIF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e  "\t\t${CYAN_VIF}ETAPE 1: IDENTITÉ DE LA MACHINE${RESET}"
echo -e "\t${CYAN_VIF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

#hostname=nom de la machine
HOSTNAME=$(hostname)
echo -e "${BLEU_VIF}•Nom de la machine:${RESET}$HOSTNAME"

#IP local (LAN) =IP publique
IP_LOCALE=$(hostname -I | awk '{print $1}')
if [ -z "$IP_LOCALE" ];then
	IP_LOCALE="non connecte,impossible d'afficher l'ip locale."
fi	
echo -e "${BLEU_VIF}•IP locale:${RESET}$IP_LOCALE"
#IP publique (WAN)
if command -v curl &> /dev/null; then #-v veifie que la cmd existe
	IP_PUBLIQUE=$(curl -s --max-time 10 ifconfig.me)
	if [ -z "$IP_PUBLIQUE" ];then 
		IP_PUBLIQUE="pas d'internet,impossible d'afficher l'ip publique."
	fi	
else
	IP_PUBLIQUE="impossible de verifier l'IP publique:curl non installee,veuillez l'installer via sudo apt install curl."
fi
echo -e "${BLEU_VIF}•IP publique:${RESET}$IP_PUBLIQUE"

#adresse MAC
MAC=$(ip a | grep 'link/ether' | awk '{print $2}' | head -1)
echo -e "${BLEU_VIF}•Adresse MAC:${RESET}$MAC"

#inteface réseau active
INTERFACE_ACTIVE=$(ip link show | awk -F': ' '/^[0-9]+:/{print "\t-"$2}')
if [ -z "$INTERFACE_ACTIVE" ];then
	echo -e "${BLEU_VIF}•Interface active:${RESET}aucune interface active."
else	
	echo -e "${BLEU_VIF}•Interface active:${RESET}"
	echo -e "${MAGENTA_VIF}$INTERFACE_ACTIVE${RESET}"
	
fi	

echo ""


#Etape 2:traffic réseau (octets reçus et envoyés)
echo -e "\t${CYAN_VIF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "\t\t${CYAN_VIF}ETAPE 2: TRAFFIC RESEAU (OCTETS REÇUS ET ENVOYÉS)${RESET}"
echo -e "\t${CYAN_VIF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

echo ""

tail -n +3 /proc/net/dev | while read -r ligne;do
INTERFACE=$(echo "$ligne" | awk -F':' '{print $1}')
STATS=$(echo "$ligne" | awk -F':' '{print $2}')
RX_BYTES=$(echo "$STATS" | awk '{print $1}') #ocets envoyés
TX_BYTES=$(echo "$STATS" | awk '{print $9}') #octets reçus

#conversion en mo , 1mo =1 048 576 | bc=bash calculator
RX_MO=$(echo "$RX_BYTES/1048576" | bc)
TX_MO=$(echo "$TX_BYTES/1048576" | bc)
echo -e "${BLEU_VIF}•Interfaces actives:${RESET} $INTERFACE"
echo -e "${BLEU_VIF}•Octets envoyés (en Mo):${RESET} $RX_MO"
echo -e "${BLEU_VIF}•Octets reçus (en Mo):${RESET} $TX_MO"
done
echo ""

#Etape 3:test connectivité
echo -e "\t${CYAN_VIF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "\t\t${CYAN_VIF}ETAPE 3: TEST CONNECTIVITÉ${RESET}"
echo -e "\t${CYAN_VIF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

echo ""

#test ping,DNS,latence

#test connectivité vers google
echo -e "${BLEU_VIF}•Test connectivité vers google:${RESET}"
ping -c 3 8.8.8.8 >/dev/null 2>&1
PING_RESULT=$? #tsy napety anle teo an tonga d le echo no captureny f tsy le ping
if [ $PING_RESULT -eq 0 ] ;then #$? code de retour en bash,0=succès,1=échec
	echo -e "\t${VERT_GRAS}→ Internet accessible.${RESET} "
else
	echo -e "\t${ROUGE_GRAS}→ Pas d'accès à internet.${RESET}"	
fi

#test DNS
echo ""
echo -e "${BLEU_VIF}•Test DNS:${RESET}"
DNS=$(nslookup google.com | grep -A1 'Name:' | grep 'Address:' | head -1 | awk '{print $2}') #-A:affiche une ligne après celle que l'on atrouvé (After)
if [ -n "$DNS" ]; then #-n vérifie si la chaine n'est pas vide
	echo -e  "\t${VERT_GRAS}→ DNS fonctionne.${RESET}"
else
	echo -e "\t${ROUGE_GRAS}→ DNS ne fonctionne pas! Sites web inaccessibles.${RESET}"
fi
echo ""

#test latence vers google
#latence(temps de réponse): temps que met un paquet pour aller et revenir d'une machine
#Faible latence (< 50ms)=connexion rapide
#Latence moyenne (50-150ms)=connexion correcte
#Latence élevée (> 150ms)=connexion lente ou surchargée

RESULT=$(ping -c 3 8.8.8.8 2>/dev/null) #8.8.8.8=IP de google
PING2=$?
if [ $PING2 -eq 0 ] ;then
	LATENCE=$(echo "$RESULT" | tail -1 | awk -F'/' '{print $5}')
	if [ $(echo "$LATENCE < 50") ]; then
		echo -e "${VERT_GRAS}---> Connexion rapide.${RESET}"
	elif [ $(echo "$LATENCE > 150") ]; then
		echo -e "${JAUNE_VIF}---> Connexion normale.${RESET}"
	else
		echo -e "${ROUGE_GRAS}---> Connexion lente.${RESET}"
	fi
else
	echo -e "${ROUGE_GRAS}---> Pas d'accès à google.com.${RESET}"
fi
echo ""

#étape 4:services en écoutes (ports et connexions)
echo -e "\t${CYAN_VIF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "\t\t${CYAN_VIF}ETAPE 4: SERVICES EN ÉCOUTE (PORTS OUVERTS ET CONNEXIONS ACTIVES)${RESET}"
echo -e "\t${CYAN_VIF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""
#ports en écoute
#ss -tulp

LISTE_DE_PORTS_EN_ECOUTE=$(ss -tulp | awk 'NR>1{n=split($5, a, ":"); print "\t-"a[n]}')
echo -e "${BLEU_VIF}•Liste des ports en écoute:${RESET}"
echo -e "$LISTE_DE_PORTS_EN_ECOUTE"
echo ""
NB_DE_PORTS_EN_ECOUTE=$(ss -tuln | awk '{n=split($5, a, ":"); print a[n]}' | wc -l)
echo -e "${BLEU_VIF}•Le nombre de ports en ecoute:${RESET}${JAUNE_VIF}$NB_DE_PORTS_EN_ECOUTE${RESET}"
echo ""

#connexions ouverts
echo -e "${BLEU_VIF}•Le nombre de connexions actives:${RESET}"
NB_ESTABLISHED=$(ss -tn | grep -c 'ESTAB') #-c compte le nb qui contient le mot
NB_TIME_WAIT=$(ss -tn | grep -c 'TIME-WAIT')
NB_CLOSE_WAIT=$(ss -tn | grep -c 'CLOSE-WAIT')
echo -e "\t${BLEU_VIF}-Nombre de connexion active en cours:${RESET}${JAUNE_VIF}$NB_ESTABLISHED${RESET}"
echo -e "\t${BLEU_VIF}-Nombre de connexion en fermeture:${RESET}${JAUNE_VIF}$NB_TIME_WAIT${RESET}"
echo -e "\t${BLEU_VIF}-Nombre de connexion en attente de fermeture:${RESET}${JAUNE_VIF}$NB_CLOSE_WAIT${RESET}"
echo ""

echo -e "\t${CYAN_VIF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "\t${CYAN_VIF}Rapport du: Date:$(date +"%d/%m/%Y %H:%M:%S")${RESET}"
echo -e "\t${CYAN_VIF}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"





