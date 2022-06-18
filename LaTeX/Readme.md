#LaTeX

Apuntes tomados a raiz de la visualización del video de Latex de S4vitar:

[video de Latex de S4vitar](https://www.youtube.com/watch?v=riNRHoEOBeU)

## Instalación

Utilidades:

<pre>
# Utilidades
apt install texlive-full -y # Esta tarda
# Zathura es un visor PDF
apt install zathura latexmk rubber -y  

# Variables de entorno
xdg-mime query default application/pdf
xdg-mime default zathura-desktop application/pdf

</pre>

Configuraciones 

<pre>
cd /home/j4munoff/.config
mkdir latexmk
nano latexmkrc
#Escribimos
$pdf_previewer = 'zathura';

#Damos permisos
cd ..
chown j4munof:j4munoff -R latexmk

# En root
cd /root/.config
mkdir latexmk
ln -s -f  /home/j4munoff/.config/latexmk/latexmkrc latexmkrc
</pre>

Si quisieramos configurar nano:

<pre>
#En home del usuario
nano ~/.nanorc

# Escribimos
set autoindent
set tabsize 4
set smooth # Esta da problemas
set mouse
set nohelp
set nowrap

</pre>

