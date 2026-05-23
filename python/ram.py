import subprocess
result=subprocess.check_output(["bash","../modules/ram.sh"])
ram =result.decode().strip()

#result=subprocess.run(["bash","../modules/ram.sh"],capture_output=True,text=True)
#print(result.stdout)