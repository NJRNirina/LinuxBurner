from tkinter import *
import matplotlib #fanaovana graphique
from ram import get_ram

def afficher_ram ():
    totale_ram,ram_disponible,ram_utilisee,ram_cache,ram_swap = get_ram()
    label_ram_totale.config(text=totale_ram)
    label_ram_disponible.config(text=ram_disponible)
    label_ram_utilisee.config(text=ram_utilisee)
    label_ram_cache.config(text=ram_cache)
    label_ram_swap.config(text= ram_swap)
    #pourcentage_ram=ram_utilisee*100/totale_ram
    window.after(1000,afficher_ram)
    
black_background="#1A1A1A"
text_colors="#F0F0F0"
second_fond="#242424"
accent_blue = "#2979FF"
button_color_text="#888888"
window=Tk()
icone_barre=PhotoImage(file="../assets/icones/monitoring.png").subsample(10)
window.title("LinuxBURNER")
window.geometry("1280x800")
window.minsize(900,600)
window.config(background=black_background)

#barre de navigation
nav_bar=Frame(window,height=70,bg=second_fond,bd=0)
nav_bar.pack(fill=X)
nav_bar.pack_propagate(False)#amzay tsy miova en foncion anle texte le barre

#creation du logo
logo_text=Label(nav_bar,text="Etat système",padx=40,font=("Fixedsys",16,"bold"))#tokony sary no eo 
logo_text.pack(side=LEFT)

#boutons dans la barre
#activebackground=supprime le flash blanc au clic
#aciveforeground=texte blanc au clic
ram_button=Button(nav_bar,text="RAM",bg=second_fond,bd=0,fg=button_color_text,padx=110,command=afficher_ram,relief=FLAT,
                  activebackground=second_fond,activeforeground=text_colors,font=("Helvetica",11),cursor="hand2")
ram_button.pack(side=LEFT,fill=Y)
cpu_button=Button(nav_bar,text="CPU",bg=second_fond,bd=0,fg=button_color_text,padx=110,
                  activebackground=second_fond,activeforeground=text_colors,font=("Helvetica",11),cursor="hand2")
cpu_button.pack(side=LEFT,fill=Y)
disk_button=Button(nav_bar,text="DISQUE",bg=second_fond,bd=0,fg=button_color_text,padx=110,
                   activebackground=second_fond,activeforeground=text_colors,font=("Helvetica",11),cursor="hand2")
disk_button.pack(fill=Y,side=LEFT)
network_button=Button(nav_bar,text="RÉSEAU",bg=second_fond,bd=0,fg=button_color_text,padx=110,
                      activebackground=second_fond,activeforeground=text_colors,font=("Helvetica",11),cursor="hand2")
network_button.pack(side=LEFT,fill=Y)

#zone centrale
main_frame=Frame(window,background=black_background)
main_frame.pack(fill=BOTH,expand=True)
#sous blocs
card_totale=Frame(main_frame,background=black_background)
card_totale.pack(side=LEFT,padx=8,pady=20)
card_disponible=Frame(main_frame,bg=black_background)
card_disponible.pack(side=LEFT,padx=8,pady=20)
card_utilisee=Frame(main_frame,bg=black_background)
card_utilisee.pack(side=LEFT,padx=8,pady=20)
card_cache=Frame(main_frame,bg=black_background)
card_cache.pack(side=LEFT,padx=8,pady=20)
card_swap=Frame(main_frame,bg=black_background)
card_swap.pack(side=LEFT,padx=8,pady=20)

titre_totale=Label(card_totale,text="TOTALE",bg=second_fond,fg=text_colors,font=("Helvetica"))
titre_totale.pack(anchor=W)
#creation label de RAM 
label_ram_totale=Label(card_totale,bg=black_background,fg=text_colors, font=("Fixedsys", 14))
label_ram_totale.pack(anchor=W,pady=10)
label_ram_disponible=Label(card_disponible,bg=black_background,fg=text_colors,font=("Fixedsys",14))
label_ram_disponible.pack(pady=10)
label_ram_utilisee=Label(card_utilisee,bg=black_background,fg=text_colors, font=("Fixedsys", 14))
label_ram_utilisee.pack(pady=10)
label_ram_cache=Label(card_cache,bg=black_background,fg=text_colors, font=("Fixedsys", 14))
label_ram_cache.pack(pady=10)
label_ram_swap=Label(card_swap,bg=black_background,fg=text_colors, font=("Fixedsys", 14))
label_ram_swap.pack(pady=10)
window.mainloop()