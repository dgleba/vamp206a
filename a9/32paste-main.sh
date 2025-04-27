#!/usr/bin/env bash
# ---------------------------------------------------
# ---------------------------------------------------


##  Step 2b  as albe - settings and create provision01.sh.
 
# copy paste step 2b into vps terminal. Just ctrl-A select all and paste all of this file.
 
echo starting to paste 22paste-main.sh 
cd
tee ./12settings.sh <<- 'EOF'
# ---------------------------------------------------


#
# This `12settings.sh`  may not be needed.
#


# - after getting a new shell


# User settings: run these with every new shell.
#
# Start Step 1
#

# password for user:
##############export pw1=a

# save user to avoid any change where user root is substituted:
export userv=$USER
# or
# just set it explictly..
# export userv=albe
export hpath=/home/$userv
echo $userv, $hpath

umask 002 # make group writable.

timeout1=5 > /dev/null 2>&1; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..."  || true   
# End Step 1

# ---------------------------------------------------

EOF
chmod +x ~/12settings.sh;


cd
tee ./setup206-01.sh <<- 'EOF'
. ~/12settings.sh

# ---------------------------------------------------


#
#
## Step 2   - root stuff get code
#
#

# use && \ to avoid command not running because the one above prevents further execution when pasting several commands at once.


# might need some software...



#
##### Install packages listed in array2....
#
array2=( 
git  make  locate
ufw
curl  wget  rsync mc
openssh-server
)
#
for a3 in "${array2[@]}" ; do  
  echo $a3 ; 
  pkgtoin=$a3
  command -v $pkgtoin >/dev/null 2>&1 ||
  { echo >&2 " ~*~*~*~*~   $pkgtoin   is not installed. Installing..";
    sudo  apt-get -y install $pkgtoin
  }
done

 




# ---------------------------------------------------

#
#
## get scripts and setup user helpers..
#
#


#
git clone https://github.com/dgleba/vamp206a.git shc  ; chmod -R +x  shc/  && \
cd shc ; git pull



cd ; 
export    fil=33alias.sh ; export pth=shc/acom ;  chmod +x $pth/$fil  ;  .  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;


# install github..rupa/z - z-jump

  cd $HOME
  mkdir -p $HOME/bin
  # git clone https://github.com/dgleba/z.git  bin/zjump
  git clone https://github.com/rupa/z.git  bin/zjump
  echo  export _Z_MAX_SCORE=12000>>$HOME/.bashrc
  echo . $HOME/bin/zjump/z.sh>>$HOME/.bashrc
  # execute .bashrc excluding the code that prevents running it again.
  # tail -n+10 ~/.bashrc | bash

# copy scripts to home bin folder..
mkdir -p bin
  chown -R $userv bin
  chgrp -R $userv bin
cd
cp shc/bin1/* bin
  chmod -R +x bin


# modify user..

sudo usermod -g staff $userv;
sudo usermod -a -G www-data $userv; sudo usermod -a -G docker  $userv;


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
# set timezone
#


timedatectl list-timezones | grep -i toronto
 sudo unlink /etc/localtime
 sudo ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime
timedatectl




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
#
# change ssh connection timeout
#
#


file1=/etc/ssh/sshd_config.d/clientactive.conf
sudo cp $file1 $file1$(date +"__%Y.%m.%d_%H.%M.%S").bak.txt     # do you need sudo cp?
# extend ssh timeout to 24 hours = 120 sec * 720 .  --  12 hours = 120 sec * 360 ..
echo "ClientAliveInterval 120"  | sudo tee  /etc/ssh/sshd_config.d/clientactive.conf
echo "ClientAliveCountMax 700" | sudo tee -a /etc/ssh/sshd_config.d/clientactive.conf

sudo systemctl reload sshd



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
#
#  ufw
#       https://askubuntu.com/questions/652556/uncomplicated-firewall-ufw-is-not-blocking-anything-when-using-docker
#
#

# removed  /etc/docker/daemon.json  stanza 2023-05-12



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#
#
#  docker group and git shortcuts..
# 
#
#

# for albe user..
sudo adduser albe docker
sudo mkdir -p /ap
sudo chown albe:albe /ap
sudo chown albe:staff /ap
sudo chmod 775 /ap
sudo mkdir -p /acrib
sudo chown albe:albe /acrib
sudo chown albe:staff /acrib
sudo chmod 775 /acrib

# for current user..
sudo adduser $userv docker
sudo mkdir -p /ap
sudo chown $userv:$userv /ap
sudo chown $userv:staff /ap
sudo chmod 775 /ap
sudo mkdir -p /acrib
sudo chown $userv:$userv /acrib
sudo chown $userv:staff /acrib
sudo chmod 777 /acrib

# set sticky group...
sudo chmod g+s /ap
sudo chmod g+s /acrib



cd && bash shc/bin1/gitali.sh


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#  A general purpose log folder with logrotate


# maxage 7 means it will only compress logs after 7 days.

sudo mkdir -p /ap/log
sudo chown -R $USER:$USER /ap/log
sudo chmod -R 777 /ap/log

sudo tee /etc/logrotate.d/ap_log <<EOF
/ap/log/*.log {
    daily
    size 110K
    rotate 30
    missingok
    notifempty
    copytruncate
}
EOF



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


echo .;
echo .;
echo 'exit this shell now and login to get new settings.';
echo .;echo .;
echo .;
echo 'again.. exit this shell now and login to get new settings.';
echo .;echo .;
echo .;
echo 'again... EXIT THIS SHELL now and login to get new settings.';
echo .;
sleep 9;
# exit # logout to get a fresh env by loging back in.;

 
EOF

export fil=setup206-01.sh ; export pth=~ ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;
# ---------------------------------------------------



