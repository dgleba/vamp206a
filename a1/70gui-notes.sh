#!/usr/bin/env bash

saynow()
{
date1=$(date +"__%Y.%m.%d_%H.%M.%S")
echo $date1
timeout1=5 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function offline21() {

echo tmp1
exit 999

: <<'BLOCKCOMMENT'

  Purpose:  gui notes 


2017-03-13 new preference xfce4

sudo apt install xfce4

Don't use 71gui.sh or 73lxset.sh
    !!keep those files for the tips they contain.


_____________

ubuntu 16.04 lxde disable gui at startup
2017-03-13:
https://superuser.com/questions/1106174/boot-ubuntu-16-04-into-command-line-do-not-start-gui

You could disable the display manager service with systemctl for example if your display manager is  lightdm the run 
            sudo systemctl disable lightdm.service
 This will prevent the service from starting at boot.
Edit:
I forgot to mention how to start the GUI, Its as simple as starting the service 
                sudo systemctl start lightdm.service


renable it - boot to gui ...
sudo systemctl set-default graphical.target
# ?? sudo systemctl enable lightdm.service
sudo dpkg-reconfigure lightdm



sudo apt install xinit  # for startx

---

got black screen on startup of X..
turned off auto start of x
startx
got..
xauth timeout in locking authority file
https://www.digitalocean.com/community/questions/timeout-in-locking-authority-file-home-username-xauthority
fixed it with...
sudo rm ./.Xauthority



_____________ 




BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#main...
date

sudo rm ./.Xauthority
sudo apt install xinit  # for startx


#


