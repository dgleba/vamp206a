#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

cd
source safe/21env.sh
set -vx
date

# Cron jobs, including import all data daily...

#  list, remove, list, add, list...
sudo crontab -u albe -l

sudo crontab -u albe -l  # list




# add...



sudo crontab -u albe -l  # list
sudo crontab -u albe -l | grep -v '0docs/gfxprod-insert-pd3-to-pd6.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | { cat; echo "* * * * 0-6  bash /var/www/html/0docs/gfxprod-insert-pd3-to-pd6.sh 2>&1 | tee -a /home/albe/log/gfxprod-insert-pd3-to-pd6_sh.log"; } | sudo crontab -u albe -  #add
sudo crontab -u albe -l  # list


sudo crontab -u albe -l  # list
sudo crontab -u albe -l | grep -v 'ocs/importcmmdata.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v '0docs/cmmimportdata-pd6.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | { cat; echo "1 6,8,10,16 * * 0-6  /var/www/html/0docs/cmmimportdata-pd6.sh 2>&1 | tee -a /home/albe/log/importnewercmmdata-pd6.log"; } | sudo crontab -u albe -  #add
sudo crontab -u albe -l  # list


sudo crontab -u albe -l | grep -v '0docs/importscrapgreygold-pd6.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | { cat; echo "10 8,10 * * 0-6  /var/www/html/0docs/importscrapgreygold-pd6.sh 2>&1 | tee -a /home/albe/log/importscrapgreygold-pd6.sh.log"; } | sudo crontab -u albe -  #add
sudo crontab -u albe -l  # list


sudo crontab -u albe -l | grep -v 'script/import3_argocsv-pd6.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | { cat; echo "14 12,19,21,2 * * 0-6  /srv/file/argostat/script/import3_argocsv-pd6.sh 2>&1 | tee -a /srv/file/log/import_3_argocsv-pd6.sh_all.log"; } | sudo crontab -u albe -  #add
sudo crontab -u albe -l  # list




# ===================================================

# be careful to get the env you need, or call everything exactly and don't rely on env. it is different for cron.

# ===================================================

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function info()
{
exit 999
exit 9
_____________

see sftp://albe@10.4.1.245/var/www/html/0docs/cmmimportdata-pd6.sh


remove all:
crontab -r 

example.
#import sc_production..
sudo crontab -u albe -l | grep -v 'prodrpt/actions/import-sc_production.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | { cat; echo "59 7-19 * * 0-6 /var/www/html/prodrpt/actions/import-sc_production.sh 2>&1 | tee -a /home/albe/log/sc_production_import.log"; } | sudo crontab -u albe -  #add


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

}

#
date
#
return
