cd#!/usr/bin/env bash


#  paste this into the command prompt on the new server..
#    use putty or some ssh client that you can paste text into..

#    use filezilla - connection over ssh to put files on the server
#      to edit files on the server right click on a file and select edit.
#      if you need to edit files as root, copy it to writable folder and then   
#         copy it over after editing, or just use  sed etc to edit the files.

  
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Step 1  as user albe
 

export userv=$USER
echo $userv
su root;



# ---------------------------------------------------


Step 2 as root




# if need be, get prompt for  password...
 ls
#
 apt-get update 
 apt-get -y install git mc ncdu wget curl  locate acl make  build-essential 
 apt-get -y install  autoremove purge

 groupadd www-data



 git clone https://github.com/dgleba/vamp206a.git shc  ; chmod -R +x  shc/  && \
 cd shc ; git pull
  chown -R $userv .
  chgrp -R $userv .
#
# unneeded??
#
# timedatectl list-timezones | grep -i toronto
 # unlink /etc/localtime
 # ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime
# timedatectl

cd /home/$userv
export fil=71grpshare.sh ; export pth=shc/a6 ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;


cd /home/$userv
export fil=82docker.sh ; export pth=shc/a6 ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;
echo 'exit this shell now and login to get new settings.'
sleep 4
exit # logout to get a fresh env by loging back in.





# ---------------------------------------------------

Step 3  as user albe
  



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
echo 'exit this shell now and login to get new settings.'
sleep 4
exit # logout to get a fresh env by loging back in.





# ---------------------------------------------------

Step 4





Step 6






Step 7

# logout and log back in again to ensure all settings are in effect.
# eg: groups will take effect after login.





done


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
