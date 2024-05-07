#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd
source safe/21env.sh
set -vx 
date

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $mysqlrootpassw"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $mysqlrootpassw"

#sudo apt-get -y install mysql-server-5.6
# changed for ubuntu 16.04..
sudo apt-get -y install mysql-server

#should this have a -y???
sudo apt-get install -y php5-mysql


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $mysqlrootpassw"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $mysqlrootpassw"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $mysqlrootpassw"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo debconf-set-selections <<< "phpmyadmin  phpmyadmin/remote/port  3306"
sudo apt-get -y install phpmyadmin


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# for ubuntu 16.04...
sudo systemctl  restart mysql
sudo systemctl restart apache2 


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
date
#
