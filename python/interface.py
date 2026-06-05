from tkinter import *
import matplotlib #fanaovana graphique
from ram import get_ram
def afficher_ram():
    global label_ram_totale, label_ram_disponible, label_ram_utilisee, label_ram_cache, label_ram_swap
    for widget in main_frame.winfo_children():
        widget.destroy()
    #centre
    cards_frame = Frame(main_frame, bg=black_background)
    cards_frame.place(relx=0.5, rely=0.3, anchor=CENTER)
    #sous blocs
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
    update_ram()

def update_ram ():
    global label_ram_totale, label_ram_disponible, label_ram_utilisee, label_ram_cache, label_ram_swap # amzay hitan'i fonction rehetra
    totale_ram, ram_disponible, ram_utilisee, ram_cache, ram_swap = get_ram()
    totale_ram,ram_disponible,ram_utilisee,ram_cache,ram_swap = get_ram()
    label_ram_totale.config(text=f"{totale_ram} Go")
    label_ram_disponible.config(text=f"{ram_disponible} Go")
    label_ram_utilisee.config(text=f"{ram_utilisee} Go")
    label_ram_cache.config(text=f"{ram_cache} Go")
    label_ram_swap.config(text=f"{ram_swap} Go")
    #pourcentage_ram=ram_utilisee*100/totale_ram
    window.after(1000,update_ram)

black_background="#1A1A1A"
text_colors="#F0F0F0"
second_fond="#242424"
accent_blue = "#2979FF"
button_color_text="#888888"
window=Tk()
icone_barre=PhotoImage(file="../assets/icones/monitoring.png").subsample(10)#sary
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
