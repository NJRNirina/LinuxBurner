#!/bin/bash
#Affichage de l'usage de CPU
 
	#recherche des informations sur le modele du cpu sur /proc/cpuinfo
		Model=$(awk '/model name/{print $k}'  /proc/cpuinfo|cut -d ":" -f2 |head -1)
		
		#nombre de coeur du cpu sur le fichier /proc/cpuinfo
	
		core=$(awk '/siblings/{print $3}' /proc/cpuinfo |head -1)	
	#utilisation de lm -sensors pour la temperature du cpu en 6cores seulement 
	
		cpu_heat=$(sensors | grep -E "(Core)" ) #utilisation de lm-sensors pour l'affichage de la temperature
		#traitement de donnee sur ps

		cpu_usage_per_cmd=$(ps u|awk '{print $3 "  " $11  }'|awk ' $1 >= 1 &&  $1 < 100  {print $k}') 
		#traitement de donnee sur top 
		#
		cpu_usage=$(top -bn1 |grep "Cpu(s)"|awk '{print $2}')
		cpu_usage=${cpu_usage%.* } #suppression decimale
		
	#affichage du resulat 
		echo "Model = $Model"
		echo "Core = $core"
		echo "CPU% = $cpu_usage %" 
       		echo "$cpu_heat"
		echo "commande important"
		echo "$cpu_usage_per_cmd"



