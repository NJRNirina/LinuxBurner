from tkinter import *
from ram import get_ram

def afficher_ram ():
    totale_ram,ram_disponible,ram_utilisee,ram_cache,ram_swap = get_ram()
    label_ram_totale.config(text=f"RAM totale : {totale_ram}")
    label_ram_disponible.config(text=f"RAM disponible : {ram_disponible}")
    label_ram_utilisee.config(text=f"RAM utilisée : {ram_utilisee}")
    label_ram_cache.config(text=f"RAM cache : {ram_button}")
    label_ram_swap.config(text=f"RAM swap : {ram_swap}")
    
    

black_background="#1A1A1A"
text_colors="#F0F0F0"
second_fond="#242424"
accent_blue = "#2979FF"
button_color_text="#888888"
window=Tk()
#icone_barre=PhotoImage(file="/home/nirina/Projet/LinuxBurner/assets/icones/assets/icones/monitoring.png")
window.title("LinuxBURNER")
window.geometry("1280x800")
window.minsize(900,600)
window.config(background=black_background)


#barre de navigation
nav_bar=Frame(window,height=70,bg=second_fond)
nav_bar.pack(fill=X)
nav_bar.pack_propagate(False)#amzay tsy miova en foncion anle texte le barre


#creation du logo
logo_text=Label(nav_bar,text="Etat système",padx=40,font=("Fixedsys",16,"bold"))#tokony sary no eo 
logo_text.pack(side=LEFT)
#boutons dans la barre
ram_button=Button(nav_bar,text="RAM",bg=second_fond,bd=0,fg=button_color_text,padx=100)
ram_button.pack(side=LEFT,fill=Y)

cpu_button=Button(nav_bar,text="CPU",bg=second_fond,bd=0,fg=button_color_text,padx=100)
cpu_button.pack(side=LEFT,fill=Y)
disk_button=Button(nav_bar,text="DISQUE",bg=second_fond,bd=0,fg=button_color_text,padx=100)
disk_button.pack(fill=Y,side=LEFT)
network_button=Button(nav_bar,text="RÉSEAU",bg=second_fond,fg=button_color_text,padx=100)
network_button.pack(side=LEFT,fill=Y)

#zone centrale
main_frame=Frame(window,background=black_background)
main_frame.pack(fill=BOTH,expand=True)

#cretaion label
label_ram_totale=Label(main_frame,text="RAM totale : ",bg=black_background,fg=text_colors, font=("Fixedsys", 14))
label_ram_totale.pack(pady=50)
window.mainloop()