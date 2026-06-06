import subprocess

result = subprocess.run(
    ["bash", "cpu.bash"],
    capture_output=True,
    text=True
)

lines = result.stdout.strip().splitlines()

# Assign each echo line to a variable
model       = lines[0]  
core        = lines[1]   
cpu_usage   = lines[2]   
cpu_heat    = lines[3]   
cmd_label   = lines[4]  
cpu_per_cmd = lines[5:]  

print(model)
print(core)
print(cpu_usage)
print(cpu_heat)
print(cmd_label)
print(cpu_per_cmd)
