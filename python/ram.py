import subprocess
def get_ram():
    result=subprocess.check_output(["bash","../modules/ram.sh"])
    data=result.decode().strip()
    totale,disponible,utilisee,cache,swap=data.split("|")
    return totale,disponible,utilisee,cache,swap


#result=subprocess.run(["bash","../modules/ram.sh"],capture_output=True,text=True)
#print(result.stdout)