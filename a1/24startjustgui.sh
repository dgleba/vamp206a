#!/usr/bin/env bash
set -x
cd

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# purpose:

# 24start2.sh  = just gui - LXDE.


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# edit the variables in 21env.sh to match your system...
#
source shc/21env.sh

set +vx
echo
echo
echo 24start2.sh will commence...
echo
read -t  888 -p "Hit ENTER or wait about 900 seconds" ; echo ;
set -vx

#comment this out for full auto run...
#exit 0

cd
source shc/root.sh
cd
#source shc/67hostn.sh
cd
source shc/71gui.sh
cd
source shc/73lxset.sh
cd


echo " DONE; Please reboot...  "
#reboot
