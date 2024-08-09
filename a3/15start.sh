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

# 15start.sh  setup the server



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# get commmand line arguments / parameters

export CLEAR='\033[0m'
export RED='\033[0;31m'
  echo -e "${CLEAR}"

usage() {
  if [ -n "$1" ]; then
    echo -e "${RED}ERROR $1\n";
  fi
  echo "Usage: $0 [-t install-type] "
  echo "  -t, --install-type   Type of install, regularmysqlserver, columnstore, or custom1"
  echo ""
  echo "Example: $0 -t regularmysqlserver "
  echo -e "${CLEAR}"
  exit 1
}

# parse params
while [[ "$#" > 0 ]]; do case $1 in
  -t|--install-type) tname="$2"; shift;shift;;
  *) usage "Unknown parameter passed: $1"; shift; shift;;
esac; done

# verify params
if [ -z "$tname" ]; then usage "install-type not supplied"; fi;

export etname=${tname}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# edit the variables in 21env.sh to match your system...
#


set +vx
echo
echo
echo 15start.sh will commence...
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

cd; source shc/a3/31timeshift.sh 
# cd; source shc/a3/32init.sh 
cd; source shc/a3/81docker.sh 

cd
# use this to get specific data file..
# source shc/a3/17docs.sh
#
# use this for sample data in the repo..
source shc/a3/38docs_sample.sh 
cd; source shc/a3/35base.sh 
cd; source shc/a3/62grpshare.sh 
cd; source shc/a3/62srvweb.sh 
cd; source shc/a3/61user.sh 
cd; source shc/a3/63bauth.sh 
cd;

# mariadb columnstore -- then look at apps/mcs/*


}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




regularmysqlserver()
{

# For my regular mysql server..

cd; source shc/a3/31timeshift.sh 
# cd; source shc/a3/32init.sh 
# cd; source shc/a3/81docker.sh 

cd
# use this to get specific data file..
# source shc/a3/17docs.sh
#
# use this for sample data in the repo..
source shc/a3/38docs_sample.sh 

cd; source shc/a3/35base.sh 
cd; #source shc/a3/34samm.sh 
cd; source shc/a3/43apach.sh 
cd; source shc/a3/43mysql.sh 
cd; source shc/a3/44django.sh 
cd; # source shc/a3/47guestad.sh 
cd; source shc/a3/62grpshare.sh 
cd; source shc/a3/62srvweb.sh 
cd; source shc/a3/51dj.sh 
cd; source shc/a3/53imp.sh 
cd; source shc/a3/61user.sh 
cd; source shc/a3/63bauth.sh 
cd; source shc/a3/65cron.sh 
cd; # see 70gui-notes.sh  - use xfce4
    # source shc/a3/71gui.sh
cd; # source shc/a3/73lxset.sh
cd; # source shc/100/321lxdeborderresize.sh
cd; #source shc/a3/67hostn.sh
cd;

}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


custom1()
{

# custom other workflow..

# cd; source shc/a3/31timeshift.sh 
# cd; source shc/a3/32init.sh 
# cd; source shc/a3/81docker.sh 

# cd; source shc/a3/38docs_sample.sh 
# cd; source shc/a3/35base.sh 
cd; source shc/a3/62grpshare.sh 
cd; source shc/a3/62srvweb.sh 
cd; source shc/a3/61user.sh 
cd;

}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


docker1()
{

# docker workflow..


cd; source shc/a3/35base.sh 
cd; # source shc/a3/32init.sh 
cd; source shc/a3/62grpshare.sh 
cd; source shc/a3/62srvweb.sh 
#cd; source shc/a3/61user.sh 
cd; source shc/a3/81docker.sh 
cd;

}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





# Main...

#  uncomment one function or the other, regular or columnstore or custom...

# regularmysqlserver
# columnstore
# custom1
${tname}


 
# set all files owner and group in home to $userv  
cd
sudo chown -R $userv:$userv . 
sudo chmod -R +x bin

set +vx

echo "DONE...  "
echo "  run this without sudo...  "
echo "     shc/rails/railins.sh  "
echo "  Then this with sudo...  "
echo "     sudo shc/a3/67hostn.sh  "
echo " "
echo "Please reboot after that to get new hostname etc....  "
#reboot
echo ~----------~----------end $HOSTNAME, pwd: `pwd`, "$0" $(date +"__%Y-%m-%d_%H.%M.%S")
