from tkinter import *
import matplotlib #fanaovana graphique
matplotlib.use("TkAgg") #manala fenetre ephemre
import matplotlib.pyplot as plt
plt.ioff()
import matplotlib.animation as animation
from ram import get_ram
from cpu import get_cpu
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg


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

def afficher_ram():
    global label_ram_totale, label_ram_disponible, label_ram_utilisee, label_ram_cache, label_ram_swap
    global ax_graphique, ligne_graphique, canvas_graphique
    global main_frame
    global running,after_id
    running=False
    if after_id is not None:
        window.after_cancel(after_id)
        after_id = None
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
    if update_ram.compteur <= 60:
        ax_graphique.set_xlim(0, 60)
    else:
        ax_graphique.set_xlim(update_ram.compteur - 60, update_ram.compteur)
    ax_graphique.set_ylim(0, totale_ram)
    canvas_graphique.draw_idle()#rafraichit l'affichage
    after_id=window.after(1000, update_ram)    

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
    for widget in main_frame_winfo_children():
        widget.destroy()


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
                  activebackground=second_fond,activeforeground=text_colors,font=("Helvetica",11),cursor="hand2")
cpu_button.pack(side=LEFT,fill=BOTH,expand=YES)
disk_button=Button(nav_bar,text="DISQUE",bg=second_fond,bd=0,fg=button_color_text,
                   activebackground=second_fond,activeforeground=text_colors,font=("Helvetica",11),cursor="hand2")
disk_button.pack(fill=BOTH,side=LEFT,expand=YES)
network_button=Button(nav_bar,text="RÉSEAU",bg=second_fond,bd=0,fg=button_color_text,
                      activebackground=second_fond,activeforeground=text_colors,font=("Helvetica",11),cursor="hand2")
network_button.pack(side=LEFT,fill=BOTH,expand=YES)

#zone restante
main_frame=Frame(window,background=black_background)
main_frame.pack(fill=BOTH,expand=True)


window.mainloop()

