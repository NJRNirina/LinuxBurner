#!/bin/bash
#FAHAZARANA LE MAMPIASA ENG 
#Tools for LinuxBurner

#color_palet
Black="\e[0;30m"
Red="\e[0;31m"
Green="\e[0;32m"
Yellow="\e[0;33m"
Blue="\e[0;34m"
Purple="\e[0;35m"
Cyan="\e[0;36m"
White="\e[0;37m"
Reset="\e[0m"

#THIS FUNCTION IS USED TO TRAP SINGINT(CTRL + C zan xD)
SINGINT()
{
	echo -e "\n${Red}INSTALLATION STOPPED${Reset}\nremoving unfinished installationion"
	if sudo -S pacman -h <<</dev/null &>/dev/null;
	then
			yes|sudo -S pacman -Rns tk matplotlib <<<  $PASSWD &>/dev/null
			echo -e "\nCLEANING"
        	echo -n -e "\r${Red}[==>               ]" && sleep 1
        	echo -n -e "\r[====>             ]" && sleep 1
        	echo -n -e "\r[=========>        ]" && sleep 1
        	echo -n -e "\r[=============>    ]" && sleep 1
        	echo -n -e "\r[=================>]" && sleep 0.5
        	echo -n -e "\r[==================]${Reset}\n"
			exit 2 #different error code 
	elif command -v apt &>/dev/null;
	then 
			yes|sudo -S apt purge python3-tk python3-matplotlib <<<  $PASSWD &>/dev/null
			echo -e "\nCLEANING"
        	echo -n -e "\r${Red}[==>               ]" && sleep 1
        	echo -n -e "\r[====>             ]" && sleep 1
        	echo -n -e "\r[=========>        ]" && sleep 1
        	echo -n -e "\r[=============>    ]" && sleep 1
        	echo -n -e "\r[=================>]" && sleep 0.5
        	echo -n -e "\r[==================]${Reset}\n"
			exit 2 #different error code
	elif sudo dnf -h &>/dev/null;
	then

			yes|sudo -S dnf install python3-tkinter python3-matplotlib <<<  $PASSWD &>/dev/null
			echo -e "\nCLEANING"
        	echo -n -e "\r${Red}[==>               ]" && sleep 1
        	echo -n -e "\r[====>             ]" && sleep 1
        	echo -n -e "\r[=========>        ]" && sleep 1
        	echo -n -e "\r[=============>    ]" && sleep 1
        	echo -n -e "\r[=================>]" && sleep 0.5
        	echo -n -e "\r[==================]${Reset}\n"
			exit 2 #different error code
	fi
}

home=$HOME
echo " _     ___ _   _ _   ___  ______  _   _ ____  _   _ _____  
| |   |_ _| \ | | | | \ \/ / __ )| | | |  _ \| \ | | ____|  _ \ 
| |    | ||  \| | | | |\  /|  _ \| | | | |_) |  \| |  _| | |_) |
| |___ | || |\  | |_| |/  \| |_) | |_| |  _ <| |\  | |___|  _ < 
|_____|___|_| \_|\___//_/\_\____/ \___/|_| \_\_| \_|_____|_| \_\ "
echo -e -n "Enter your password : "
read -s PSWD
REP=$(sudo -S find $home -name "LinuxBurner" <<< $PSWD |head -1)
echo
#VERIFYING IF THE INSTALLATION IS EXECUTED BY THE SUPERUSER
#TESTING CONNEXION
trap SINGINT INT
if ping -c1 youtube.com &>/dev/null; #Youtube ihn mande ao am pianarana xD 
#(youtube.com is the only way to check if the computer can have access to internet in our class)
then
		echo -e "${Blue}VERIFYING CONNEXION ACCESS${Reset}"
    	echo -n -e "\r${Cyan}[==>               ]" && sleep 1
    	echo -n -e "\r[====>             ]" && sleep 1
        echo -n -e "\r[=========>        ]" && sleep 1
		echo -n -e "\r[=============>    ]" && sleep 1				
		echo -n -e "\r[=================>]" && sleep 0.5
    	echo -n -e "\r[==================]${Reset}\n"
	#TESTING DISTRO 
	if  sudo pacman -h <<< $PSWD &>/dev/null ; #verifying the distro family
	then
		echo "INSTALLING TKINTER"
		if python3 -c "import tkinter" &> /dev/null;then 
		#this return 0 if tkinter already exists
						echo -e "INSTALLATION [status]:${Red}failed${Reset}\nTKINTER IS ALREADY ${Green}INSTALLED\n"
                        echo -n "... " && sleep 0.5
                        echo -e  "......\n${Reset}"
		else
			yes|sudo pacman -Sy &>/dev/null && yes|sudo pacman -S tk &>/dev/null
                        echo -e "UPDATING"
                        echo -n -e "\r${Red}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                       	echo -n -e "\r[=============>    ]" && sleep 1
			echo -n -e "\r[=================>]" && sleep 0.5
			echo -n -e "\r[==================]${Reset}\n"

			echo "CHECKING FOR DEPENCIES"
                        echo -n -e "\r${Cyan}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                        echo -n -e "\r[=============>    ]" && sleep 1
                        echo -n -e "\r[=================>]" && sleep 0.5
                        echo -n -e "\r[==================]${Reset}\n"

                        printf "INSTALLING TKINTER\n"
                        echo -n -e "\r${Purple}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                        echo -n -e "\r[=============>    ]" && sleep 1
                        echo -n -e "\r[=================>]" && sleep 0.5
                        echo -n -e "\r[==================]${Reset}\n"
			printf "TKINTER : ${Green}INSTALLED${Reset}"
			echo
			sleep 2
		fi
		#matplotlib installation (tools for graph)
		if python3 -c "import matplotlib " &>/dev/null ;then
		#Dasame as Tkinter xD
			echo "INSTALLING MATPLOTLIB"
			echo -e "INSTALLATION [status]:${Red}failed${Reset}\nMATPLOTLIB IS ALREADY ${Green}INSTALLED"
			echo -n "..." && sleep 0.5
			echo -e "...\n${Reset}"
		else
			yes| sudo pacman -Sy  &> /dev/null && yes |sudo pacman -S python-matplotlib &>/dev/null
			echo "CHECKING FOR DEPENCIES"
			echo -n -e "\r${Cyan}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                        echo -n -e "\r[=============>    ]" && sleep 1
                        echo -n -e "\r[=================>]" && sleep 0.5
                        echo -n -e "\r[==================]${Reset}\n"
	
			echo "INSTALLING MATPLOTLIB"
			echo -n -e "\r${Purple}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                        echo -n -e "\r[=============>    ]" && sleep 1
                        echo -n -e "\r[=================>]" && sleep 0.5
                        echo -n -e "\r[==================]${Reset}\n"

			echo -e "MATPLOTLIB : ${Green}INSTALLED${Reset}"
			echo 

			sleep 2
			#ICON CREATION
			printf "LINUXBURNER ICON\n"
			if [[ -d "$home/Desktop" ]];
			then
				if [[ -f "$home/Desktop/Linux_Burner.desktop" ]];
				then
					rm $home/Desktop/Linux_Burner.desktop 
					printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py 2>/dev/null\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Desktop/Linux.Burner.desktop
					echo -e "${Yellow}GIVING THE RIGHT PERMISSION TO THE APP ${Reset}"
					sudo -S chmod +x $home/Desktop/Linux_Burner.desktop <<< $PASS
					echo "ICON CREATED : ${Green}SUCESS${Reset}"
				else
					printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py 2>/dev/null\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Desktop/Linux_Burner.desktop
					echo -e "${Yellow}GIVING THE RIGHT PERMISSION TO THE APP ${Reset}"
					sudo -S chmod +x $home/Desktop/Linux_Burner.desktop <<< $PASS
					echo "ICON CREATED : ${Green}SUCESS${Reset}"
				fi
			elif [[ -d "$home/Bureau" ]];
			then
				if [[ -f "$home/Bureau/Linux_Burner.bureau" ]];
                	        then

                	                rm $home/Bureau/Linux_Burner.bureau
                    	            printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py 2>/dev/null\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Bureau/Linux.Burner.bureau
                        	        echo -e "${Yellow}GIVING THE RIGHT PERMISSION TO THE APP ${Reset}"
                            	    sudo -S chmod +x $home/Bureau/Linux_Burner.desktop <<< $PASS
									echo "ICON CREATED : ${Green}SUCESS${Reset}"
                        	else
                        	        printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py 2>/dev/null\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Bureau/Linux_Burner.desktop
                        	        echo -e "${Yellow}GIVING THE RIGHT PERMISSION TO THE APP ${Reset}"
                        	        sudo -S chmod +x $home/Bureau/Linux_Burner.desktop <<< $PASS
									echo "ICON CREATED : ${Green}SUCESS${Reset}"
                        	fi
				fi
			fi
		fi

	elif command -v apt &>/dev/null;
	then
		echo "DEBIAN"
		echo "INSTALLING TKINTER"
		if python3 -c "import tkinter" &> /dev/null;then 
		#this return 0 if tkinter already exists
			echo -e "INSTALLATION [status]:${Red}failed${Reset}\nTKINTER IS ALREADY ${Green}INSTALLED\n"
                        echo -n -e "\r... " && sleep 0.5
                        echo -e  "\r......\n${Reset}"
		else
			yes|sudo apt update &>/dev/null && yes|sudo pacman apt install python3-tk &>/dev/null
                        echo -e "UPDATING"
                        echo -n -e "\r${Red}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                       	echo -n -e "\r[=============>    ]" && sleep 1
			echo -n -e "\r[=================>]" && sleep 0.5
			echo -n -e "\r[==================]${Reset}\n"

			echo "CHECKING FOR DEPENCIES"
                        echo -n -e "\r${Cyan}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                        echo -n -e "\r[=============>    ]" && sleep 1
                        echo -n -e "\r[=================>]" && sleep 0.5
                        echo -n -e "\r[==================]${Reset}\n"

                        printf "INSTALLING TKINTER\n"
                        echo -n -e "\r${Purple}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                        echo -n -e "\r[=============>    ]" && sleep 1
                        echo -n -e "\r[=================>]" && sleep 0.5
                        echo -n -e "\r[==================]${Reset}\n"
			printf "TKINTER : ${Green}INSTALLED${Reset}"
			echo
			sleep 2
		fi
		#matplotlib installation (tools for graph)
		if python3 -c "import matplotlib " &>/dev/null ;then
		#Dasame as Tkinter xD
			echo "INSTALLING MATPLOTLIB"
			echo -e "INSTALLATION [status]:${Red}failed${Reset}\nMATPLOTLIB IS ALREADY ${Green}INSTALLED"
			echo -n "..." && sleep 0.5
			echo -e "...\n${Reset}"
		else
			yes| sudo apt update  &> /dev/null && yes |sudo apt install python3-matplotlib &>/dev/null
			echo "CHECKING FOR DEPENCIES"
			echo -n -e "\r${Cyan}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                        echo -n -e "\r[=============>    ]" && sleep 1
                        echo -n -e "\r[=================>]" && sleep 0.5
                        echo -n -e "\r[==================]${Reset}\n"
	
			echo "INSTALLING MATPLOTLIB"
			echo -n -e "\r${Purple}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                        echo -n -e "\r[=============>    ]" && sleep 1
                        echo -n -e "\r[=================>]" && sleep 0.5
                        echo -n -e "\r[==================]${Reset}\n"

			echo -e "MATPLOTLIB : ${Green}INSTALLED${Reset}"
			echo 

			sleep 2
			#ICON CREATION
			printf "LINUXBURNER ICON\n"
			if [[ -d "$home/Desktop" ]];
			then
				if [[ -f "$home/Desktop/Linux_Burner.desktop" ]];
				then
					rm $home/Desktop/Linux_Burner.desktop 
					printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py 2>/dev/null\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Desktop/Linux.Burner.desktop
					echo -e "${Yellow}GIVING THE RIGHT PERMISSION TO THE APP ${Reset}"
					sudo -S chmod +x $home/Desktop/Linux_Burner.desktop <<< $PASS
					echo "ICON CREATED : ${Green}SUCESS${Reset}"
				else
					printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py 2>/dev/null\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Desktop/Linux_Burner.desktop
					echo -e "${Yellow}GIVING THE RIGHT PERMISSION TO THE APP ${Reset}"
					sudo -S chmod +x $home/Desktop/Linux_Burner.desktop <<< $PASS
					echo "ICON CREATED : ${Green}SUCESS${Reset}"
				fi
			elif [[ -d "$home/Bureau" ]];
			then
				if [[ -f "$home/Bureau/Linux_Burner.bureau" ]];
                	        then

                	                rm $home/Bureau/Linux_Burner.bureau
                    	            printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py 2>/dev/null\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Bureau/Linux.Burner.bureau
                        	        echo -e "${Yellow}GIVING THE RIGHT PERMISSION TO THE APP ${Reset}"
                            	    sudo -S chmod +x $home/Bureau/Linux_Burner.desktop <<< $PASS
									echo "ICON CREATED : ${Green}SUCESS${Reset}"
                        	else
                        	        printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py 2>/dev/null\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Bureau/Linux_Burner.desktop
                        	        echo -e "${Yellow}GIVING THE RIGHT PERMISSION TO THE APP ${Reset}"
                        	        sudo -S chmod +x $home/Bureau/Linux_Burner.desktop <<< $PASS
									echo "ICON CREATED : ${Green}SUCESS${Reset}"
                        	fi
				fi
		fi
	elif sudo dnf --help <<< $PSWD &>/dev/null;
	then
		echo "FEDORA"
		echo "INSTALLING TKINTER"
		if python3 -c "import tkinter" &> /dev/null;then 
		#this return 0 if tkinter already exists
			echo -e "INSTALLATION [status]:${Red}failed${Reset}\nTKINTER IS ALREADY INSTALLED\n"
                        echo -n -e "\r... " && sleep 0.5
                        echo -e  "\r......\n"
		else
			yes|sudo dnf update &>/dev/null && yes|sudo apt install python3-tkinter &>/dev/null
                        echo -e "UPDATING"
                        echo -n -e "\r${Red}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                       	echo -n -e "\r[=============>    ]" && sleep 1
			echo -n -e "\r[=================>]" && sleep 0.5
			echo -n -e "\r[==================]${Reset}\n"

			echo "CHECKING FOR DEPENCIES"
                        echo -n -e "\r${Cyan}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                        echo -n -e "\r[=============>    ]" && sleep 1
                        echo -n -e "\r[=================>]" && sleep 0.5
                        echo -n -e "\r[==================]${Reset}\n"

                        printf "INSTALLING TKINTER\n"
                        echo -n -e "\r${Purple}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                        echo -n -e "\r[=============>    ]" && sleep 1
                        echo -n -e "\r[=================>]" && sleep 0.5
                        echo -n -e "\r[==================]${Reset}\n"
			printf "TKINTER : ${Green}INSTALLED${Reset}"
			echo
			sleep 2
		fi
		#matplotlib installation (tools for graph)
		if python3 -c "import matplotlib " &>/dev/null ;then
		#Dasame as Tkinter xD
			echo "INSTALLING MATPLOTLIB"
			echo -e "INSTALLATION [status]:${Red}failed${Reset}\nMATPLOTLIB IS ALREADY INSTALLED"
			echo -n "..." && sleep 0.5
			echo -e "...\n"
		else
			yes| sudo dnf update  &> /dev/null && yes |sudo dnf install python3-matplotlib &>/dev/null
			echo "CHECKING FOR DEPENCIES"
			echo -n -e "\r${Cyan}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                        echo -n -e "\r[=============>    ]" && sleep 1
                        echo -n -e "\r[=================>]" && sleep 0.5
                        echo -n -e "\r[==================]${Reset}\n"
	
			echo "INSTALLING MATPLOTLIB"
			echo -n -e "\r${Purple}[==>               ]" && sleep 1
                        echo -n -e "\r[====>             ]" && sleep 1
                        echo -n -e "\r[=========>        ]" && sleep 1
                        echo -n -e "\r[=============>    ]" && sleep 1
                        echo -n -e "\r[=================>]" && sleep 0.5
                        echo -n -e "\r[==================]${Reset}\n"

			echo -e "MATPLOTLIB : ${Green}INSTALLED${Reset}"
			echo 

			sleep 2
		
			#ICON CREATION
			printf "LINUXBURNER ICON\n"
			if [[ -d "$home/Desktop" ]];
			then
				if [[ -f "$home/Desktop/Linux_Burner.desktop" ]];
				then
					rm $home/Desktop/Linux_Burner.desktop 
					printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py 2>/dev/null\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Desktop/Linux.Burner.desktop
					echo -e "${Yellow}GIVING THE RIGHT PERMISSION TO THE APP ${Reset}"
					sudo -S chmod +x $home/Desktop/Linux_Burner.desktop <<< $PASS
					echo "ICON CREATED : ${Green}SUCESS${Reset}"
				else
					printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py 2>/dev/null\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Desktop/Linux_Burner.desktop
					echo -e "${Yellow}GIVING THE RIGHT PERMISSION TO THE APP ${Reset}"
					sudo -S chmod +x $home/Desktop/Linux_Burner.desktop <<< $PASS
					echo "ICON CREATED : ${Green}SUCESS${Reset}"
				fi
			elif [[ -d "$home/Bureau" ]];
			then
				if [[ -f "$home/Bureau/Linux_Burner.bureau" ]];
                	        then

                	                rm $home/Bureau/Linux_Burner.bureau
                    	            printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py 2>/dev/null\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Bureau/Linux.Burner.bureau
                        	        echo -e "${Yellow}GIVING THE RIGHT PERMISSION TO THE APP ${Reset}"
                            	    sudo -S chmod +x $home/Bureau/Linux_Burner.desktop <<< $PASS
									echo "ICON CREATED : ${Green}SUCESS${Reset}"
                        	else
                        	        printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py 2>/dev/null\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Bureau/Linux_Burner.desktop
                        	        echo -e "${Yellow}GIVING THE RIGHT PERMISSION TO THE APP ${Reset}"
                        	        sudo -S chmod +x $home/Bureau/Linux_Burner.desktop <<< $PASS
									echo "ICON CREATED : ${Green}SUCESS${Reset}"
                        	fi
				fi
		fi
else
	echo -e "${Blue}VERIFYING CONNEXION ACCESS${Reset}"
    echo -n -e "\r${Cyan}[==>               ]" && sleep 1
    echo -n -e "\r[====>             ]" && sleep 1
    echo -e "\r[=========>        ]" && sleep 1
	printf "${Red}PLEASE CONNECT TO A NETWORK ACCESS${Reset}"
	exit 1
fi

