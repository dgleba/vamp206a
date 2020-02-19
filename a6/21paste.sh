#!/usr/bin/env bash


#  paste this into the command prompt on the new server..
#    use putty or some ssh client that you can paste text into..

#    use filezilla - connection over ssh to put files on the server
#      to edit files on the server right click on a file and select edit.
#      if you need to edit files as root, copy it to writable folder and then   
#         copy it over after editing, or just use sudo sed etc to edit the files.

  
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Step 1  as user albe
 


# ---------------------------------------------------

Step 2 as root


export userv=$USER
su root;

cd
# if need be, get prompt for sudo password...
sudo ls
#
sudo apt-get update && \
sudo apt-get -y install git mc ncdu wget curl  locate acl make  build-essential autoremove purge && \

sudo groupadd www-data

#
# unneeded??
timedatectl list-timezones | grep -i toronto
sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime
timedatectl

cd ; export fil=71grpshare.sh ; export pth=shc/a6 ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;
exit # logout to get a fresh env by loging back in.

cd ; export fil=82docker.sh ; export pth=shc/a6 ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;
exit # logout to get a fresh env by loging back in.





# ---------------------------------------------------

Step 3  as user albe
  


export userv=$USER
cd ; git clone https://github.com/dgleba/vamp206a.git shc  ; chmod -R +x  shc/  && \
cd ; cd shc ; git pull


# install z-jump
  cd $HOME
  mkdir -p $HOME/bin
  git clone https://github.com/dgleba/z.git  bin/zjump
  echo . $HOME/bin/zjump/z.sh >> $HOME/.bashrc
  source $HOME/.bashrc
  z -h
  z -h
  cd
  z
  z

mkdir -p bin
  chown -R $userv bin
  chgrp -R $userv bin
  cd
  cp shc/bin1/* bin
  chmod -R +x bin


cd ; export fil=33alias.sh ; export pth=shc/a6 ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;
exit # logout to get a fresh env by loging back in.





# ---------------------------------------------------

Step 4





Step 6






Step 7

# logout and log back in again to ensure all settings are in effect.
# eg: groups will take effect after login.





done


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
