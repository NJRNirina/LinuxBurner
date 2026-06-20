import subprocess 

def get_reseau():
    result = subprocess.run(
    ["bash","../modules/reseauproj.sh"],
    capture_output=True,
    text=True
    )
    return result.stdout
