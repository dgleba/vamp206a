
# unInstall mariadb columnstore on ubuntu 16.04

usage()
{

# usage:   

           cd ; sudo chmod -R +x shc/ ; 
           sudo  shc/apps/mcs/uninstall_mariadbcolumnstore.sh 2>&1 | tee -a v206_mcs-uninstall-log$(date +"__%Y-%m-%d_%H.%M.%S").log

}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#!/usr/bin/env bash

set +vx
echo
# echo this is not finished to run as a script. Just copy paste from this file..
echo
# echo exiting...
echo
timeout1=5 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
# exit 99


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd
set +vx
source safe/21env.sh
set -vx


sudo localedef -i en_US -f UTF-8 en_US.UTF-8
sudo apt-get update


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd
mkdir sw1
cd sw1
   

#sudo dpkg -l *mariadb-col*
#sudo apt-get remove --purge *mariadb-col\*

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

alias mcsmysql='/usr/local/mariadb/columnstore/mysql/bin/mysql --defaults-extra-file=/usr/local/mariadb/columnstore/mysql/my.cnf -u root'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


exit 0

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# notes...



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2018-02-12[Feb-Mon]10-45AM




uninstall summary..



sudo su

# remove list of packages from dpkg --list  --  https://linuxprograms.wordpress.com/tag/dpkg-remove/


dpkg -l | grep -i mysq



# list packages to remove..
  sudo dpkg --list *mysql*
  sudo dpkg --list *mariadb-col* | grep maria | cut -d " " -f 3
  sudo dpkg --list *mariadb* | grep maria | cut -d " " -f 3

# remove them..
  sudo dpkg --list *mariadb* | grep maria | cut -d " " -f 3 | xargs sudo dpkg --purge --force-all

# https://mariadb.com/kb/en/library/mariadb-installation-dependancy-problems-and-failed-to-start-service/
 
  sudo dpkg  --purge   php7.0-mysql php-mysql mariadb-client phpmyadmin dbconfig-mysql mailutils libmailutils4 libdbd-mysql-perl libmysqlclient-dev libmysqlclient20
  sudo dpkg --purge mysql-common 
 
  sudo apt-get remove --purge mariadb-server mariadb-client 
  sudo apt-get -y autoremove
  sudo apt-get -y autoclean 

  sudo dpkg  --purge --force-all    dbconfig-mysql
  sudo dpkg  --purge     dbconfig-mysql
 
  sudo rm -rf /usr/local/mariadb

  sudo apt install -f
  sudo apt -y autoremove
  sudo apt -y autoclean 

sudo  updatedb
locate my.cnf




_____________



 sudo apt-get remove --purge mysql-server mysql-client mysql-common -y
 sudo apt-get autoremove -y
 sudo apt-get autoclean






_____________


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



detail..



# remove list of packages from dpkg --list  --  https://linuxprograms.wordpress.com/tag/dpkg-remove/

# list packages to remove..
dpkg --list *mysql*
dpkg --list *mariadb-col* | grep maria | cut -d " " -f 3
dpkg --list *mariadb* | grep maria | cut -d " " -f 3

# remove them..
dpkg --list *mariadb* | grep maria | cut -d " " -f 3 | xargs sudo dpkg --purge --force-all


root@pmdsdata7:/home/albe# dpkg --list *mariadb-col* | grep maria | cut -d " " -f 3 | xargs sudo dpkg --purge
dpkg: dependency problems prevent removal of mariadb-columnstore-client:
 dbconfig-mysql depends on mysql-client | mariadb-client | virtual-mysql-client; however:
  Package mysql-client is not installed.
  Package mariadb-columnstore-client which provides mysql-client is to be removed.
  Package mariadb-columnstore-client which provides mysql-client is to be removed.
  Package mariadb-client is not installed.
  Package virtual-mysql-client is not installed.
 dbconfig-mysql depends on mysql-client | mariadb-client | virtual-mysql-client; however:
  Package mysql-client is not installed.
  Package mariadb-columnstore-client which provides mysql-client is to be removed.
  Package mariadb-columnstore-client which provides mysql-client is to be removed.
  Package mariadb-client is not installed.
  Package virtual-mysql-client is not installed.

dpkg: error processing package mariadb-columnstore-client (--purge):
 dependency problems - not removing
dpkg: dependency problems prevent removal of mariadb-columnstore-common:
 mariadb-columnstore-client depends on mariadb-columnstore-common.

dpkg: error processing package mariadb-columnstore-common (--purge):
 dependency problems - not removing
Errors were encountered while processing:
 mariadb-columnstore-client
 mariadb-columnstore-common
root@pmdsdata7:/home/albe#

dpkg: dependency problems prevent removal of mariadb-columnstore-client: dbconfig-mysql depends on mysql-client | mariadb-client | virtual-mysql-client; however: Package mysql-client is not installed
 
_____________

 
https://mariadb.com/kb/en/library/mariadb-installation-dependancy-problems-and-failed-to-start-service/
 
 sudo apt-get remove --purge mariadb-server mariadb-client 
 sudo apt-get autoremove
 sudo apt-get autoclean 
 
_____________

 
 dpkg  --purge mariadb-client phpmyadmin dbconfig-mysql mailutils libmailutils4 libdbd-mysql-perl libmysqlclient-dev libmysqlclient20
 dpkg --purge mysql-common 

____________


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2018-02-12[Feb-Mon]10-53AM

ref:

root@pmdsdata7:/home/albe# locate my.cnf
/etc/alternatives/my.cnf
/var/lib/dpkg/alternatives/my.cnf
root@pmdsdata7:/home/albe#


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 