## Comandos de DNS

Si existe un servidor DNS, (puerto 53).

### Averiguar nombre de dominio.

~~~ 
nslookup
server 10.10.10.13
10.10.10.13
~~~ 

### Comando DIG

#### Enumerar name servers

~~~
dig @10.10.10.13 croos.htb ns
~~~

#### Enumerar servidores de correo

~~~
dig @10.10.10.13 croos.htb mx
~~~


#### Ataque de transferencia de zona
Averiguar mas dominios
~~~
dig @10.10.10.13 croos.htb axfr
~~~
