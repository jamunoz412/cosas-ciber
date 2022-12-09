## FUZZING

Diferentes formas de fuzzing

### gobuster

Averiguar subdominios:

<pre>
gobuster vhost -u http://bart.htb -w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt -t 200
</pre>


Averiguar subdirectorios:

<pre>
 gobuster dir -u http://10.10.11.180:9093 -w /usr/share/wordlists/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt
</pre>

### wfuzz

Averiguar subdirectorios:

<pre>
wfuzz -c --hc=404,302 -w /usr/share/wordlists/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt http://10.10.10.87/FUZZ
</pre>

Fuerza bruta con dos listas:

~~~
wfuzz -c -t 200 -z file,valid_users.txt -z file,/usr/share/wordlists/SecLists/Passwords/Common-Credentials/10-million-password-list-top-100.txt --hh=3434 -X POST -d "username=FUZZ&password=FUZ2Z"  http://10.10.114.44/customers/login
~~~
