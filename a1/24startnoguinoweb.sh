#!/usr/bin/env bash
set -x
cd

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# purpose:

# 24start3.sh  = no web files, no gui.

# uses 0 length web files 7z file. it is setup -  but no files.



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# edit the variables in 21env.sh to match your system...
#
source shc/21env.sh


set +vx
echo
echo
echo 24start.sh will commence...
echo
read -t  999 -p "Hit ENTER or wait about 900 seconds" ; echo ;
set -vx


#comment this out for full auto run...
#exit 0



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#if you want to proceed with no web data, run this...
cd
touch tmp01/htdocs.PMDS-DATA.latest.7z
mkdir -p tmp01/htdocs
#


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


cd
source shc/root.sh
cd
source shc/15samsh.sh
cd
source shc/17docs.sh
cd
source shc/31base.sh
cd
source shc/34samm.sh
cd
source shc/43apach.sh
cd
#source shc/47guestad.sh
cd
source shc/51dj.sh
cd
source shc/53imp.sh
cd
source shc/61user.sh
cd
source shc/63bauth.sh
cd
source shc/65cron.sh
cd
#source shc/67hostn.sh
cd
#source shc/71gui.sh
cd
#source shc/73lxset.sh
cd

#read -t  99 -p "Hit ENTER or wait about 99 seconds" ; echo ;


echo " DONE; Please reboot...  "
#reboot
