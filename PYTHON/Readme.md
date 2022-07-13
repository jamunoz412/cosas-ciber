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
