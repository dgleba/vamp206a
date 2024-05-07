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


Step 1  as user albe
 

# User settings: run these with every new shell.


export userv=$USER
# or
# just set it explictly..
export userv=albe
#
export hpath=/home/$userv
echo $userv, $hpath



# ---------------------------------------------------



# for debian 10.. 	# for debian 10.. 

su root; 	

apt install sudo;	

/usr/sbin/usermod -aG sudo albe

exit





# ---------------------------------------------------


Step 2  as user albe - root stuff




# if need be, get prompt for  password by - sudo ls...
sudo ls
#
# use && \ to avoid command not running because the one above prevents further execution when pasting several commands at once.
sudo  apt-get update  && \
sudo  apt-get -y install git mc ncdu wget curl locate acl make build-essential  && \
sudo  apt-get -y install build-essential 
# sudo  apt-get -y install  autoremove purge






# ---------------------------------------------------



Step 3  as user albe - root stuff




# groupadd www-data

git clone https://github.com/dgleba/vamp206a.git shc  ; chmod -R +x  shc/  && \
cd shc ; git pull

# chmod -R 775 $hpath/shc
# chown -R $userv $hpath
# chgrp -R $userv $hpath

#
# unneeded??
#
timedatectl list-timezones | grep -i toronto
 sudo unlink /etc/localtime
 sudo ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime
timedatectl


cd /home/$userv
export fil=71grpshare.sh ; export pth=shc/a7 ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;

cd /home/$userv
export fil=64user.sh ; export pth=shc/a7 ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;


cd /home/$userv
export fil=82docker.sh ; export pth=shc/a7 ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;
echo 'exit this shell now and login to get new settings.'
sleep 4
exit # logout to get a fresh env by loging back in.




Step 3a

# new shell, run step 1, then this.


sudo chmod -R 775 $hpath/shc
# sudo chmod -R 775 $hpath/bin2
sudo chown -R $userv $hpath
sudo chgrp -R $userv $hpath



sudo mkdir -p bin
sudo   chown -R $userv bin
sudo   chgrp -R $userv bin
cd
cp shc/bin1/* bin
sudo   chmod -R +x bin




# ---------------------------------------------------


Step 4  as user albe - non-root




# install rupa/z - z-jump
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

mkdir -p /srv/dkr
mkdir -p /srv/test
mkdir -p /srv/file
mkdir -p /srv/web
mkdir -p /srv/share


cd ; export fil=33alias.sh ; export pth=shc/a7 ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;
echo 'exit this shell now and login to get new settings.'
sleep 4
exit # logout to get a fresh env by loging back in.





# ---------------------------------------------------

Step 5





# logout and log back in again to ensure all settings are in effect.
# eg: groups will take effect after login.





done


# ---------------------------------------------------
