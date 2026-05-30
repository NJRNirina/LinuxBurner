import subprocess
def get_network():
    result = subprocess.run(["bash", "../modules/reseauproj.sh"],capture_output=True,text=True)
    data = {}
    traffic = []

    lecture_traffic = False

    for ligne in result.stdout.splitlines():

        if ligne == "TRAFFIC_BEGIN":
            lecture_traffic = True
            continue

        if ligne == "TRAFFIC_END":
            lecture_traffic = False
            continue

        if lecture_traffic:
            interface, rx, tx = ligne.split("|")
            traffic.append({
                "interface": interface,
                "rx": int(rx),
                "tx": int(tx)
            })
            continue

        if "=" in ligne:
            cle, valeur = ligne.split("=", 1)
            data[cle] = valeur

    return data, traffic