	#!/bin/bash
#installing tools and checking dependecies
home=$HOME
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

#System - information
Info_OS=/etc/os-release
distro_family=$(awk -F= '/ID_LIKE/{print$2}'< ${Info_OS}|tr -d '"')
#for primary distro
distro=`awk -F= '/^ID/{print$2}' < $Info_OS |head -1 |tr -d '"'`
Test=$!

#tools verification
echo -e "${Red}
  _     ___ _   _ _   ___  __  ____  _   _ ____  _   _ _____ ____  
| |   |_ _| \ | | | | \ \/ / | __ )| | | |  _ \| \ | | ____|  _ \ 
| |    | ||  \| | | | |\  /  |  _ \| | | | |_) |  \| |  _| | |_) |
| |___ | || |\  | |_| |/  \  | |_) | |_| |  _ <| |\  | |___|  _ < 
|_____|___|_| \_|\___//_/\_\ |____/ \___/|_| \_\_| \_|_____|_| \_\
                                                                  
 ___ _   _ ____ _____  _    _     _        _  _____ ___ ___  _   _ 
|_ _| \ | / ___|_   _|/ \  | |   | |      / \|_   _|_ _/ _ \| \ | |
 | ||  \| \___ \ | | / _ \ | |   | |     / _ \ | |  | | | | |  \| |
 | || |\  |___) || |/ ___ \| |___| |___ / ___ \| |  | | |_| | |\  |
|___|_| \_|____/ |_/_/   \_\_____|_____/_/   \_\_| |___\___/|_| \_|${Reset}"

echo -n "Plz enter your password for proceding to the installation : "
read -s PASS 
# verify if the password is correct
if  echo "$PASS" | sudo -S -v  &>/dev/null ;
then
	#tools verification
	if [[ -f /etc/os-release ]]
	then
		REP=`sudo find $home -name 'linu_burner' |head -n 1`

		if [[ "${distro_family}" == "debian" || "${distro_family}" == "ubuntu" || "${distro_family}" == "ubuntu debian" ]];then
			#Instaling Tkinter
			python3 -c "import tkinter" &> /dev/null
			Test1=$?
			echo -e "${Cyan}installation de tktinter...${Reset}"
			if [[ ${Test1} -ne 0 ]];then
				sudo apt update && sudo apt install  python3-tk
				echo -e "${Green}Tkinter installed${Reset}"
		        	echo -e "Installation [status]:${Green}installed${Reset}"
               	 	else
                        	echo -e "Installation [status]:${Red}failed${Reset}"
                        	echo -e "${Green}Tkinter is already installed${Reset} "
                	fi

			#Installing  matplotlib (for graph)
                	python3 -c "import matplotlib" &>/dev/null
                	Test2=$?
        		echo -e "${Cyan}installation de matplotlib...${Reset}"
                	if [[ ${Test2} -ne 0 ]];
              	 	then
                        	sudo apt install python3-matplotlib
                        	echo -e "Installation [status]:${Green}installed${Reset}"
               	 	else
                        	echo -e "Installation [status]:${Red}failed${Reset}"
                        	echo -e "${Green}matplotlib is already installed${Reset} "
                	fi
		elif [[ "${distro_family}" == "arch" ]]
		then
			#Installation de Tkinter
			python3 -c "import tkinter" &> /dev/null
			Test1=$?
			echo -e "${Cyan}installation de tktinter...${Reset}"
                	if [[ ${Test1} -ne 0 ]]
			then
                        	sudo  pacman -S  tk 
				echo -e "${Green}Tkinter installed${Reset}"
                		echo -e "Installation [status]:${Green}installed${Reset}"
                	else
                        	echo -e "Installation [status]:${Red}failed${Reset}"
                       	 	echo -e "${Green}Tkinter is already installed${Reset} "
                	fi    
                	
			#Installation de matplotlib 
			python3 -c "import matplotlib" &>/dev/null
			Test2=$?
			echo -e "${Cyan}installation de matplotlib...${Reset}"
			if [[ ${Test2} -ne 0 ]];
			then
				sudo pacman -S python-matplotlib
				echo -e "Installation [status]:${Green}installed${Reset}"
			else
				echo -e "Installation [status]:${Red}failed${Reset}"
				echo -e "${Green}matplotlib is already installed${Reset} "
			fi

		elif [[ "${distro_family}" == "fedora" || "${distro_family}" == "rhel fedora" ]]
		then
			#Installation de Tkinter
			python3 -c "import tkinter" &> /dev/null
			Test1=$?
			echo -e "${Blue}installation de tktinter...${Reset}"
			if [[ $Test1 -ne 0 ]]
			then
				sudo dnf install python3-tkinter
	        		echo -e "Installation [status]:${Green}installed${Reset}"
       		 	else
            			echo -e "Installation [status]:${Red}failed${Reset}"
            			echo -e "${Green}Tkinter is already installed${Reset} "
        		fi
			#Installation de matplotlib
        		python3 -c "import matplotlib" &>/dev/null
        		Test2=$?
        		echo -e "${Cyan}installation de matplotlib...${Reset}"
        		if [[ ${Test2} -ne 0 ]];
        		then
           			sudo dnf install python3-matplotlib
            			echo -e "Installation [status]:${Green}installed${Reset}"
        		else
           			echo -e "Installation [status]:${Red}failed${Reset}"
            			echo -e "${Green}matplotlib is already installed${Reset} "
        		fi
		else
				if [[ "$distro" == "debian" ]]
			then
				python3 -c "import tkinter" &> /dev/null
                		Test1=$?
               			echo -e "${Blue}installation de tktinter...${Reset}"
               			if [[ ${Test1} -ne 0 ]];then
                        		sudo apt update && sudo apt install  python3-tk
        	                	echo -e "Installation [status]:${Green}installed${Reset}"
          			else
                        		echo -e "Installation [status]:${Red}failed${Reset}"
                        		echo -e "${Green}Tkinter is already installed${Reset} "
               			fi
				#Installation de matplotlib
               			python3 -c "import matplotlib" &>/dev/null
                		Test2=$?
                		echo -e "${Cyan}installation de matplotlib...${Reset}"
                		if [[ ${Test2} -ne 0 ]];
                		then
                        		sudo apt install python3-matplotlib
                        		echo -e "Installation [status]:${Green}installed${Reset}"
              	 		else
                        		echo -e "Installation [status]:${Red}failed${Reset}"
                        		echo -e "${Green}matplotlib is already installed${Reset} "
               		 	fi

       				elif [[ "${distro}" == "arch" ]]
				then
                		python3 -c "import tkinter" &> /dev/null
                		Test1=$?
                		echo -e "${Cyan}installation de tktinter...${Reset}"
                		if [[ ${Test1} -ne 0 ]];then
                        		sudo pacman -S  tk 
                        		echo -e "${Green}Tkinter installed${Reset}"
        	                	echo -e "Installation [status]:${Green}installed${Reset}"
          			else
                        		echo -e "Installation [status]:${Red}failed${Reset}"
                        		echo -e "${Green}Tkinter is already installed${Reset} "
               			fi

				#Installation de matplotlib

                		python3 -c "import matplotlib" &>/dev/null
                		Test2=$?
                		echo -e "${Cyan}installation de matplotlib...${Reset}"
               			if [[ ${Test2} -ne 0 ]];
               			then
                        		sudo pacman -S python-matplotlib
                        		echo -e "Installation [status]:${Green}installed${Reset}"
                		else
                        		echo -e "Installation [status]:${Red}failed${Reset}"
                        		echo -e "${Green}matplotlib is already installed${Reset} "
                		fi

       			elif [[ "$distro}" == "fedora" ]];
			then

               			python -c "import tkinter" &> /dev/null
                		Test1=$?
               			echo -e "${Blue}installation de tktinter...${Reset}"
                		if [[ $Test1 -ne 0 ]];then
                	        	sudo dnf install python3-tkinter
        	                	echo -e "Installation [status]:${Green}installed${Reset}"
          			else
                        		echo -e "Installation [status]:${Red}failed${Reset}"
                        		echo -e "${Green}Tkinter is already installed${Reset} "
               			fi
				fi

				#Installation de matplotlib

        	       		python3 -c "import matplotlib" &>/dev/null
        	        	Test2=$?
        	       		echo -e "${Cyan}installation de matplotlib...${Reset}"
        	        	if [[ ${Test2} -ne 0 ]];
        	        	then
        	        	        sudo dnf install python3-matplotlib
        	                	echo -e "Installation [status]:${Green}installed${Reset}"
          			else
                        		echo -e "Installation [status]:${Red}failed${Reset}"
                        		echo -e "${Green}matplotlib is already installed${Reset} "
               			fi
                	fi
		#Creating an icon in the desktop
		if [[ -d "$home/Desktop" ]];
		then
			if [[ -f "$home/Desktop/Linux_Burner.desktop" ]];
			then
				rm $home/Desktop/Linux_Burner.desktop 
				printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Desktop/Linux.Burner.desktop
				echo -e "${Yellow}Giving the right permission for the app ${Reset}"
				sudo -S chmod +x $home/Desktop/Linux_Burner.desktop <<< $PASS
			else
				printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Desktop/Linux_Burner.desktop
				echo -e "${Yellow}Giving the right permission for the app${Reset}"
				sudo -S chmod +x $home/Desktop/Linux_Burner.desktop <<< $PASS
			fi
		elif [[ -d "$home/Bureau" ]];
		then
			if [[ -f "$home/Bureau/Linux_Burner.desktop" ]];
                        then
                                rm $home/Desktop/Linux_Burner.desktop
                                printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Bureau/Linux.Burner.desktop
                                echo -e "${Yellow}Giving the right permission for the app ${Reset}"
                                sudo -S chmod +x $home/Bureau/Linux_Burner.desktop <<< $PASS
                        else
                                printf "[Desktop Entry]\nVersion=1.0\nType=Application\nName=LinuxBurner\nComment=System monitoring\nExec=bash -c \"cd %s/python && python3 interface.py\"\nIcon=$REP/assets/icones/monitoring.png\nTerminal=true" "$REP"  > $home/Bureau/Linux_Burner.desktop
                                echo -e "${Yellow}Giving the right permission for the app${Reset}"
                                sudo -S chmod +x $home/Bureau/Linux_Burner.desktop <<< $PASS
                        fi
		fi

		echo -e "${Red}
	
___ _   _ 
		____ _____  _    _     _        _  _____ ___ ___  _   _ 
|_ _| \ | / ___|_   _|/ \  | |   | |      / \|_   _|_ _/ _ \| \ | |
 | ||  \| \___ \ | | / _ \ | |   | |     / _ \ | |  | | | | |  \| |
 | || |\  |___) || |/ ___ \| |___| |___ / ___ \| |  | | |_| | |\  |
|___|_| \_|____/ |_/_/   \_\_____|_____/_/   \_\_| |___\___/|_| \_|
                                                                   
 ____   ___  _   _ _____ 
|  _ \ / _ \| \ | | ____|
| | | | | | |  \| |  _|  
| |_| | |_| | |\  | |___ 
|____/ \___/|_| \_|_____| $Reset"
	
	fi
else 
	echo "incorrect password... :( "
	exit 1
fi
