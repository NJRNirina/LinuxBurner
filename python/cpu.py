import subprocess 

def get_cpu():
    result=subprocess.check_output(["bash","../modules/cpu.bash"])
    data=result.decode().strip()
    Model,Core,Usage,Heat1,Heat2,Heat3,Heat4,Heat5,Heat6,processus=data.split("|")
    return Model,Core,Usage,Heat1,Heat2,Heat3,Heat4,Heat5,Heat6,processus
