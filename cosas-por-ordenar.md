# Cosas para ordenar


## Tomcat

Realizar operaciones con tomcat manager desde curl
<pre>
# Deploy aplicacion
curl -s -u 'tomcat:$3cureP4s5w0rd123!' -X POST "http://10.10.10.194:8080/manager/text/deploy?path=/prueba" --upload-file prueba.war
# Lsitar aplicaciones
curl -s -u 'tomcat:$3cureP4s5w0rd123!' -X GET "http://10.10.10.194:8080/manager/text/list
</pre>
