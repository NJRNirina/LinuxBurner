#!/bin/bash
# Moniteur de disque avec alertes — basé sur tes variables
# Affiche chaque variable et avertit si le seuil est dépassé

#trouver le fichier texte

i       #  remplace $fichier par ton nom de fichier
# Si tu veux un chemin fixe : FICHIER="/home/rene/rapport.txt"

SEUIL_DISQUE=80                       #  seuil d'alerte disque en %

# ──── Disque ────
Memoiremorte=$(df -h | grep /dev/ | awk '{print $1,$2}')
# Liste les partitions /dev/ avec leur taille totale

Memoireutiliserengenerae=$(df -h | awk '{print $1,$5}' | tr -d "%")
# Récupère le % d'utilisation de chaque partition (enlève le signe %)

Memoirefichier=$(cd $FICHIER 2>/dev/null | echo $(du -h) | cd)
# Taille du fichier cible (si il existe)

partitionnement=$(lsblk | grep loop | awk '{print $1,$2}')
# Liste les partitions loop (ex: snap)


echo "Entrer le fichier cible"
read fichier
FICHIER=$(readlink -f "$fichier") 
memoirelibre=$(free -h | grep Mem | awk '{print $4}')
# Mémoire RAM libre
echo ""
echo "       RAPPORT SYSTÈME — $(date +%H:%M)         "
echo ""



# ─ 1. Partitions /dev/ ──
echo ""
echo "── 1. Partitions détectées (Memoiremorte) ──"
if [[ -n "$Memoiremorte" ]]; then
#   -n = vrai si la variable n'est PAS vide
  echo "$Memoiremorte"
else
  echo "   Aucune partition /dev/ trouvée."
fi

# ── 2. % utilisation de chaque partition (avec alerte) ──
echo ""
echo "── 2. Utilisation disque (Memoireutiliserengenerae) ──"
if [[ -n "$Memoireutiliserengenerae" ]]; then
  echo "$Memoireutiliserengenerae"

#   Vérification du seuil sur la partition racine /
  POURCENT=$(df / | awk 'NR==2 {gsub("%",""); print $5}')
#   NR==2 = 2ème ligne, gsub enlève le %, $5 = colonne Use%
  if [[ -n "$POURCENT" ]] && (( POURCENT >= SEUIL_DISQUE )); then
    echo ""
    echo "   ALERTE : disque / utilisé à ${POURCENT}% (seuil : ${SEUIL_DISQUE}%)"
  elif [[ -n "$POURCENT" ]]; then
    echo ""
    echo "   Disque / OK : ${POURCENT}% utilisé (seuil : ${SEUIL_DISQUE}%)"
  fi
else
  echo "   Impossible de lire l'utilisation disque."
fi

# ── 3. Taille du fichier cible ──
echo ""
echo "── 3. Fichier cible (Memoirefichier) ──"
echo "   Chemin : $FICHIER"
if [[ -e "$FICHIER" ]]; then
#   -e = vrai si le fichier OU dossier existe
  if [[ -f "$FICHIER" ]]; then
#     -f = c'est un fichier ordinaire
    TAILLE=$(du -sh "$FICHIER" | awk '{print $1}')
    echo "   Fichier trouvé — taille : $TAILLE"
  elif [[ -d "$FICHIER" ]]; then
#     -d = c'est un dossier
    TAILLE=$(du -sh "$FICHIER" | awk '{print $1}')
    echo "   Dossier trouvé — taille : $TAILLE"
  fi
else
  echo "   Le fichier/dossier n'existe pas : $FICHIER"
fi

# ── 4. Partitions loop ──
echo ""
echo "── 4. Partitions loop (partitionnement) ──"
if [[ -n "$partitionnement" ]]; then
  echo "$partitionnement"
else
  echo " Aucune partition loop détectée."
fi



echo "             FIN DU RAPPORT              "
echo ""
exit 0 

