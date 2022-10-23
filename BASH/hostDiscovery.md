
# hostDiscovery.sh

Descubrimiento de host para hacer pivoting:

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
for i in $(seq 1 254); do
        timeout 1 bash -c "ping -c1 10.10.10.$i" &> /dev/null && echo "[+] El host 10.10.10.$i - ACTIVE" &
done; wait

tput cnorm
</pre>
