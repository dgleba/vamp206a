cd#!/usr/bin/env bash

# ---------------------------------------------------


#  paste commands below into the command prompt on the new server.
#    The server will need open-ssh-server installed. You can connect with username and password.
#    use putty or some ssh client that you can paste text into.
#     Other clients are mremote, windows ssh in command prompt. There are many others. 

#    Use filezilla - connection over ssh to put files on the server.
#      To edit files on the server right click on a file and select edit.
#      if you need to edit files as root, copy it to writable folder and then   
#         copy it back after editing, or just use sed or nano to edit the files.
#      Another option is cyberduck.


# ---------------------------------------------------




##  Step 1  as user albe - settings.


# get prompt for sudo. This will avoid sending pasted characters to the password prompt, which leads to them missing when they are needed.


# They way I paste commands, it usually has extra characters, like new lines. This can end up in the password prompt.
#   I need to backspace before entering my password.



sudo ls





# ---------------------------------------------------



##  Step 2  as root or albe - settings and create provision01.sh.
 
# copy paste step 2 into vps terminal.
 
 
cd
tee ./12settings.sh <<- 'EOF'
# ---------------------------------------------------

# - after getting a new shell


# User settings: run these with every new shell.
#
# Start Step 1
#

# password for user:
##############export pw1=a

# save user to avoid any change user root is substituted:
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
tee ./provision01.sh <<- 'EOF'
. ~/12settings.sh

# ---------------------------------------------------

## Step 2  as user albe - root stuff get code

# use && \ to avoid command not running because the one above prevents further execution when pasting several commands at once.


command -v git >/dev/null 2>&1 ||
{ echo >&2 "Git is not installed. Installing..";
  sudo  apt-get update  && sudo  apt-get -y install git 
}

pkgtoin=ufw
command -v $pkgtoin >/dev/null 2>&1 ||
{ echo >&2 "$pkgtoin   is not installed. Installing..";
  sudo  apt-get update  && sudo  apt-get -y install $pkgtoin 
}

pkgtoin=fail2ban
command -v $pkgtoin >/dev/null 2>&1 ||
{ echo >&2 "$pkgtoin   is not installed. Installing..";
  sudo  apt-get update  && sudo  apt-get -y install $pkgtoin 
}



# ---------------------------------------------------

## Step 3  as user albe - root stuff

#
git clone https://github.com/dgleba/vamp206a.git shc  ; chmod -R +x  shc/  && \
cd shc ; git pull

#
# tz
#
timedatectl list-timezones | grep -i toronto
 sudo unlink /etc/localtime
 sudo ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime
timedatectl


cd;

cd ; 
export    fil=33alias.sh ; export pth=shc/acom ;  chmod +x $pth/$fil  ;  .  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;



# sudo chmod -R 775 $hpath/shc
# sudo chmod -R 775 $hpath/bin2
  chown -R $userv $hpath
  chgrp -R $userv $hpath

# copy scripts to home bin folder..
mkdir -p bin
  chown -R $userv bin
  chgrp -R $userv bin
cd
cp shc/bin1/* bin
  chmod -R +x bin


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


sudo ufw logging low 
sudo ufw allow 80/tcp # http
sudo ufw allow 443/tcp # https
sudo ufw allow 46281/tcp  # ssh
sudo ufw limit 22/tcp # limit ssh attempts
# sudo ufw allow 25
# sudo ufw allow ssh
sudo ufw enable
sudo ufw status


sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo service fail2ban restart

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# change ssh port
# echo "Port 46281">>/etc/ssh/sshd_config
# sed -i '1iPort 46281' /etc/ssh/sshd_config
cat /etc/ssh/sshd_config
#    nano /etc/ssh/sshd_config
# extend ssh timeout to 24 hours. 120 sec * 720
echo "ClientAliveInterval 120" | sudo tee -a /etc/ssh/sshd_config
echo "ClientAliveCountMax 360" | sudo tee -a /etc/ssh/sshd_config


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# install github..rupa/z - z-jump

  cd $HOME
  mkdir -p $HOME/bin
  # git clone https://github.com/dgleba/z.git  bin/zjump
  git clone https://github.com/rupa/z.git  bin/zjump
  echo  export _Z_MAX_SCORE=12000>>$HOME/.bashrc
  echo . $HOME/bin/zjump/z.sh>>$HOME/.bashrc
  # execute .bashrc excluding the code that prevents running it again.
  # tail -n+10 ~/.bashrc | bash


sudo apt  -y install  docker
sudo apt  -y install  docker-compose 


echo .;
echo .;
echo 'exit this shell now and login to get new settings.';
echo .;
sleep 9;
# exit # logout to get a fresh env by loging back in.;

 
EOF

export fil=provision01.sh ; export pth=~ ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;
















# ---------------------------------------------------

##  Step 3

exec bash

nuser.sh albe

sudo adduser albe sudo
sudo mkdir /ap
sudo chown albe:albe /ap



done


# ---------------------------------------------------
