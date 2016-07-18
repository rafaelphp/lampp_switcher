# lampp_switcher
Simple lampp switcher 

Welcome to the lampp switcher!

before you run it, Please MAKE A BACKUP from your lampp directory, you can do it using:

`~$ sudo tar czvf /home/$USER/lamp.tgz /opt/lampp/`

this script do not install xampp on your machine, just switch between installations

before you run it, make sure you have property install xampp in /opt folder(default for xampp ) in my case I do:

install lampp with php5 on /opt/lampp

rename folder lampp to lampp5 after lampp installation (your version choise)

`~$ sudo mv /opt/lampp /opt/lampp5`

install lampp with php7 on /opt/lampp

rename folder lampp to lampp7 after lampp installation with php7 (your version choice)

`~$ sudo mv /opt/lampp /opt/lampp7`

    $ ls -l /opt
    drwxr-xr-x 30 rafaelphp rafaelphp 4096 jul 15 00:30 lampp5
    drwxr-xr-x 29 rafaelphp rafaelphp 4096 jul 14 20:16 lampp7

!!!!! BACKUP dont forget it, MAKE it an EXECUTABLE !!!!

`~$ sudo chmod +x lampp_switcher.sh`

Run

`~$ ./lampp_switcher.sh`

Enjoy!
