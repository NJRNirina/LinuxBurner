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
Test=$?
home=$HOME #home of the users
#tools verification
echo -e "${Red}Uninstalling LinuxBurner ${Reset}"
echo -n -e "${Green}Do you want to uninstall LinuxBurner (yes/no): ${Reset}"
read Choice
if  [[ "$Choice" == "yes" ]];
then
    echo -n -e "Enter your password plzz : "
    read -s $PASS
	#tools verification
    	if [[ -f /etc/os-release ]]
	then
		REP=`sudo find $home -name 'LinuxBurner' |head -n 1`
		if [[ "${distro_family}" == "debian" || "${distro_family}" == "ubuntu" || "${distro_family}" == "ubuntu debian" ]];then
			#uninstaling Tkinter
			python3 -c "import tkinter" &> /dev/null
			Test1=$?
			echo -e "${Cyan}uninstalling  tktinter...${Reset}"
			if [[ ${Test1} -eq 0 ]];then
				sudo - S apt purge  python3-tk  <<< $PASS
                		echo -e "Tkinter ${Red}uninstalled${Reset}"
            		else
                		echo -e "uninstallation [status]:${Red}failed${Reset}"
                		echo -e "${Green}matplotlib is not found ${Reset} "
            		fi
			#uninstalling  matplotlib (for graph)
           		python3 -c "import matplotlib" &>/dev/null
           		Test2=$?
        		echo -e "${Cyan}uninstallation de matplotlib...${Reset}"
        	    	if [[ ${Test2} -eq 0 ]];
         		then
                		sudo -S apt purge python3-matplotlib <<< $PASS
                	echo -e "matplotlib ${Red}uninstalled${Reset}"
            		else
            			echo -e "uninstall [status]:${Red}failed${Reset}"
            			echo -e "${Green}matplotlib is not found ${Reset} "
            		fi
		elif [[ "${distro_family}" == "arch" ]]
		then
            		#Uninstalling Tkinter
            		python3 -c "import tkinter" &> /dev/null
			Test1=$?
			echo -e "${Cyan}uninstall tktinter...${Reset}"
			if [[ ${Test1} -eq 0 ]];then
				sudo -S pacman -Rns tk <<< $PASS
        	        	echo -e "Tkinter ${Red}uninstalled${Reset}"
            		else
                		echo -e "uninstall [status]:${Red}failed${Reset}"
                		echo -e "${Green}Tkinter is not found ${Reset} "
            		fi
			#uninstalling  matplotlib (for graph)
            		python3 -c "import matplotlib" &>/dev/null
            		Test2=$?
        		echo -e "${Cyan}uninstalling matplotlib...${Reset}"
           		if [[ ${Test2} -eq 0 ]];
         		then
                		sudo -S pacman -Rns python-matplotlib <<< $PASS
                		echo -e "matplotlib ${Red}uninstalled${Reset}"
            		else
            			echo -e "uninstall [status]:${Red}failed${Reset}"
            			echo -e "${Green}matplotlib is not found ${Reset} "
         		fi

		elif [[ "${distro_family}" == "fedora" || "${distro_family}" == "rhel fedora" ]]
		then 
            		#Uninstalling tkinter
          		python3 -c "import tkinter" &> /dev/null
			Test1=$?
			echo -e "${Cyan}uninstall tktinter...${Reset}"
			if [[ ${Test1} -eq 0 ]];then
				sudo -S dnf remove --allowerasing python3-tkinter <<< $PASS
                		echo -e "Tkinter ${Red}uninstalled${Reset}"
            		else
                		echo -e "uninstall [status]:${Red}failed${Reset}"
                		echo -e "${Green}Tkinter is not found ${Reset} "
            		fi
			#uninstalling  matplotlib (for graph)
           		python3 -c "import matplotlib" &>/dev/null
            		Test2=$?
        		echo -e "${Cyan}uninstalling matplotlib...${Reset}"
            		if [[ ${Test2} -eq 0 ]];
         		then
                		sudo -S dnf remove --allowerasing python3-matplotlib <<< $PASS
               			 echo -e "matplotlib ${Red}uninstalled${Reset}"
            		else
            			echo -e "uninstall [status]:${Red}failed${Reset}"
            			echo -e "${Green}matplotlib is not found ${Reset} "
			fi
		else
			if [[ "$distro" == "debian" ]]
			then	#uninstaling Tkinter
			   	 python3 -c "import tkinter" &> /dev/null
			   	 Test1=$?
			   	 echo -e "${Cyan}uninstalling  tktinter...${Reset}"
				 if [[ ${Test1} -eq 0 ]];then
				    	sudo -S apt purge  python3-tk <<< $PASS
                    			echo -e "Tkinter ${Red}uninstalled${Reset}"
                		else
                    			echo -e "uninstallation [status]:${Red}failed${Reset}"
                    			echo -e "${Green}matplotlib is not found ${Reset} "
               			fi
			   	#uninstalling  matplotlib (for graph)
                		python3 -c "import matplotlib" &>/dev/null
                		Test2=$?
        	    		echo -e "${Cyan}uninstallation de matplotlib...${Reset}"
        	        	if [[ ${Test2} -eq 0 ]];
         		    	then
                	    		sudo -S apt purge python3-matplotlib <<< $PASS
                	    		echo -e "matplotlib ${Red}uninstalled${Reset}"
                		else
            	    			echo -e "uninstall [status]:${Red}failed${Reset}"
            	    			echo -e "${Green}matplotlib is not found ${Reset} "
                		fi

       			elif [[ "${distro}" == "arch" ]]
			then
               			#Uninstalling Tkinter
                		python3 -c "import tkinter" &> /dev/null
				Test1=$?
				echo -e "${Cyan}uninstall tktinter...${Reset}"
				if [[ ${Test1} -eq 0 ]];then
					sudo -S pacman -Rns tk <<< $PASS
                    			echo -e "Tkinter ${Red}uninstalled${Reset}"
                		else
                	    		echo -e "uninstall [status]:${Red}failed${Reset}"
                    			echo -e "${Green}Tkinter is not found ${Reset} "
                		fi
			   	#uninstalling  matplotlib (for graph)
                		python3 -c "import matplotlib" &>/dev/null
                		Test2=$?
        	    		echo -e "${Cyan}uninstalling matplotlib...${Reset}"
                		if [[ ${Test2} -eq 0 ]];
         	    		then
                    		sudo -S pacman -Rns python-matplotlib <<< $PASS
                    		echo -e "matplotlib ${Red}uninstalled${Reset}"
                		else
                			echo -e "uninstall [status]:${Red}failed${Reset}"
                			echo -e "${Green}matplotlib is not found ${Reset} "
                		fi
       			elif [[ "$distro}" == "fedora" ]];
			then
                		#Uninstalling tkinter
                		python3 -c "import tkinter" &> /dev/null
			    	Test1=$?
			    	echo -e "${Cyan}uninstall tktinter...${Reset}"
			    	if [[ ${Test1} -eq 0 ]];then
			    		sudo -S dnf remove --allowerasing python3-tkinter <<< $PASS
                    			echo -e "Tkinter ${Red}uninstalled${Reset}"
                		else
                    			echo -e "uninstall [status]:${Red}failed${Reset}"
                 	   		echo -e "${Green}Tkinter is not found ${Reset} "
               			fi
			    #uninstalling  matplotlib (for graph)
                		python3 -c "import matplotlib" &>/dev/null
               			Test2=$?
        	  	  	echo -e "${Cyan}uninstalling matplotlib...${Reset}"
                		if [[ ${Test2} -eq 0 ]];
             			then
                			sudo -S dnf remove --allowerasing python3-matplotlib <<< $PASS
                    			echo -e "matplotlib ${Red}uninstalled${Reset}"
                		else
            				echo -e "uninstall [status]:${Red}failed${Reset}"
                			echo -e "${Green}matplotlib is not found ${Reset} "
                		fi
			fi
		fi
			#Deleting icon in the desktop
		if [[ -d "$home/Desktop" ]];
		then
			if [[ -f "$home/Desktop/Linux_Burner.desktop" ]];
			then
				rm $home/Desktop/Linux_Burner.desktop 
               			echo -e "LinuxBurner icon : ${Red}uninstalled${Reset}"
			else
               			echo -e "LinuxBurner icon : ${Red}uninstalled${Reset}"
			fi
		elif [[ -d "$home/Bureau" ]];
		then
			if [[ -f "$home/Bureau/Linux_Burner.bureau" ]];
               		then
                    			rm $home/Bureau/Linux_Burner.desktop
               			echo -e "LinuxBurner icon : ${Red}uninstalled${Reset}"
               		else
                   			echo -e "LinuxBurner icon : ${Red}uninstalled${Reset}"
			fi
		fi
			
	fi		
	echo -e "${Red}LinuxBurner uninstalled${Reset}"
elif [[ "$Choice" == "no" ]];
then
	echo -e " Keeping LinuxBurner ${Cyan}:)${Reset}"
	exit 0
else 
    echo -e "Choose between ${Red}yes/no${Reset}"
    exit 1
fi
