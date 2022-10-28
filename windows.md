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

Con credenciales, Info de un  usuario por su id:
<pre>
rpcclient -U "USUARIO%CONTRASEÑA" 10.10.10.100 -c 'queryguser 0x1f4'
</pre>
