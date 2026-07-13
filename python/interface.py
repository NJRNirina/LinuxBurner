from tkinter import *
from tkinter import filedialog
import re
import matplotlib #fanaovana graphique
matplotlib.use("TkAgg") #manala fenetre ephemre
import matplotlib.pyplot as plt
plt.ioff()
import matplotlib.animation as animation
from ram import get_ram
from cpu import get_cpu
from disk import get_disk, get_file_info
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from cpu import get_cpu
from reseau import get_reseau
import threading 
from tkinter import scrolledtext


after_id = None
running=False  # pour annuler la boucle d'affichage
black_background="#1A1A1A"
text_colors="#F0F0F0"
second_fond="#242424"
accent_blue = "#2979FF"
button_color_text="#888888"
window=Tk()
icone_barre=PhotoImage(file="../assets/icones/monitoring.png").subsample(10)#sary
# Variables globales pour le graphique
ax_graphique = None
canvas_graphique=None
ligne_graphique=None
fig_ram = plt.figure(figsize=(8,3), dpi=100, facecolor=black_background)
# Labels globaux et widgets dynamiques pour le DISQUE
label_disk_part = label_disk_usage = label_disk_alert = None
progress_disk = progress_file = entry_file = None
label_file_path1 = label_file_size1 = None

def afficher_ram():
    global label_ram_totale, label_ram_disponible, label_ram_utilisee, label_ram_cache, label_ram_swap
    global ax_graphique, ligne_graphique, canvas_graphique
    global main_frame
    global running,after_id
    running=False
    if after_id is not None:
        window.after_cancel(after_id)
        after_id = None
        try:
            window.after_cancel(after_id)
        except:
            pass
        after_id = None
        
    canvas_graphique_cpu = None # Coupe le lien avec le dessin CPU
    if hasattr(update_ram, "historique"):
        del update_ram.historique
        del update_ram.temps
        del update_ram.compteur
    for widget in main_frame.winfo_children():#supprime les frames
        widget.destroy()
    #centre
    cards_frame = Frame(main_frame, bg=black_background)
    cards_frame.pack(pady=30)

    #sous blocs de ram 
    card_totale=Frame(cards_frame,background=second_fond)
    card_totale.pack(side=LEFT,padx=8,pady=20)
    card_disponible=Frame(cards_frame,bg=second_fond)
    card_disponible.pack(side=LEFT,padx=8,pady=20)
    card_utilisee=Frame(cards_frame,bg=second_fond)
    card_utilisee.pack(side=LEFT,padx=8,pady=20)
    card_cache=Frame(cards_frame,bg=second_fond)
    card_cache.pack(side=LEFT,padx=8,pady=20)
    card_swap=Frame(cards_frame,bg=second_fond)
    card_swap.pack(side=LEFT,padx=8,pady=20)
    
    #frame pour le graphique
    frame_graphique=Frame(main_frame,bg=black_background)
    frame_graphique.pack(side=BOTTOM, fill=BOTH, expand=True, pady=20)
    fig_ram.clear()
    canvas_graphique = FigureCanvasTkAgg(fig_ram, master=frame_graphique)
    canvas_graphique.get_tk_widget().pack(fill=BOTH, expand=True)
    ax=fig_ram.add_subplot(1,1,1)
    ax.set_facecolor(second_fond)
    ax.set_title("Utilisation de la RAM", color=text_colors)
    ax.set_xlabel("Temps (secondes)", color=text_colors)
    ax.set_ylabel("Go", color=text_colors,rotation=0)
    #la courbe
    ligne, = ax.plot([],[], 'g-', linewidth=2)
    ax_graphique = ax
    ligne_graphique = ligne

    titre_totale=Label(card_totale,text="TOTALE",bg=second_fond,fg=text_colors,font=("Helvetica"))
    titre_totale.pack(anchor=W)
    titre_disponible=Label(card_disponible,text="DISPONIBLE",bg=second_fond,fg=text_colors,font=("Helvetica"))
    titre_disponible.pack(anchor=W)
    titre_utilisee=Label(card_utilisee,text="UTILISÉE",bg=second_fond,fg=text_colors,font=("Helvetica"))
    titre_utilisee.pack(anchor=W)
    titre_cache=Label(card_cache,text="CACHE",bg=second_fond,fg=text_colors,font=("Helvetica"))
    titre_cache.pack(anchor=W)
    titre_swap=Label(card_swap,text="SWAP",bg=second_fond,fg=text_colors,font=("Helvetica"))
    titre_swap.pack(anchor=W)
    #creation label de RAM 
    label_ram_totale=Label(card_totale,bg=second_fond,fg=text_colors, font=("Fixedsys", 14))
    label_ram_totale.pack(anchor=W,pady=10)
    label_ram_disponible=Label(card_disponible,bg=second_fond,fg=text_colors,font=("Fixedsys",14))
    label_ram_disponible.pack(pady=10)
    label_ram_utilisee=Label(card_utilisee,bg=second_fond,fg=text_colors, font=("Fixedsys", 14))
    label_ram_utilisee.pack(pady=10)
    label_ram_cache=Label(card_cache,bg=second_fond,fg=text_colors, font=("Fixedsys", 14))
    label_ram_cache.pack(pady=10)
    label_ram_swap=Label(card_swap,bg=second_fond,fg=text_colors, font=("Fixedsys", 14))
    label_ram_swap.pack(pady=10)
    running=True
    update_ram()

def update_ram ():
    global running,after_id
    if not running:
        return
    global ax_graphique, ligne_graphique, canvas_graphique
    global label_ram_totale, label_ram_disponible, label_ram_utilisee, label_ram_cache, label_ram_swap # amzay hitan'i fonction rehetra
    totale_ram, ram_disponible, ram_utilisee, ram_cache, ram_swap = get_ram()
    totale_ram = float(str(totale_ram).replace(',', '.'))
    ram_disponible = float(str(ram_disponible).replace(',', '.'))
    ram_utilisee = float(str(ram_utilisee).replace(',', '.'))
    ram_cache = float(str(ram_cache).replace(',', '.'))
    ram_swap = float(str(ram_swap).replace(',', '.'))
    #mise à jour des labels
    label_ram_totale.config(text=f"{totale_ram} Go")
    label_ram_disponible.config(text=f"{ram_disponible} Go")
    label_ram_utilisee.config(text=f"{ram_utilisee} Go")
    label_ram_cache.config(text=f"{ram_cache} Go")
    label_ram_swap.config(text=f"{ram_swap} Go")
    #pourcentage_ram=ram_utilisee*100/totale_ram
    if not hasattr(update_ram, "historique"):
        update_ram.historique = []  # Liste pour stocker les valeurs
        update_ram.temps = []       # Liste pour stocker les temps
    update_ram.historique.append(ram_utilisee)
    update_ram.compteur = getattr(update_ram, "compteur", 0) + 1
    update_ram.temps.append(update_ram.compteur)
    if len(update_ram.historique) > 60:
        update_ram.historique.pop(0)
        update_ram.temps.pop(0)
    ligne_graphique.set_data(update_ram.temps, update_ram.historique) #met à jour la courbe
    #limite du graphique
    
    try:
        if canvas_graphique and canvas_graphique.get_tk_widget().winfo_exists():
            ligne_graphique.set_data(update_ram.temps, update_ram.historique)
            if update_ram.compteur <= 60:
                ax_graphique.set_xlim(0, 60)
            else:
                ax_graphique.set_xlim(update_ram.compteur - 60, update_ram.compteur)
            ax_graphique.set_ylim(0, totale_ram)
            canvas_graphique.draw_idle()
    except:
        return # Ignore si l'onglet RAM a été fermé pendant le draw
        
    after_id = window.after(1000, update_ram)

def fermeture():
    global running, after_id
    running = False
    if after_id is not None:
        try:
            window.after_cancel(after_id)
        except:
            pass
    plt.close('all')      # ferme toutes les figures matplotlib
    window.quit()
    window.destroy()
    window.protocol("WM_DELETE_WINDOW", fermeture)

def afficher_cpu():
    global label_Model,label_Core,Label_Usage,label_Heat,label_proces
    global main_frame
    global running,after_id
    running=False
    if after_id is not None:
        window.after_cancel(after_id)
        after_id = None
    if hasattr(update_cpu,"historique"):
        del update_cpu.historique
        del update_cpu.temps
        del update_cpu.compteur
        
    ax_graphique_cpu = None
canvas_graphique_cpu = None
ligne_graphique_cpu = None
fig_cpu = plt.figure(figsize=(8,3), dpi=100, facecolor=black_background)


# Variables globales pour le graphique du CPU
ax_graphique_cpu = None
canvas_graphique_cpu = None
ligne_graphique_cpu = None
fig_cpu = plt.figure(figsize=(8,3), dpi=100, facecolor=black_background)

def afficher_cpu():
    global label_Model, label_Core, label_Usage, label_Heat, label_proces
    global ax_graphique_cpu, canvas_graphique_cpu
    global main_frame
    global running, after_id
    
    running = False
    if after_id is not None:
        window.after_cancel(after_id)
        after_id = None
        
    # Nettoyage de l'historique CPU précédent si on change d'onglet
    if hasattr(update_cpu, "historique"):
        del update_cpu.historique
        del update_cpu.temps
        del update_cpu.compteur
        
    # Rend la zone principale vide proprement  
    global canvas_graphique
    canvas_graphique = None
    for widget in main_frame.winfo_children():
        widget.destroy()

    # Conteneur pour les cases d'informations textuelles
    cards_frame = Frame(main_frame, bg=black_background)
    cards_frame.pack(pady=20)

    # Création des sous-blocs (cards) pour le CPU
    card_model = Frame(cards_frame, background=second_fond)
    card_model.pack(side=LEFT, padx=8, pady=10)
    card_core = Frame(cards_frame, bg=second_fond)
    card_core.pack(side=LEFT, padx=8, pady=10)
    card_usage = Frame(cards_frame, bg=second_fond)
    card_usage.pack(side=LEFT, padx=8, pady=10)
    card_heat = Frame(cards_frame, bg=second_fond)
    card_heat.pack(side=LEFT, padx=8, pady=10)
    card_proces = Frame(cards_frame, bg=second_fond)
    card_proces.pack(side=LEFT, padx=8, pady=10)

    # Titres des cases
    Label(card_model, text="MODÈLE", bg=second_fond, fg=text_colors, font=("Helvetica", 10, "bold")).pack(anchor=W, padx=10, pady=2)
    Label(card_core, text="CŒURS", bg=second_fond, fg=text_colors, font=("Helvetica", 10, "bold")).pack(anchor=W, padx=10, pady=2)
    Label(card_usage, text="UTILISATION", bg=second_fond, fg=text_colors, font=("Helvetica", 10, "bold")).pack(anchor=W, padx=10, pady=2)
    Label(card_heat, text="TEMPÉRATURES", bg=second_fond, fg=text_colors, font=("Helvetica", 10, "bold")).pack(anchor=W, padx=10, pady=2)
    Label(card_proces, text="TOP PROCESSUS", bg=second_fond, fg=text_colors, font=("Helvetica", 10, "bold")).pack(anchor=W, padx=10, pady=2)

    # Labels dynamiques qui recevront les données de cpu.py
    label_Model = Label(card_model, bg=second_fond, fg=text_colors, font=("Fixedsys", 12), wraplength=200)
    label_Model.pack(anchor=W, padx=10, pady=10)
    label_Core = Label(card_core, bg=second_fond, fg=text_colors, font=("Fixedsys", 14))
    label_Core.pack(padx=10, pady=10)
    label_Usage = Label(card_usage, bg=second_fond, fg=text_colors, font=("Fixedsys", 14))
    label_Usage.pack(padx=10, pady=10)
    label_Heat = Label(card_heat, bg=second_fond, fg=text_colors, font=("Fixedsys", 12))
    label_Heat.pack(padx=10, pady=10)
    label_proces = Label(card_proces, bg=second_fond, fg=text_colors, font=("Fixedsys", 11), justify=LEFT)
    label_proces.pack(padx=10, pady=10)

    # Zone du graphique en bas
    frame_graphique_cpu = Frame(main_frame, bg=black_background)
    frame_graphique_cpu.pack(side=BOTTOM, fill=BOTH, expand=True, pady=10)
    
    fig_cpu.clear()
    canvas_graphique_cpu = FigureCanvasTkAgg(fig_cpu, master=frame_graphique_cpu)
    canvas_graphique_cpu.get_tk_widget().pack(fill=BOTH, expand=True)
    
    ax = fig_cpu.add_subplot(1, 1, 1)
    ax.set_facecolor(second_fond)
    ax.set_title("Utilisation Globale du CPU (%)", color=text_colors)
    ax.set_xlabel("Temps (secondes)", color=text_colors)
    ax.set_ylabel("%", color=text_colors, rotation=0)
    
    ax_graphique_cpu = ax
    running = True
    update_cpu()

def update_cpu():
    global running, after_id
    
    # Si l'onglet n'est plus actif, on coupe proprement l'horloge
    if not running:
        if after_id is not None:
            try:
                window.after_cancel(after_id)
            except:
                pass
            after_id = None
        return
        
    # Si la fenêtre principale a été fermée, on arrête tout
    try:
        if not window.winfo_exists():
            return
    except:
        return
        
    global ax_graphique_cpu, canvas_graphique_cpu
    global label_Model, label_Core, label_Usage, label_Heat, label_proces
    
    try:
        # Récupération des données depuis cpu.py
        model, core, usage, heat, proces = get_cpu()
        
        #conversion en float
        usage_clean = usage.replace("%", "").replace(",", ".").strip()
        usage_numeric = float(usage_clean) if usage_clean else 0.0
        
       # Donnees sur les temperatures 
        liste_temps_formatees = []
        compteur_coeur = 1
        
        for temp in heat:
            temp_clean = temp.strip()
            if temp_clean and temp_clean != "0" and temp_clean != "0°C":
                if "°C" not in temp_clean:
                    temp_clean += "°C"
                liste_temps_formatees.append(f"Cœur {compteur_coeur}: {temp_clean}")
                compteur_coeur += 1
        
        heat_str = "\n".join(liste_temps_formatees) if liste_temps_formatees else "N/A"
        
        # Mise à jour des boîtes d'affichage de l'interface
        label_Model.config(text=model.strip())
        label_Core.config(text=f"{core.strip()} Coeurs")
        label_Usage.config(text=f"{usage_numeric}%")
        label_Heat.config(text=heat_str)
        label_proces.config(text=proces.strip() if proces.strip() else "Aucun (>1%)")
        
        # Gestion de l'historique glissant du graphique (60 secondes)
        if not hasattr(update_cpu, "historique"):
            update_cpu.historique = []
            update_cpu.temps = []
            
        update_cpu.historique.append(usage_numeric)
        update_cpu.compteur = getattr(update_cpu, "compteur", 0) + 1
        update_cpu.temps.append(update_cpu.compteur)
        
        if len(update_cpu.historique) > 60:
            update_cpu.historique.pop(0)
            update_cpu.temps.pop(0)
            
        #Creation des affichages graphiques
        try:
            if canvas_graphique_cpu and canvas_graphique_cpu.get_tk_widget().winfo_exists():
                # On efface les barres de la seconde précédente
                ax_graphique_cpu.containers.clear()
                
                # On dessine les nouveaux rectangles
                ax_graphique_cpu.bar(
                    update_cpu.temps, 
                    update_cpu.historique, 
                    color=accent_blue, 
                    width=0.6
                )
                
                # Effet de défilement de l'axe X
                if update_cpu.compteur <= 60:
                    ax_graphique_cpu.set_xlim(0, 61)
                else:
                    ax_graphique_cpu.set_xlim(update_cpu.compteur - 60, update_cpu.compteur + 1)
                    
                ax_graphique_cpu.set_ylim(0, 100)
                canvas_graphique_cpu.draw_idle()
        except:
            return
            
    except Exception as e:
        print(f"Erreur d'update CPU: {e}")
        
    # Planification du prochain rafraîchissement dans 1 seconde
    after_id = window.after(1000, update_cpu)
# --- ONGLETS : DISQUE ---
def afficher_disk():
    global main_frame, running, after_id
    global label_disk_part, label_disk_usage, label_disk_alert, progress_disk
    global label_file_path1, label_file_size1, progress_file, entry_file

    # 1. On arrête proprement les boucles des autres onglets
    running = False
    if after_id is not None:
        try:
            window.after_cancel(after_id)
        except:
            pass
        after_id = None

    # 2. Nettoyage complet de la zone d'affichage principale
    for widget in main_frame.winfo_children():
        widget.destroy()

    # 3. Création des cadres visuels
    cards_frame = Frame(main_frame, bg=black_background)
    cards_frame.pack(pady=10)

    card_part  = Frame(cards_frame, bg=second_fond)
    card_part.pack(side=LEFT, padx=8, pady=5)
    card_usage = Frame(cards_frame, bg=second_fond)
    card_usage.pack(side=LEFT, padx=8, pady=5)
    card_alert = Frame(cards_frame, bg=second_fond)
    card_alert.pack(side=LEFT, padx=8, pady=5)

    Label(card_part,  text="PARTITIONS",  bg=second_fond, fg=text_colors, font=("Helvetica", 10, "bold")).pack(anchor=W, padx=10, pady=2)
    Label(card_usage, text="UTILISATION", bg=second_fond, fg=text_colors, font=("Helvetica", 10, "bold")).pack(anchor=W, padx=10, pady=2)
    Label(card_alert, text="STATUT",      bg=second_fond, fg=text_colors, font=("Helvetica", 10, "bold")).pack(anchor=W, padx=10, pady=2)

    label_disk_part  = Label(card_part,  text="Chargement...", bg=second_fond, fg=text_colors, font=("Fixedsys", 11), justify=LEFT)
    label_disk_part.pack(padx=10, pady=10)
    label_disk_usage = Label(card_usage, text="-- %", bg=second_fond, fg=text_colors, font=("Fixedsys", 14))
    label_disk_usage.pack(padx=10, pady=10)
    label_disk_alert = Label(card_alert, text="ANALYSE", bg=second_fond, fg=text_colors, font=("Helvetica", 12))
    label_disk_alert.pack(padx=10, pady=10)

    # 4. Barre d'utilisation globale (Style ttk)
    card_barres = Frame(main_frame, bg=second_fond)
    card_barres.pack(fill=X, padx=40, pady=10)
    
    from tkinter import ttk
    style = ttk.Style()
    style.theme_use('default')
    style.configure("Disk.Horizontal.TProgressbar", thickness=18, troughcolor=black_background, background=accent_blue, borderwidth=0)
    style.configure("File.Horizontal.TProgressbar", thickness=14, troughcolor=black_background, background="#55FF55", borderwidth=0)
    
    Label(card_barres, text=" Utilisation Globale du Disque (/) :", bg=second_fond, fg=text_colors, font=("Helvetica", 10, "bold")).pack(anchor=W, padx=20, pady=(10, 2))
    progress_disk = ttk.Progressbar(card_barres, style="Disk.Horizontal.TProgressbar", orient="horizontal", mode="determinate")
    progress_disk.pack(fill=X, expand=True, padx=20, pady=(0, 15))

    # 5. Zone Fichier cible
    card_fichier = Frame(main_frame, bg=second_fond)
    card_fichier.pack(fill=BOTH, expand=True, padx=40, pady=10)

    Label(card_fichier, text="SURVEILLANCE D'UN FICHIER CIBLE", bg=second_fond, fg=accent_blue, font=("Helvetica", 12, "bold")).pack(pady=10)

    def parcourir_fichier():
        filename = filedialog.askopenfilename(parent=window, title="Choisir un fichier à surveiller")
        if filename:
            entry_file.delete(0, END)
            entry_file.insert(0, filename)

    btn_parcourir = Button(card_fichier, text="Parcourir...", bg=accent_blue, fg=text_colors, bd=0, relief=FLAT,
                           font=("Helvetica", 11, "bold"), command=parcourir_fichier, cursor="hand2", width=30)
    btn_parcourir.pack(pady=5)

    entry_file = Entry(card_fichier, bg=black_background, fg=text_colors, bd=1, relief=SOLID,highlightthickness=0, insertbackground="white", font=("Helvetica", 11), justify=CENTER, width=70)
    entry_file.pack(pady=5, padx=20, fill=X)

    # On l'insère de manière invisible ou discrète pour stocker le chemin

    result_frame = Frame(card_fichier, bg=second_fond)
    result_frame.pack(fill=X, padx=40, pady=10)

    Label(result_frame, text="Chemin Absolu :", bg=second_fond, fg=button_color_text, font=("Helvetica", 10)).grid(row=0, column=0, sticky=W, pady=2)
    label_file_path1 = Label(result_frame, text="Aucun fichier sélectionné", bg=second_fond, fg=text_colors, font=("Fixedsys", 10), wraplength=500, justify=LEFT)
    label_file_path1.grid(row=0, column=1, sticky=W, padx=10, pady=2)

    Label(result_frame, text="Taille Annotée :", bg=second_fond, fg=button_color_text, font=("Helvetica", 10)).grid(row=1, column=0, sticky=W, pady=2)
    label_file_size1 = Label(result_frame, text="0 Ko", bg=second_fond, fg="#55FF55", font=("Fixedsys", 10, "bold"))
    label_file_size1.grid(row=1, column=1, sticky=W, padx=10, pady=2)

    Label(result_frame, text="Poids Visuel :", bg=second_fond, fg=button_color_text, font=("Helvetica", 10)).grid(row=2, column=0, sticky=W, pady=5)
    progress_file = ttk.Progressbar(result_frame, style="File.Horizontal.TProgressbar", orient="horizontal", mode="determinate", length=400)
    progress_file.grid(row=2, column=1, sticky=W, padx=10, pady=5)

    # 6. On active la boucle de rafraîchissement
    running = True
    update_disk()


def update_disk():
    global running, after_id, label_disk_part, label_disk_usage, label_disk_alert, progress_disk
    global label_file_path1, label_file_size1, progress_file, entry_file
    
    if not running:
        return
        
    try:
        from disk import get_disk, get_file_info
        partitions, usage, pourcent, alerte = get_disk()
        
        # Nettoyage et conversion sécurisée du pourcentage en float/int
        if isinstance(pourcent, str):
            pourcent = int(pourcent.replace("%", "").strip())

        # Mise à jour des composants s'ils existent encore
        if label_disk_part and label_disk_part.winfo_exists():
            label_disk_part.config(text=partitions if partitions else "N/A")
        if label_disk_usage and label_disk_usage.winfo_exists():
            label_disk_usage.config(text=f"{pourcent}% ({usage})")
        if progress_disk and progress_disk.winfo_exists():
            progress_disk['value'] = pourcent
        
        if label_disk_alert and label_disk_alert.winfo_exists():
            if alerte:
                label_disk_alert.config(text=" DISQUE PLEIN", fg="#FF5555")
            else:
                label_disk_alert.config(text=" OK",           fg="#55FF55")
            
        # Surveillance du fichier sélectionné
        if entry_file and entry_file.winfo_exists():
            chemin = entry_file.get().strip()
            if chemin:
                import os
                try:
                    chemin_abs, taille_str, _ = get_file_info(chemin)
                except:
                    chemin_abs, taille_str = chemin, "Erreur lecture"

                if label_file_path1 and label_file_path1.winfo_exists():
                    label_file_path1.config(text=chemin_abs)
                if label_file_size1 and label_file_size1.winfo_exists():
                    label_file_size1.config(text=taille_str)
                
                try:
                    taille_octets = os.path.getsize(chemin)
                    taille_mo = taille_octets / (1024 * 1024)
                    pourcentage_fichier = min((taille_mo / 100.0) * 100, 100) # Max 100%
                    if progress_file and progress_file.winfo_exists():
                        progress_file['value'] = pourcentage_fichier
                except:
                    if progress_file and progress_file.winfo_exists():
                        progress_file['value'] = 0
                        
    except Exception as e:
        print(f"Erreur update_disk : {e}")

    # Relancer toutes les 1 seconde (1000ms)
    after_id = window.after(1000, update_disk)

#reseau
import re

ANSI_VERS_COULEUR = {
    "0;31": "#FF5C5C", "0;32": "#4CD964", "1;33": "#FFD34D",
    "0;33": "#FFD34D", "0;34": "#4FA3FF", "0;35": "#D66FFF",
    "0;36": "#4DE8E8", "0;37": "#F0F0F0",
    "0;91": "#FF5C5C", "0;92": "#4CD964", "0;93": "#FFD34D",
    "0;94": "#4FA3FF", "0;95": "#D66FFF", "0;96": "#4DE8E8",
    "1;31": "#FF5C5C", "1;32": "#4CD964", "1;36": "#4DE8E8",
    "0": None,
}

def inserer_texte_colore(widget, texte):
    """Parse les codes ANSI de `texte` et insère avec les bons tags Tkinter."""
    pattern = re.compile(r'\033\[([0-9;]*)m')
    position = 0
    tag_courant = "normal"

    for match in pattern.finditer(texte):
        morceau = texte[position:match.start()]
        if morceau:
            widget.insert(END, morceau, tag_courant)

        code = match.group(1)
        gras = code.startswith("1")
        couleur = ANSI_VERS_COULEUR.get(code)

        if couleur is None:
            tag_courant = "normal"
        else:
            nom_tag = f"ansi_{code.replace(';', '_')}"
            if nom_tag not in widget.tag_names():
                widget.tag_configure(
                    nom_tag,
                    foreground=couleur,
                    font=("Ubuntu Mono", 11, "bold" if gras else "normal")
                )
            tag_courant = nom_tag

        position = match.end()

    if position < len(texte):
        widget.insert(END, texte[position:], tag_courant)

def actualiser_reseau():
    global text_zone_reseau,bouton_actualiser_reseau
    #1 clic miandry anle donnees voray leizy vo afaka miclic ndray,pour eviter les clics multiples pendant l analyse
    bouton_actualiser_reseau.config(state=DISABLED,text="Actualisaton")
    text_zone_reseau.config(state=NORMAL)
    text_zone_reseau.delete("1.0",END)
    text_zone_reseau.insert(END,"Analyse en cours ...\n")
    text_zone_reseau.config(state=DISABLED)

    def lancer ():
        output=get_reseau()
        def afficher():
            text_zone_reseau.config(state=NORMAL)
            text_zone_reseau.delete("1.0",END)
            text_zone_reseau.tag_configure("normal",font=("Ubuntu Mono",11))
            inserer_texte_colore(text_zone_reseau,output)
            #text_zone_reseau.insert(END,output)
            text_zone_reseau.config(state=DISABLED)
            bouton_actualiser_reseau.config(state=NORMAL,text="Actualiser")
        window.after(0,afficher)

    threading.Thread(target=lancer,daemon=True).start()

def afficher_reseau():
    global main_frame,running,after_id
    global text_zone_reseau,bouton_actualiser_reseau
    running=False
    if after_id is not None:
        window.after_cancel(after_id)
        after_id=None
    for widget in main_frame.winfo_children():
        widget.destroy()

    barre_reseau=Frame(main_frame,bg=black_background)
    barre_reseau.pack(fill=X,padx=20,pady=(20,0))

    bouton_actualiser_reseau=Button(
            barre_reseau,text="Actualiser",
            bg=second_fond,fg=text_colors,bd=0,
            activebackground=accent_blue,activeforeground=text_colors,
            font=("Helvetica",10),cursor="hand2",
            command=actualiser_reseau
            )
    bouton_actualiser_reseau.pack(side=BOTTOM)

    #zone de texte scrollable
    text_zone_reseau=scrolledtext.ScrolledText(
            main_frame,bg="#1A1A1A",fg="#E0E0E0",
            font=("Ubuntu mono",11),bd=0,
            relief=FLAT
            )
    text_zone_reseau.pack(fill=BOTH,expand=True,padx=20,pady=20)
    actualiser_reseau()

window.title("LinuxBURNER")
window.geometry("1280x800")
window.minsize(900,600)
window.config(background=black_background)

#barre de navigation
nav_bar=Frame(window,height=70,bg=second_fond,bd=0)
nav_bar.pack(fill=X)
nav_bar.pack_propagate(False)#amzay tsy miova en foncion anle texte le barre

#creation du logo
logo=Label(nav_bar,image=icone_barre,bg=second_fond,bd=0)#tokony sary no eo 
logo.pack(side=LEFT,fill=BOTH,padx=30)

#boutons dans la barre
#activebackground=supprime le flash blanc au clic
#aciveforeground=texte blanc au clic
ram_button=Button(nav_bar,text="RAM",bg=second_fond,bd=0,fg=button_color_text,command=afficher_ram,relief=FLAT,
                  activebackground=second_fond,activeforeground=text_colors,font=("Helvetica",11),cursor="hand2")
ram_button.pack(side=LEFT,fill=BOTH,expand=YES)
cpu_button=Button(nav_bar,text="CPU",bg=second_fond,bd=0,fg=button_color_text,
                  command=afficher_cpu,
                  activebackground=second_fond,activeforeground=text_colors,font=("Helvetica",11),cursor="hand2")
cpu_button.pack(side=LEFT,fill=BOTH,expand=YES)
disk_button=Button(nav_bar,text="DISQUE",bg=second_fond,bd=0,fg=button_color_text,command=afficher_disk,
                   activebackground=second_fond,activeforeground=text_colors,font=("Helvetica",11),cursor="hand2")
disk_button.pack(fill=BOTH,side=LEFT,expand=YES)
network_button=Button(nav_bar,text="RÉSEAU",bg=second_fond,bd=0,fg=button_color_text,command=afficher_reseau,
                      activebackground=second_fond,activeforeground=text_colors,font=("Helvetica",11),cursor="hand2")
network_button.pack(side=LEFT,fill=BOTH,expand=YES)

#zone restante
main_frame=Frame(window,background=black_background)
main_frame.pack(fill=BOTH,expand=True)
def quitter_application():
    global running, after_id
    running = False 
    
    # 1. On annule la boucle infinie de rafraîchissement
    if after_id is not None:
        try:
            window.after_cancel(after_id)
        except:
            pass
        after_id = None
        
    # 2. FORCE LA FERMETURE DE MATPLOTLIB (La clé du problème !)
    try:
        plt.close('all') # Ferme toutes les figures (fig_ram et fig_cpu)
    except:
        pass
        
    # 3. On détruit proprement les fenêtres de l'interface
    try:
        window.quit()
        window.destroy()
    except:
        pass

window.protocol("WM_DELETE_WINDOW", quitter_application)
window.mainloop()

