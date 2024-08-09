#!/usr/bin/env bash

echo starting 17docs.sh


#for mate: *****************************************************
# no make htdocs.  touch /home/dg/tmp01/htdocs.PMDS-DATA.latest.7z
cd
mkdir -p tmp01/htdocs
cd tmp01

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# check out ansible http://www.ansible.com/ it automation - devops  - infrastructure-as-code
# https://en.wikipedia.org/wiki/Idempotence


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Issues.

# problem.. vagrant ftp has old version of file. have to 'vagrant reload' to get new version. 2015-10-22_Thu_12.14-PM

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ask if you want to put htdocs there manually with 16putht.bat from windows..
set +vx
echo
date  +"__%Y-%m-%d_%a_%k.%M.%S-%Z"
echo "Do you want to put htdocs there manually with 15putht.bat from windows?"
#read -t 999 -p "Hit ENTER or wait about 999 seconds" ; echo ;
echo
set -vx


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



set -x
cd
source shc/21env.sh

# make directories.
# html
sudo chmod -R 777 tmp01
sudo mkdir -p /var/www/html
# make read for other group...
#sudo chmod -R o+r /var/www/html 
# make only folders +x so they can be cd into.
#sudo find /var/www/html -type d -exec chmod o+x {} +
#sudo chmod -R ug+x /var/www/html/cilist/actions/*.sh


#
# make tempfiles folder writable. This is used with cilist, tnlist and others to write excel files and mail them..
#
sudo mkdir -p /tmp01/tempfiles
sudo chmod -R 777 /tmp01/tempfiles

sudo mkdir -p /var/www/tempfilesdg
sudo chmod -R 777 /var/www/tempfilesdg



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#get webroot code 

# set method as either ftp or bitbucket...
#dgmethod="bitbucket"
dgmethod="ftp"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

if [ $dgmethod = "ftp" ] ; then

    # I setup vsftp on a vagrant ubuntu machine, vamp198e, that has shares to c: drive to get the files...
    cd /home/$userv/tmp01
    rm -f /home/$userv/vne.sh
    pwd
    ls
    read -t 10 -p "Press ENTER or wait about ten seconds" ; echo ;

    #you may have to edit the ip address..
    #https://technicalsanctuary.wordpress.com/2012/11/01/curl-curl-9-server-denied-you-to-change-to-the-given-directory/
    #example path: ftp://192.168.88.80//var/varvamp/files/vne.sh
    #absolute path is  //var   << double slash for absolute path.
    #else get error : curl: (9) Server denied you to change to the given directory

    if ping -c 1 192.168.88.94 &> /dev/null
    then
      curl -O -u dg:fruit ftp://192.168.88.94:2141//files/vne.sh
    else
      curl -O -u dg:fruit ftp://10.4.10.225:2141//files/vne.sh
    fi
    #curl -O -u dg:fruit ftp://192.168.88.94:2141//var/varvamp/files/vne.sh
    #curl -O --user dgleba  https://bitbucket.org/dgleba/vamp206env/raw/master/vne.sh 
    #curl -O -u vagrant:vagrant ftp://10.4.11.15//var/varvamp/files/vne.sh
    
    if [ -f vne.sh ]; then
        sudo cat /home/$userv/tmp01/vne.sh > /home/$userv/shc/21env.sh
        sudo chmod -R 777 /home/$userv/shc/21env.sh

        # copy env.sh to profile.d so it runs at login for global variables...
        # may not be needed...
        sudo cp /home/$userv/shc/21env.sh /etc/profile.d

    else
            read  -p "Oops, ftp server may not be present. Press Enter." ; echo ; 	
            exit 8
    fi


    if [ ! -f htdocs.PMDS-DATA.latest.7z ] ; then

        if ping -c 1 192.168.88.94 &> /dev/null
        then
          curl -O -u dg:fruit ftp://192.168.88.94:2141//files/htdocs.PMDS-DATA.latest.7z
          curl -O -u dg:fruit ftp://192.168.88.94:2141//files/nomachine_5.0.53_1_amd64.deb
          curl -O -u dg:fruit ftp://192.168.88.94:2141//files/mullvad_55-1_all.deb
          curl -O -u dg:fruit ftp://192.168.88.94:2141//files/lxdehome.tgz
          curl -O -u dg:fruit ftp://192.168.88.94:2141//files/mullvadconfig.zip
        else
          curl -O -u dg:fruit ftp://10.4.10.225:2141//files/htdocs.PMDS-DATA.latest.7z
        fi
        
        #curl -O -u dg:fruit ftp://192.168.88.94:2141//var/varvamp/files/htdocs.PMDS-DATA.latest.7z
        #curl -O -u dg ftp://108.168.7.195:46237//home/dg/www/Dropbox/csd/serve/vboxyard/htdocs/htdocs.PMDS-DATA.latest.zip
        #curl -O -u vagrant:vagrant ftp://10.4.11.15//var/varvamp/files/htdocs.PMDS-DATA.latest.7z
        #curl -O -u vagrant:vagrant ftp://10.4.11.15//var/varvamp/files/htdocs.PMDS-DATA.latest.zip
        #wget -N ftp://vagrant:vagrant@10.4.11.15//var/varvamp/files/htdocs.PMDS-DATA.latest.7z
    
    fi

    if  [ ! -d htdocs ] ; then
        cd /home/$userv/tmp01
        #sudo rm -rf htdocs
        read -t 10 -p "Hit ENTER or wait about ten seconds" ; echo ;
        cd /home/$userv/tmp01
        7z x /home/$userv/tmp01/htdocs.PMDS-DATA.latest.7z

        # this problem is gone now...
        #7-Zip [64] 9.20  Copyright (c) 1999-2010 Igor Pavlov  2010-11-18 p7zip Version 9.20 (locale=en_US.UTF-8,Utf16=on,HugeFiles=on,2 CPUs) Processing archive: /home/albe/tmp01/htdocs.PMDS-DATA.latest.7z
        #Error: Can not open file as archive
        #htdocs.PMDS-DATA.latest.7z
        #

        source ~/shc/21env.sh
        sudo rsync -vrltgoD /home/$userv/tmp01/htdocs/  /var/www/html
    fi

fi


if [ $dgmethod = "bitbucket" ] ; then

# can't unzip the file....
#  https://bitbucket.org/conservancy/kallithea/issues/35


    cd /home/$userv/tmp01
    rm -f vne.sh
    pwd
    ls
    read -t 10 -p "Press ENTER or wait about ten seconds" ; echo ;

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #
    # bitbucket download tips...
    # http://stackoverflow.com/questions/17682143/download-private-bitbucket-repository-zip-file-using-http-authentication
    # https://bitbucket.org/site/master/issues/7393/in-addition-to-raw-allow-to-download-files
    #
    # works..  prompts for password for private repo..   this gives the dl a name...
    #    curl    --user dgleba  https://bitbucket.org/dgleba/vamp206env/raw/master/vne.sh -o vne1.sh
    # works... prompts for password for private repo..  this uses name of source file...
    curl -O --user dgleba  https://bitbucket.org/dgleba/vamp206env/raw/master/vne.sh 
    # scp info... [i didn't use it.]
    #http://stackoverflow.com/questions/50096/how-to-pass-password-to-scp

    if [ -f vne.sh ]; then
        sudo cat vne.sh > /home/$userv/shc/21env.sh
        sudo chmod -R 777 /home/$userv/shc/21env.sh

        # copy env.sh to profile.d so it runs a login for global variables...
        # may not be needed...
        sudo cp /home/$userv/shc/21env.sh /etc/profile.d

    else
            read  -p "Oops, ftp server may not be present. Press Enter." ; echo ; 	
            exit 8
    fi

    if [ ! -f htdocs.PMDS-DATA.latest.zip ]; then
        #curl -O --user dgleba  https://bitbucket.org/dgleba/htdocs/raw/master/htdocs.PMDS-DATA.latest.7z
        curl -O --user dgleba  https://bitbucket.org/dgleba/htdocs/raw/master/htdocs.PMDS-DATA.latest.zip
                                
        cd /home/$userv/tmp01

        sudo rm -rf htdocs
        read -t 10 -p "Hit ENTER or wait about ten seconds" ; echo ;
        7z x htdocs.PMDS-DATA.latest.zip

        source ~/shc/21env.sh
        sudo rsync -vrltgoD /home/$userv/tmp01/htdocs/  /var/www/html
    fi
fi
cd


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



function offline()
{
exit 999

cd 
  curl -O -u dg ftp://108.168.7.195:46237//home/dg/www/Dropbox/csd/serve/vboxyard/htdocs/htdocs.PMDS-DATA.latest.7z

}
