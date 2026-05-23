#!/bin/bash

    totale=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    disponible=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
    utilisee=$((totale - disponible))
    pourcentage_utilise=$(( utilisee*100/totale ))
    cache=$(awk '/^Cached/ {print $2}' /proc/meminfo)
    memoire_swap=$(awk '/SwapCached/ {print $2}' /proc/meminfo)

#convertir kB en Go
    totale_go=$(awk "BEGIN {printf \"%.2f\" ,$totale/1024/1024}")
    disponible_go=$(awk "BEGIN {printf \"%.2f\", $disponible/1024/1024}")
    utilisee_go=$(awk "BEGIN {printf \"%.2f\",$utilisee/1024/1024}")
    cache_go=$(awk "BEGIN {printf \"%.2f\",$cache/1024/1024}")
    memoire_swap_go=$(awk "BEGIN {printf \"%.2f\", $memoire_swap/1024/1024}")
    
    echo "$totale_go|$disponible_go|$utilisee_go|$cache_go|$memoire_swap_go"
    
    

    

