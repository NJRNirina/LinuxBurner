from tkinter import *
from ram import get_ram
black_background="#1A1A1A"
text_colors="#F0F0F0"
second_fond="#242424"
accent_blue = "#2979FF"
window=Tk()
window.title("LinuxBURNER")
window.geometry("1280x800")
window.minsize(900,600)
window.config(background=black_background)

#barre de navigation
nav_bar=Frame(window,height=50,bg=second_fond)
nav_bar.pack(fill=X)
nav_bar.pack_propagate(False)
#logo de la barre de navigation
window.mainloop()