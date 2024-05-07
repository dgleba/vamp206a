#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

cd
source safe/21env.sh
set -vx
date

basauth1()
{
sudo tee /etc/apache2/sites-available/baseauth1.conf <<EOF
#
# require authentication under /var/www/html/authbasic
 <Directory /var/www/html/authbasic>
    AuthType Basic
    AuthName "===== Authbasic folder ====="
    AuthUserFile /etc/apache2/.htpasswd
    require valid-user
</Directory>
#
EOF
}

basauthmain()
{
sudo tee /etc/apache2/sites-available/baseauthmain.conf <<EOF
#
#this needed to make banner work for most files...
AddType application/x-httpd-php htm
AddType application/x-httpd-php html

# require authentication under /var/www/html
 <Directory /var/www/html>
    AllowOverride all
    AuthType Basic
    AuthName "  =====   Authbasic PMDSDATA Whole Site Apache   ===== "
    AuthUserFile /etc/apache2/.htpasswd
    require valid-user
    # Prepend banner to top of every page..
    # php_value auto_prepend_file "/var/www/html/menu/banner1.php"
</Directory>
#
EOF
}


ipage()
{
sudo tee /var/www/html/authbasic/i.htm <<EOF
<html>
<body>
<div style="width: 100%; font-size: 40px; font-weight: bold; text-align: center;">
Test Page for Basic Auth
</div>
</body>
</html>
EOF
}


apacheba1()
{
sudo apt-get -y install apache2-utils

    sudo mkdir -p /var/www/html/authbasic
    # add a user ( create a new file with "-c" => only add "-c" at the first time. Do not add it 2nd time to add users. )
    #sudo htpasswd -c /etc/apache2/.htpasswd $userv
    #userv is set in a2/21env.sh...
    sudo htpasswd -b -c /etc/apache2/.htpasswd $userv $pw1

  sudo a2dissite baseauth1.conf
  sudo a2ensite baseauth1.conf
  sudo service apache2 reload
}


apacheba2()
{
    # add a user ( create a new file with "-c" => only add "-c" at the first time. Do not add it 2nd time to add users. )
    #sudo htpasswd -c /etc/apache2/.htpasswd $userv
    sudo htpasswd -b /etc/apache2/.htpasswd $userv $pw3
    # for humidex app 248
    sudo htpasswd -b /etc/apache2/.htpasswd sun replaceme-234rfsrw234wersdfxsewersf

  sudo a2dissite baseauthmain.conf
  sudo a2ensite baseauthmain.conf
  sudo service apache2 reload
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function info21()
{
exit 999

Basic Auth:
https://help.ubuntu.com/lts/serverguide/httpd.html
http://www.server-world.info/en/note?os=Ubuntu_14.04&p=httpd&f=9

}


#main section.....................................................................

#echo requested commands...
date

basauth1
basauthmain
apacheba1
apacheba2
ipage

date
#
