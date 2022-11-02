## Linux

El objetivo de esta página es documentar los comandos mas utilizados en enumeración y explotaciónde máquinas Linux.

### wget

Para descargar recursivamente de una URL, http o ftp.:

<pre>
wget -r ftp://10.10.10.100 
</pre>

### tree

Para ver con nivel de profundidad

~~~
tree -L 2
~~~

### find

Buscar desde la ruta actual ficheros con patrón de nombre

~~~
find \-name \*config\*
~~~


### grep

Buscar, de forma recursiva y con keis insemsitive archivos que contengan palabra

~~~
grep -riE "pass|password" 
~~~
