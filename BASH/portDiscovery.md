
## portDiscovery.sh

Descubrimiento de puertos en una maquina.

<pre>

#!/bin/bash


function ctlr_c(){
        echo -e "\n\n[!] Saliendo ....\n"
        tput cnorm
        exit 1
}


# Ctlr+C
trap ctlr_c INT

tput civis
for port in $(seq 1 65535); do
        timeout 1 bash -c "echo '' > /dev/tcp/10.10.10.128/$port" 2> /dev/null && echo "[+] Port $port - OPEN" &
done; wait

tput cnorm
</pre>
