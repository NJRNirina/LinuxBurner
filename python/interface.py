from tkinter import *
from ram import get_ram
black_background="#1A1A1A"
text_colors="#F0F0F0"
second_fond="#242424"

window=Tk()
window.title("LinuxBURNER")
window.geometry("1280x800")
window.minsize(900,600)
window.config(background=black_background)

#menu superieure
frame_menu=Frame(window,height=100,width=400,bg=second_fond)
frame_menu.pack(fill=X)

ram_frame=Frame(frame_menu,height=100,width=100,bg="white")
ram_button=Button(ram_frame,text="RAM",bg=second_fond,fg=text_colors)
ram_frame.grid(row=0,column=0,sticky="nsnew")
ram_button.place(relx=0.25,rely=0.25)
window.mainloop()