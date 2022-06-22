# Scripting en BASH para principiantes 1


Plataforma de aprendizaje de Scripting OverTheWire.

En este caso es **bandit**


[OverTheWire: Wargames: Bandit](https://overthewire.org/wargames/bandit/)   

## Level 0

***

The goal of this level is for you to log into the game using SSH. The host to which you need to connect is bandit.labs.overthewire.org, on port 2220. The username is bandit0 and the password is bandit0. Once logged in, go to the Level 1 page to find out how to beat Level 1.

Commands: ssh
***
<pre>
ssh bandit0@bandit.labs.overthewire.org -p 2220 --> bandit0
</pre>

## Level 1

***
The password for the next level is stored in a file called readme located in the home directory. Use this password to log into bandit1 using SSH. Whenever you find a password for a level, use SSH (on port 2220) to log into that level and continue the game.

Commands: ls, cd, cat, file, du, find

***
<pre>
cat readme --> boJ9jbbUNNfktd78OOpsqOltutMc3MY1
exit
ssh bandit1@bandit.labs.overthewire.org -p 2220 --> boJ9jbbUNNfktd78OOpsqOltutMc3MY1
</pre>

## Level 2

***
The password for the next level is stored in a file called - located in the home directory

Commands: ls, cd, cat, file, du, find
***

<pre>
cat ./- --> CV1DtqXWVFXTvM2F0k09SHz0YwRINYA9
exit
ssh bandit2@bandit.labs.overthewire.org -p 2220 --> CV1DtqXWVFXTvM2F0k09SHz0YwRINYA9
</pre>

## Level 3

***
The password for the next level is stored in a file called spaces in this filename located in the home directory.

Commands: ls, cd, cat, file, du, find
***

<pre>
cat "spaces in this filename"  --> UmHadQclWmgdLOKQ3YNgjWxGoRMb5luK
exit
ssh bandit3@bandit.labs.overthewire.org -p 2220 --> UmHadQclWmgdLOKQ3YNgjWxGoRMb5luK
</pre>

## Level 4

***
The password for the next level is stored in a hidden file in the inhere directory.

Commands: ls, cd, cat, file, du, find
***

<pre>
ls -la
cd inhere
ls -la 
cat .hidden --> pIwrPrtPN36QITSp3EQaw936yaFoFgAB
exit
ssh bandit4@bandit.labs.overthewire.org -p 2220 --> pIwrPrtPN36QITSp3EQaw936yaFoFgAB

# Opcion recomendada, la búsqueda recursiva 
find .

# Tambien 
find .-name .hidden | xargs cat
</pre>

## Level 5

***
The password for the next level is stored in the only human-readable file in the inhere directory. Tip: if your terminal is messed up, try the “reset” command.
Commands: ls, cd, cat, file, du, find
***

<pre>
ls -la
cd inhere
find . | xargs file

# Tambien mas rapido 
cd ..
file inhere/*

cat ./-file07 --> koReBOKuIDDepwhWk7jZC0RTdopnAYKh

exit
ssh bandit5@bandit.labs.overthewire.org -p 2220 --> koReBOKuIDDepwhWk7jZC0RTdopnAYKh
</pre>


