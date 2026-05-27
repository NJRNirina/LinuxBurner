#!/bin/bash
#Affichage de l'usage de CPU
	#user=$(pwd |cut -d "/" -f3) #pendant que je ne connaissais pas whoami xD
	#user=$(whoami)	#voir qui est l'utilisateur
	Model=$(awk '/model name/{print $k}' /proc/cpuinfo |head -1)
	core=$(awk '/siblings/{print $3}' /proc/cpuinfo |head -1)	
	echo " ======================================================================================================================================="
	echo "$Model"
	echo "Core = $core"
	echo "========================================================================================================================================="
	echo "CPU usage par processus"
	echo "=================================================++TEMPERATURE++========================================================================="
	cpu_heat=$(sensors | awk -F : '/Core/{print $k}' ) #utilisation de lm-sensors pour l'affichage de la temperature
	echo "$cpu_heat"

	#	line=$(ps aux |awk -v user="$user" '$1==user {print $3 }'|awk '$1 > 2 && $1 < 100 {print $k}'|wc -l)
	#	if [[ line -ne 0 ]] ; then
	#		for ((i=1;i<line;i++));
	#		do
			#	echo "===========================++ CPU ++========================== "
			cpu_usage_per_cmd=$(ps u|awk '{print $3 "  " $11  }'|awk '$1 > 1 && $1 < 100  {print $k}')
			cpu_usage=$(top -bn1 |grep "Cpu(s)"|awk '{print $2}')
				cpu_usage=${cpu_usage%.* } #suppression decimale
				echo "CPU% = $cpu_usage %"
				echo "commande important"
				echo $cpu_usage_per_cmd
#			done
		#elif [[ line -eq 0 ]] ;then 
		#	exit 1
	#	fi



