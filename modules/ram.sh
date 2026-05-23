#!/bin/bash
afficher_ram()
{
    totale=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    libre=$(awk '/MemFree/ {print $2}' /proc/meminfo)
    disponible=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
    utilisee=$((totale - disponible))
    pourcentage_utilise=$(( utilisee*100/totale ))
    cache=$(awk '/^Cached/ {print $2}' /proc/meminfo)
    memoire_swap=$(awk '/SwapCached/ {print $2}' /proc/meminfo)

#convertir kB en Go
    totale_go=$(awk "BEGIN {printf \"%.2f\" ,$totale/1024/1024}")
    libre_go=$(awk "BEGIN {printf \"%.2f\",$libre/1024/1024}")
    disponible_go=$(awk "BEGIN {printf \"%.2f\", $disponible/1024/1024}")
    utilisee_go=$(awk "BEGIN {printf \"%.2f\",$utilisee/1024/1024}")
    cache_go=$(awk "BEGIN {printf \"%.2f\",$cache/1024/1024}")
    memoire_swap_go=$(awk "BEGIN {printf \"%.2f\", $memoire_swap/1024/1024}")
    processus_ram=$(ps -eo comm,%mem --sort=-%mem | sed 1d | head -5)
    
    
    echo "RAM totale : ${totale_go} Go"
    echo "RAM libre : ${libre_go} Go"
    echo "RAM disponible : ${disponible_go} Go"
    echo "RAM utilisée : ${utilisee_go} Go"
    echo "RAM cache : ${cache_go} Go"
    echo "RAM swapped : ${memoire_swap_go} Go"

    echo "Pourcentage RAM : ${pourcentage_utilise} %"
    echo "Top utilisation RAM : "
    echo "${processus_ram}"
    
}
afficher_ram
