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

 
 
##fail2ban

pkgtoin=fail2ban
command -v fail2ban-client >/dev/null 2>&1 ||
{ echo >&2 "$pkgtoin   is not installed. Installing..";
   sudo  apt-get -y install $pkgtoin
}






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


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
# set timezone
#


timedatectl list-timezones | grep -i toronto
 sudo unlink /etc/localtime
 sudo ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime
timedatectl



  # chown -R $userv $hpath
  # chgrp -R $userv $hpath




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
#  fail2ban
# 
#
#


# albe@pmsdo545:/ap/tmp$ diff jail.local  jail.conf
# ---
# uncomment < bantime.increment = true
# uncomment and set 100 < bantime.rndtime = 100


sudo tee -a /etc/fail2ban/jail.local <<- 'HEREDOC'

bantime.increment = true
bantime.rndtime = 100
HEREDOC

sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo service fail2ban restart
sudo fail2ban-client status


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#
#
#  docker group and git shortcuts..
# 
#
#

sudo adduser albe docker
sudo mkdir -p /ap
sudo chown albe:albe /ap
sudo chown albe:www-data /ap
sudo mkdir -p /acrib
sudo chown albe:albe /acrib
sudo chown albe:www-data /acrib



cd && bash shc/bin1/gitali.sh


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



