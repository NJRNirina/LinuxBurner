#!/bin/bash
#Affichage de l'usage de CPU
declare -a cpu_heat
 
	#recherche des informations sur le modele du cpu sur /proc/cpuinfo
		Model=$(awk '/model name/{print $0}'  /proc/cpuinfo|cut -d ":" -f2 |head -1)
		
	##nombre de coeur du cpu sur le fichier /proc/cpuinfo
	
		core=$(awk '/cores/{print $4}' /proc/cpuinfo |head -1)	
	#affichage des cpu utilisee par commandes en temps reel (3 grandes commandes)
		cpu_usage_per_cmd=$(ps -eo pcpu,comm --sort=-pcpu | awk '$1 >= 1 && $1 < 100' |head -3|awk '{print $2"("$1"%)"}' | tr '\n' ',' | sed 's/,$//') 
		cpu_usage=$(top -bn2 -d 0.5|grep "Cpu(s)"|tail -1|awk '{print $2}')
		cpu_usage=${cpu_usage%.* } #suppression decimale
#utilisation des informations sur /sys/class/thermal/)
zones=(/sys/class/thermal/thermal_zone*)
line=${#zones[@]}
for ((i=0; i<core; i++))
do
    # On vérifie si c'est bien une zone CPU (souvent de type x86_pkg_temp ou coretemp)
		if [ -f "/sys/class/thermal/thermal_zone$i/temp" ]; then
        		temp_brute=$(cat /sys/class/thermal/thermal_zone$i/temp)
       			 # division par 1000 car on a un temperature en millidegre C
       			 cpu_heat[$i]=$((temp_brute / 1000))
    		else
     			   cpu_heat[$i]="0"
    	fi
done
# Affichage final sur une seule ligne
printf "%s|%s|%s %%|" "$Model" "$core" "$cpu_usage"

for ((i=0; i<core; i++))
do
    if [ "${cpu_heat[$i]}" -gt 0 ]; then
        printf "%s°C|" "${cpu_heat[$i]}"
    fi
done	

	echo  "$cpu_usage_per_cmd"


