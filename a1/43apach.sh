#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd
source shc/21env.sh
set -vx 

#Note: vbox shares are not available till it reboots after start.sh script runs.
#
#David Gleba 2015-10-01 03:15PM

date

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


sudo cp /var/www/html/index.html /var/www/html/index.html.$(date +"%s").bk


# install apache 2.5 and php 5.5
#sudo apt-get install -y apache2
#sudo apt-get install -y php5

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $mysqlrootpassw"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $mysqlrootpassw"

#sudo apt-get -y install mysql-server-5.6
# changed for ubuntu 16.04..
sudo apt-get -y install mysql-server

#should this have a -y???
sudo apt-get install -y php5-mysql

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $mysqlrootpassw"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $mysqlrootpassw"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $mysqlrootpassw"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo debconf-set-selections <<< "phpmyadmin  phpmyadmin/remote/port  3306"
sudo apt-get -y install phpmyadmin
sudo apt-get -y install php5-xsl
sudo apt-get -y install php5-intl
sudo apt-get -y install php5-gd
sudo apt-get -y install php5-mcrypt
sudo apt-get -y install php5-sqlite

sudo apt-get -y install python-dev
sudo apt-get -y install libmysqlclient-dev
sudo apt-get -y install python3-dev python3-setuptools libjpeg-dev zlib1g-dev
sudo apt-get -y install php5-ldap


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



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# install ftp server...
#    https://help.ubuntu.com/lts/serverguide/ftp-server.html
apt-get -y install vsftpd
# uncomment #write_enable=YES
sudo sed -i "s@#write_enable=YES@write_enable=YES@g" /etc/vsftpd.conf
sudo service vsftpd restart


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# install sendmail...
#    http://askubuntu.com/questions/47609/how-to-have-my-php-send-mail
sudo apt-get -y install ssmtp


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#  edit /etc/ssmtp/ssmtp.conf -- edit  mailhub=mail .. replace entire line with mailhub...
#
# didn't work due to variation in original file. try to replace the line matching string with sed.
#   sudo sed -i "s@mailhub=mail@mailhub=MESG01.stackpole.ca@g"  /etc/ssmtp/ssmtp.conf
#
# backup file before editing...
sudo cp /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.bk.$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")
sudo cp /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.$(date +"%Y-%m-%d_%s").bk

# remove line containing  'mailhub'  and replace th line completely with the new text...
# add marker line above my edits... 
# add a marker comment like: #David Gleba 2015-10-16... http://stackoverflow.com/questions/11694980/using-sed-insert-a-line-below-or-above-the-pattern
# now replace the line... http://stackoverflow.com/questions/16440377/sed-replace-whole-line-when-match-found
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sed -i "/mailhub/i # \n# David Gleba kdg54 $nowdg1 ...\n#"  /etc/ssmtp/ssmtp.conf
sed -i 's/.*mailhub.*/mailhub=MESG01.stackpole.ca/g' /etc/ssmtp/ssmtp.conf

#working on --  hostname=
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sudo sed -i "/hostname=/i # \n# David Gleba kdg54 $nowdg1 ...\n#"  /etc/ssmtp/ssmtp.conf
sudo sed -i "s/.*hostname=.*/hostname=$default_hostname.$default_domain/g" /etc/ssmtp/ssmtp.conf


#working on --  FromLineOverride=
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sudo sed -i "/FromLineOverride=/i # \n# David Gleba kdg54 $nowdg1 ...\n#"  /etc/ssmtp/ssmtp.conf
sudo sed -i 's/.*FromLineOverride=.*/FromLineOverride=YES/g' /etc/ssmtp/ssmtp.conf

cat /etc/ssmtp/ssmtp.conf


# set mail name

sudo cp /etc/mailname /etc/mailname.$(date "+%Y-%m-%d_%s").bk
sudo echo $default_hostname.$default_domain | sudo tee /etc/mailname
cat /etc/mailname

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# edit /etc/php5/apache2/php.ini
# sudo nano /etc/php5/apache2/php.ini
sudo sed -i "s@;sendmail_path =@sendmail_path = /usr/sbin/sendmail -t@g"  /etc/php5/apache2/php.ini


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# enable mod_rewrite
sudo a2enmod rewrite

# restart apache
sudo service apache2 restart

# install git
sudo apt-get -y install git

# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer


sudo cp /var/www/html/index.html /var/www/html/index.html.$(date +"%s").bk

# for ubuntu 16.04...
sudo systemctl mysql restart
sudo systemctl apache2 restart


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


function createindex1() 
{
sudo tee /var/www/html/index.html <<EOF
<html>
<body>
<div style="width: 100%; font-size: 22px; font-weight: bold; text-align: left;">
This address is offline. Try another address... 
</div>
<h5>2015-10-27
</h5>
</body>
</html>
EOF
}


#
date
#
