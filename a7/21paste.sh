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



##  Step 2  as user albe - settings and create provision01.sh.
 
cd
tee ./12settings.sh <<- 'EOF'
# ---------------------------------------------------

# - after getting a new shell


# User settings: run these with every new shell.
#
# Start Step 1
#

# password for user:
export pw1=a

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


# ---------------------------------------------------

## Step 3  as user albe - root stuff

# unneeded?  groupadd www-data
#
git clone https://github.com/dgleba/vamp206a.git shc  ; chmod -R +x  shc/  && \
cd shc ; git pull

#
# unneeded??
#
timedatectl list-timezones | grep -i toronto
 sudo unlink /etc/localtime
 sudo ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime
timedatectl


cd;

export fil=71grpshare.sh ; export pth=shc/a7 ;  chmod +x $pth/$fil  ;  . $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;


cd;

export     fil=64user.sh ; export pth=shc/a7 ;  chmod +x $pth/$fil  ;  . $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;


cd;

export   fil=82docker.sh ; export pth=shc/a7 ;  chmod +x $pth/$fil  ;  . $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;


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

# install github..rupa/z - z-jump

  cd $HOME
  mkdir -p $HOME/bin
  # git clone https://github.com/dgleba/z.git  bin/zjump
  git clone https://github.com/rupa/z.git  bin/zjump
  echo  export _Z_MAX_SCORE=12000>>$HOME/.bashrc
  echo . $HOME/bin/zjump/z.sh>>$HOME/.bashrc
  # execute .bashrc excluding the code that prevents running it again.
  # tail -n+10 ~/.bashrc | bash



echo .;
echo .;
echo 'exit this shell now and login to get new settings.';
echo .;
sleep 9;
# exit # logout to get a fresh env by loging back in.;

 
EOF

export fil=provision01.sh ; export pth=~ ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;












# ---------------------------------------------------


## Step 3 -  Get new shell and...


Get new shell!!!!!
exit

cd;
export fil=91set.sh ; export pth=shc/a7 ;  chmod +x $pth/$fil  ;  . $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;







# ---------------------------------------------------

##  Step 4


# logout and log back in again to ensure all settings are in effect.
# eg: groups will take effect after login.

You could run hostp.sh <newhostname> to give it a unique host name.


done


# ---------------------------------------------------
