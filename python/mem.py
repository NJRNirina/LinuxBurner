import subprocess
def get_mem():
    result=subprocess.check_output(["bash","../modules/projet1.sh"])
    data=result.decode().strip()
    totale,disponible,utilisee,cache,swap=data.split("|")
    return totale,disponible,utilisee,cache,swap

