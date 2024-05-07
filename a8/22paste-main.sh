#!/usr/bin/env bash


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

## Step 2   - root stuff get code

# use && \ to avoid command not running because the one above prevents further execution when pasting several commands at once.


# might need some software...


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

pkgtoin=docker
command -v $pkgtoin >/dev/null 2>&1 ||
{ echo >&2 "$pkgtoin   is not installed. Installing..";
  sudo  apt-get update  && sudo  apt-get -y install $pkgtoin  docker-compose
}

pkgtoin=make
command -v $pkgtoin >/dev/null 2>&1 ||
{ echo >&2 "$pkgtoin   is not installed. Installing..";
  sudo  apt-get update  && sudo  apt-get -y install $pkgtoin 
}





# ---------------------------------------------------


## get scripts and setup user helpers..


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



  chown -R $userv $hpath
  chgrp -R $userv $hpath



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#  set firewall


sudo ufw disable
sudo ufw logging low 
sudo ufw allow 80/tcp # http
sudo ufw allow 443/tcp # https
sudo ufw allow 46281/tcp  # ssh
sudo ufw limit 22/tcp # limit ssh attempts

sudo ufw deny 2375
sudo ufw deny 2376

# sudo ufw allow 6031/tcp # http
# sudo ufw allow 16123/tcp # http
# sudo ufw allow 16125/tcp # http
# sudo ufw allow 16126/tcp # http

sudo ufw deny 6031/tcp # http
sudo ufw deny 16123/tcp # http
sudo ufw deny 16125/tcp # http
sudo ufw deny 16126/tcp # http

# sudo ufw allow 25
# sudo ufw allow ssh

sudo ufw default deny incoming

sudo ufw enable
sudo ufw status

sudo service ufw stop
sudo service ufw start


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# change ssh port


# echo "Port 46281">>/etc/ssh/sshd_config
# sed -i '1iPort 46281' /etc/ssh/sshd_config
cat /etc/ssh/sshd_config
#    nano /etc/ssh/sshd_config
# extend ssh timeout to 24 hours. 120 sec * 720 or 12 hours = 120 sec * 360 ..
echo "ClientAliveInterval 120" | sudo tee -a /etc/ssh/sshd_config
echo "ClientAliveCountMax 360" | sudo tee -a /etc/ssh/sshd_config


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# https://askubuntu.com/questions/652556/uncomplicated-firewall-ufw-is-not-blocking-anything-when-using-docker

sudo tee -a /etc/docker/daemon.json <<- 'HEREDOC'
{
    "iptables": false
}
HEREDOC
cat /etc/docker/daemon.json

echo 'DOCKER_OPTS="--iptables=false"' | sudo tee -a /etc/default/docker
cat /etc/default/docker
# sudo nano /etc/default/docker
sudo service docker stop
sudo service docker start




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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

export fil=provision01.sh ; export pth=~ ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;




