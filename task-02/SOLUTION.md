## Clone the repository given
`$ git clone https://github.com/amansxcalibur/Terminal-Chaos.git`

## Part 1
Moved into Eolian Caves and searched for parchment.  
`$ cd Terminal-Chaos/Arrakis-dex/'Eolian Caves' `  
`$ find . -name '*parchment*'`  
`$ cat Entrance3/01/parchment.txt`  

```
code1: aHR0cHM6Ly9naXRo
```
## Part 2
Moved into The Light Realm Directory and searched for filenames which have both “holy" and "good” inside their content.  
`$ git branch -a`  
`$ git checkout remotes/origin/The-Light-Realm`  
`$ grep -rEl 'holy.*good|good.*holy'`  

Moonbloom.txt   
Moonbloom.txt  
Mistveil.txt   

Holy spell: LnnmknnlLhrsdhk

`$ git checkout origin/The-Dark-Realm-I`
`$ tree`

```
.
├── Celestial Veil Amulet.txt
└── LightBook.txt
```

`$ cat "Celestial Veil Amulet.txt"`  
Celestial Veil Amulet: CSigVmaroAn

`$ cat "LightBook.txt"`  
```
code2: dWIuY29tL2FtYW5ze
```

## Part 3

`$ cd Entrance3/01/01L/01/02/01/02/01/Citadel`  
`$ python3 -u "KharnokTheBloodForged.py"`  
DEMIGOD FELLED  
UNLOCKED LIGHT REALM

`$ python3 -u "chest1.py"`  
`$ cat DarkBookI.txt`  
```
code3: GNhbGlidXIvVGVyb
```

`$ git checkout The-Dark-Realm-II`  
`$ cd 'Eolian Caves'/Entrance3/01/01D/01/'narrow path'/path/0D/02/01/Chamber`  
`$ cat DarkBookII.txt`  
```
code4: WluYWwtQ2hhb3MtR29kU3VpdGU=
```

## Part 4

combined code
```
aHR0cHM6Ly9naXRodWIuY29tL2FtYW5zeGNhbGlidXIvVGVybWluYWwtQ2hhb3MtR29kU3VpdGU=
```
after decoding  
https://github.com/amansxcalibur/Terminal-Chaos-GodSuite

## Part 5

`$ git clone https://github.com/amansxcalibur/Terminal-Chaos-GodSuite.git`

`$ cd Terminal-Chaos-GodSuite`  
`$ git log --oneline`  

`$ git show 68c79b2`  
```
code: aHR0cHM6Ly9naXRodWIuY29tL2FuZ3JlemljaGF0dGVyYm94L1RvLXRoZS1zdGFycy1hbmQtcmVhbG1zLXVuc2Vlbg==
```
after decoding  
https://github.com/angrezichatterbox/To-the-stars-and-realms-unseen

`$ git clone https://github.com/angrezichatterbox/To-the-stars-and-realms-unseen.git`

`$ python3 victory.py --run`
```
Congratulations nandita-rajesh!!! You have successfully overcome the challenges and escaped the deadly clutches of Arrakis-dex.
You will now be able to join the war again spreading your faith for the Emperor and humankind!!
Take a screenshot of this and save it in your handbook folder along with the other codes you have collected.
Stand proud, champion!
```
