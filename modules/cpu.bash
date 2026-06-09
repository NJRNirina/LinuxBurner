#!/bin/bash
#Affichage de l'usage de CPU
declare -a cpu_heat
 
	#recherche des informations sur le modele du cpu sur /proc/cpuinfo
		Model=$(awk '/model name/{print $k}'  /proc/cpuinfo|cut -d ":" -f2 |head -1)
		
	#nombre de coeur du cpu sur le fichier /proc/cpuinfo
	
		core=$(awk '/siblings/{print $3}' /proc/cpuinfo |head -1)	

	#traitement de donnee sur ps
	#affichage des cpu utilisee par commandes en temps reel (3 grandes commandes)
		cpu_usage_per_cmd=$(ps -eo pcpu,comm --sort=-pcpu | awk '$1 >= 1 && $1 < 100' |head -3) 
		cpu_usage=$(top -bn2 -d 0.5|grep "Cpu(s)"|tail -1|awk '{print $2}')
		cpu_usage=${cpu_usage%.* } #suppression decimale
		
	#affichage du resulat 
		echo "Model = $Model"
		echo "Core = $core"
		echo "CPU% = $cpu_usage %" 
	#utilisation de lm -sensors pour la temperature du cpu en 6cores seulement

		line=$(sensors | grep -E "(Core)"|wc -l)
		for((i=1;i<=line;i++))
	        	do
        	        	cpu_heat[$i]=$(sensors | grep -E "(Core)"|head -$i|tail -1|awk -F " " '{print $3}' )    
                		echo "Core $i : ${cpu_heat[$i]}"
        		done
		echo "commande important"
		echo "$cpu_usage_per_cmd"




