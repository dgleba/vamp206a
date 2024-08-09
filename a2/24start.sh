#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#
cd
set +vx
source safe/21env.sh
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

# if root, continue, else exit and end.

cd
source shc/root.sh
cd


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


columnstore()
{

# for maria columnstore..

source shc/a2/15samsh.sh 

cd
# use this to get specific data file..
# source shc/a2/17docs.sh
#
# use this for sample data in the repo..
source shc/a2/17docs_sample.sh 
cd; source shc/a2/31base.sh 
cd; source shc/a2/62grpshare.sh 
cd; source shc/a2/62srvweb.sh 
cd; source shc/a2/61user.sh 
cd; source shc/a2/63bauth.sh 
cd;

# mariadb columnstore -- then look at apps/mcs/*


}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




regularmysqlserver()
{

# For my regular mysql server..

cd; source shc/a2/15samsh.sh 

cd
# use this to get specific data file..
# source shc/a2/17docs.sh
#
# use this for sample data in the repo..
source shc/a2/17docs_sample.sh 

cd; source shc/a2/31base.sh 
cd; #source shc/a2/34samm.sh 
cd; source shc/a2/43apach.sh 
cd; source shc/a2/43mysql.sh 
cd; source shc/a2/44django.sh 
cd; # source shc/a2/47guestad.sh 
cd; source shc/a2/62grpshare.sh 
cd; source shc/a2/62srvweb.sh 
cd; source shc/a2/51dj.sh 
cd; source shc/a2/53imp.sh 
cd; source shc/a2/61user.sh 
cd; source shc/a2/63bauth.sh 
cd; source shc/a2/65cron.sh 
cd; # see 70gui-notes.sh  - use xfce4
    # source shc/a2/71gui.sh
cd; # source shc/a2/73lxset.sh
cd; # source shc/100/321lxdeborderresize.sh
cd; #source shc/a2/67hostn.sh
cd;

}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


custom1()
{

# custom other workflow..

cd; source shc/a2/15samsh.sh 
cd



}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





# Main...

#  uncomment one function or the other, regular or columnstore...

# regularmysqlserver
# columnstore
custom1


 
# set all files owner and group in home to $userv  
cd
sudo chown -R $userv:$userv . 
sudo chmod -R +x bin

set +vx

echo "DONE...  "
echo "  run this without sudo...  "
echo "     shc/rails/railins.sh  "
echo "  Then this with sudo...  "
echo "     sudo shc/a2/67hostn.sh  "
echo " "
echo "Please reboot after that to get new hostname etc....  "
#reboot
echo ~----------~----------end $HOSTNAME, pwd: `pwd`, "$0" $(date +"__%Y-%m-%d_%H.%M.%S")
