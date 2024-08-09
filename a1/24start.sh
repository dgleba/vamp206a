#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#
cd
set +vx
source shc/21env.sh
set -vx


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# purpose:

# 24start.sh  setup the server



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# edit the variables in 21env.sh to match your system...
#


set +vx
echo
echo
echo 24start.sh will commence...
echo
read -t  999 -p "Hit ENTER or wait about 900 seconds" ; echo ;
set -vx

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

export v206setupfile="/home/$userv/vamp206_setup.log"

if [ -f $v206setupfile ]; then
    echo
    echo "$v206setupfile exits, rename it.."
    echo
    timeout1=9 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
    mv $v206setupfile $v206setupfile$(date +"__%Y.%m.%d_%H.%M.%S").txt
 else
    echo "logfile doesn't exist yet, so continue"
 fi



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#comment this out for full auto run...
#exit 0


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# if root, continue, else exit and end.

cd
source shc/root.sh
cd


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



source shc/15samsh.sh 2>&1 | tee -a $v206setupfile

cd
# use this to get specific data file..
# source shc/17docs.sh
#
# use this for sample data in the repo..
source shc/17docs_sample.sh 2>&1 | tee -a $v206setupfile

cd
source shc/31base.sh 2>&1 | tee -a $v206setupfile
cd
source shc/34samm.sh 2>&1 | tee -a $v206setupfile
cd
source shc/43apach.sh 2>&1 | tee -a $v206setupfile
cd
source shc/47guestad.sh 2>&1 | tee -a $v206setupfile
cd
source shc/62grpshare.sh 2>&1 | tee -a $v206setupfile
source shc/62srvweb.sh 2>&1 | tee -a $v206setupfile
cd
source shc/51dj.sh 2>&1 | tee -a $v206setupfile
cd
source shc/53imp.sh 2>&1 | tee -a $v206setupfile
cd
source shc/61user.sh 2>&1 | tee -a $v206setupfile
cd

source shc/63bauth.sh 2>&1 | tee -a $v206setupfile
cd
source shc/65cron.sh 2>&1 | tee -a $v206setupfile
cd

# see 70gui-notes.sh  - use xfce4

# source shc/71gui.sh
cd
# source shc/73lxset.sh
cd
# source shc/100/321lxdeborderresize.sh
cd
#source shc/67hostn.sh
cd


#read -t  99 -p "Hit ENTER or wait about 99 seconds" ; echo ;


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# set all files owner and group in home to $userv  
cd
sudo chown -R $userv:$userv . 2>&1 | tee -a $v206setupfile
sudo chmod -R +x bin


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



set +vx

echo "DONE...  "
echo "  run this without sudo...  "
echo "     shc/rails/railins.sh  "
echo "  Then this with sudo...  "
echo "     sudo shc/67hostn.sh  "
echo " "
echo "Please reboot after that to get new hostname etc....  "
#reboot
echo ~----------~----------end $HOSTNAME, pwd: `pwd`, "$0" $(date +"__%Y-%m-%d_%H.%M.%S")
