#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd
source safe/21env.sh
set -vx 
date

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Python Django software..
# got error - use apt-get instead.......  sudo pip install mysql-python
sudo apt-get  -y install python-mysqldb


sudo apt-get -y install python-pip libapache2-mod-wsgi
sudo pip install django==1.8

#sudo pip install django==1.8.7 # install will uninstall other versions.
python -c "import django; print(django.get_version())"


sudo pip install django-admin-bootstrapped
sudo pip install django-admin-generator
sudo pip install virtualenv
pip install MySQL-python

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# for ubuntu 16.04...

sudo systemctl  restart mysql
sudo systemctl restart apache2 


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
date
#
