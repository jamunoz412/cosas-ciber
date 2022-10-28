## Windows

El objetivo de esta página es documentar los comandos mas utilizados en enumeración y explotaciónde máquinas Windows.

### Crackmapexek

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
