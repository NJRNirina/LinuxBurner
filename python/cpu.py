import subprocess 

def get_cpu():
    result=subprocess.check_output(["bash","../modules/cpu.bash"])
    data=result.decode().strip()
    div=data.split("|")
    Model=div[0]
    Core=div[1]
    Usage=div[2]
    Heat=div[3:-1]
    processus=div[-1]
    return Model,Core,Usage,Heat,processus
