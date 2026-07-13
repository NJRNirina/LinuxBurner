import os
import shutil
import subprocess

def get_partitions():
    """
    Équivalent de : df -h | grep /dev/ | awk '{print $1,$2}'  (voir projet1.sh)
    Retourne un texte listant chaque partition /dev/ réelle avec sa taille.
    """
    try:
        resultat = subprocess.run(["df", "-h"], capture_output=True, text=True, check=True)
        lignes = resultat.stdout.splitlines()

        partitions = []
        for ligne in lignes:
            if "/dev/" in ligne:
                colonnes = ligne.split()
                nom = colonnes[0]           # ex: /dev/sda2
                taille = colonnes[1]        # ex: 500G
                montage = colonnes[-1]      # ex: /
                partitions.append(f"{nom} ({taille}) → {montage}")

        return "\n".join(partitions) if partitions else "Aucune partition /dev/ trouvée."
    except Exception as e:
        print(f"Erreur get_partitions dans disk.py : {e}")
        return "N/A"

def get_disk():
    """
    Récupère les informations d'utilisation globale de la partition racine (/).
    Retourne : (texte_partitions, texte_utilisation, pourcentage, alerte_bool)
    """
    try:
        total, used, free = shutil.disk_usage("/")
        total_go = total / (1024**3)
        used_go = used / (1024**3)
        pourcentage = int((used / total) * 100)
        
        texte_utilisation = f"{used_go:.1f}G / {total_go:.1f}G"
        texte_partitions = get_partitions()
        alerte = pourcentage > 90
        
        return texte_partitions, texte_utilisation, pourcentage, alerte
    except Exception as e:
        print(f"Erreur get_disk dans disk.py : {e}")
        return "N/A", "0G / 0G", 0, False


def get_file_info(chemin):
    """
    Analyse un fichier ciblé pour la surveillance en temps réel.
    Retourne : (chemin_absolu, taille_formatee, taille_octets)
    """
    if not chemin or not os.path.exists(chemin):
        return "Aucun fichier sélectionné", "0 Ko", 0
        
    try:
        chemin_abs = os.path.abspath(chemin)
        taille_octets = os.path.getsize(chemin_abs)
        
        if taille_octets < 1024:
            taille_str = f"{taille_octets} Octets"
        elif taille_octets < 1024 * 1024:
            taille_str = f"{taille_octets / 1024:.2f} Ko"
        else:
            taille_str = f"{taille_octets / (1024 * 1024):.2f} Mo"
            
        return chemin_abs, taille_str, taille_octets
    except Exception as e:
        print(f"Erreur get_file_info dans disk.py : {e}")
        return "Erreur de lecture", "0 Ko", 0
