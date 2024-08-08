#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

cd
source safe/21env.sh
set -vx
date

#remove then add # run 0901am everyday
sudo crontab -u pmdsu -l #list the crontab
#remove
sudo crontab -u pmdsu -l | grep -v '/excel2_script.sh'  | sudo crontab -u pmdsu -
#add
sudo crontab -u pmdsu -l | { cat; echo "37 15 1 10 * /var/www/html/cilist/actions/excel2_script.sh"; } | sudo crontab -u pmdsu -
# every min.
#sudo crontab -u pmdsu -l | { cat; echo "* * * * * /var/www/html/cilist/actions/excel2_script.sh"; } | sudo crontab -u pmdsu -
sudo crontab -u pmdsu -l


# Cron jobs, including import all data daily...

#  list, remove, list, add, list...
sudo crontab -u albe -l

# remove
sudo crontab -u albe -l | grep -v 'albe/shc/'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v 'albe/bin/'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v 'html/cilist/actions/'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v 'html/lukup/actions/'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v 'html/prodrpt/actions/'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v 'shiftcsd2sup/'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v '/0docs-pmdsdata/'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v '/0docs-pmdsdata/archivedata1.sh'  | sudo crontab -u albe - #remove
#sudo crontab -u albe -l | grep -v 'cilist/actions/email_originators_script.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v 'sendemail_recentdowntime.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v 'sendemail_recentdowntime2.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v 'sendemail_recentdowntime3.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v 'sendemail_recentdowntime_cron.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v 'import-csv-mysql-cmm.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v '/email_scrap1_script.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | grep -v '/usr/bin/env'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l  # list

# add...

#  sftp://albe@10.4.1.224/home/albe/bin/metabase_stopstart.sh start a new log daily..
sudo crontab -u albe -l | grep -v '/home/albe/bin/metabase_stopstart.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | { cat; echo "5 0 * * 0-6 source $HOME/.profile; /home/albe/bin/metabase_stopstart.sh 2>&1 | tee -a /home/albe/log/metabasestart.log"; } | sudo crontab -u albe -  #add
sudo crontab -u albe -l  # list



#import sc_production..
sudo crontab -u albe -l  |grep sc_pro # list 
sudo crontab -u albe -l | grep -v 'prodrpt/actions/import-sc_production.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | { cat; echo "10,25,40,55 * * * 0-6 source $HOME/.profile; /var/www/html/prodrpt/actions/import-sc_production.sh 2>&1 | tee -a /home/albe/log/sc_production_import.log"; } | sudo crontab -u albe -  #add
sudo crontab -u albe -l  |grep sc_pro # list 


sudo crontab -u albe -l | { cat; echo "55 6,18 * * 1-7  /var/www/html/prodrpt/actions/sendemail_recentdowntime_cron.sh >> /home/albe/log/sendrecentdowntime_cron.log 2<&1"; } | sudo crontab -u albe -  #add

sudo crontab -u albe -l | { cat; echo "01 7 * * 1-5  /var/www/html/cilist/actions/exceptionrpts.sh >> /home/albe/log/exceptionrpts1.log 2<&1"; } | sudo crontab -u albe -  #add

sudo crontab -u albe -l | { cat; echo "45 6 * * 1-7  /var/www/html/cmmdb/actions/email_rows_imported.sh >> /home/albe/log/cmmdb.reports.log 2<&1"; } | sudo crontab -u albe -  #add

sudo crontab -u albe -l  # list
sudo crontab -u albe -l | grep -v 'import-csv-mysql-cmm.sh'  | sudo crontab -u albe - #remove
#20
sudo crontab -u albe -l | { cat; echo "21 1,15 * * 0-6  /var/www/html/cmmdb/actions/import-csv-mysql-cmm.sh 2>&1 | tee -a /home/albe/log/import-csv-mysql-cmm1.log"; } | sudo crontab -u albe -  #add
#    temporary for test.......
#sudo crontab -u albe -l | { cat; echo "13 11 * * 0-6     /var/www/html/cmmdb/actions/import-csv-mysql-cmm.sh >> /home/albe/log/import-csv-mysql-cmm1t.log 2<&1"; } | sudo crontab -u albe -  #add
sudo crontab -u albe -l  # list

sudo crontab -u albe -l | grep -v '/0docs-pmdsdata/scrapimport.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | { cat; echo "40 7 * * 0-6 /var/www/html/0docs-pmdsdata/scrapimport.sh 2>&1 | tee -a /home/albe/log/scrapimport1.log"; } | sudo crontab -u albe -  #add

sudo crontab -u albe -l | grep -v '/0docs-pmdsdata/archivedata1.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | { cat; echo "35 2 * * 0-6 /var/www/html/0docs-pmdsdata/archivedata1.sh >> /home/albe/log/archive1.log 2<&1"; } | sudo crontab -u albe -  #add

sudo crontab -u albe -l | grep -v 'greygold/actions/email_scrap1_script'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | { cat; echo "50 8 * * 0-6 /var/www/html/greygold/actions/email_scrap1_script.sh >> /home/albe/log/scrap1email.log 2<&1"; } | sudo crontab -u albe -  #add


sudo crontab -u albe -l | grep -v 'html/cilist/actions/task_email'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | { cat; echo "1 9 * * 3   /var/www/html/cilist/actions/task_email1.sh >> /home/albe/log/taskemail1.log 2<&1"; } | sudo crontab -u albe -  #add


sudo crontab -u albe -l | { cat; echo "31 11 * * 4   /var/www/html/shiftcsd2sup/actions/email_tnopen_script.sh >> /home/albe/log/emailtnopen1.log 2<&1"; } | sudo crontab -u albe -  #add

sudo crontab -u albe -l | { cat; echo "22 15 * * 0-6 /var/www/html/0docs-pmdsdata/backup2.sh >> /home/albe/log/backup2.log 2<&1"; } | sudo crontab -u albe -  #add

# lukup... eam assets...
sudo crontab -u albe -l | grep -v 'lukup/actions/imp-lukup.sh'  | sudo crontab -u albe - #remove
sudo crontab -u albe -l | { cat; echo "43 15 * * 1-5 /var/www/html/lukup/actions/imp-lukup.sh >> /home/albe/log/lukupimp.log 2<&1"; } | sudo crontab -u albe -  #add

sudo crontab -u albe -l | { cat; echo "49 15 * * 1-5 /var/www/html/cilist/actions/import-csv-mysql-ceridian-enterprise.sh >> /home/albe/log/importcerenterp1.log 2<&1"; } | sudo crontab -u albe -  #add

sudo crontab -u albe -l  # list



# pmdsdata4:
sudo crontab -u albe -l | { cat; echo "10 07,12 * * 1-5  /var/www/html/0docs-pmdsdata/4html-bk4.sh >> /home/albe/log/bkdata4.log 2<&1"; } | sudo crontab -u albe -  #add


#testing...
sudo crontab -u albe -l  # list


#list cron logs 
grep CRON /var/log/syslog | grep albe


# ===================================================

# be careful to get the env you need, or call everything exactly and don't rely on env. it is different for cron.

#remove from pmdsu... better to run as albe, the env variables are already present... or not....
#  list, remove, list, add, list...
sudo crontab -u pmdsu -l
sudo crontab -u pmdsu -l | grep -v 'albe/shc/53imp.sh'  | sudo crontab -u pmdsu - #remove
sudo crontab -u pmdsu -l  #list


# http://stackoverflow.com/questions/15962573/usr-bin-env-ruby-is-not-found-in-cron
#
# troubleshoot env..
# * * * * * /usr/bin/env > /path/to/your/home/directory/env.txt
# 0 6 * * * /usr/bin/env >  /home/albe/log/env.txt.log
#  sudo crontab -u albe -l | { cat; echo "  0 6 * * * /usr/bin/env >  /home/albe/log/env.txt.log"; } | sudo crontab -u albe -  #add
#  sudo crontab -u albe -l | grep -v '/home/albe/log/env.txt.log'  | sudo crontab -u albe - #remove
#  sudo crontab -u albe -l | { cat; echo "  0 6 * * * . $HOME/.profile ; /usr/bin/env >  /home/albe/log/envmy.txt.log"; } | sudo crontab -u albe -  #add

# put this in line 1 of crontab -e for albe user..
#       SHELL=/bin/bash
#
if  sudo crontab -u albe -l |  grep -q 'SHELL=/bin/bash' ; then
  echo "Shell call is FOUND"
  # test sudo crontab -u albe -l | sed '1 i\SHELL=/bin/bash-dg' | sudo crontab -u albe -
  #  sudo crontab -u albe -l | grep -v 'bash-dg'  | sudo crontab -u albe - #remove
else 
  echo "NOT FOUND"
  # hmm, can't do this.. sed -i '1 i\anything' file
  # edit cron with sed ..  http://askubuntu.com/questions/58575/add-lines-to-cron-from-script
  sudo crontab -u albe -l | sed '1 i\SHELL=/bin/bash\nBASH_ENV="/home/albe/.bashrc"' | sudo crontab -u albe -
fi
sudo crontab -u albe -l  # list


# ===================================================




#Make scripts executable.
sudo chmod -R ug+x /var/www/html/cilist/actions/*.sh
sudo chmod -R ug+x /var/www/html/shiftcsd2sup/actions/*.sh

#example.. turn off excecute in this folder...
find /var/www/html/dokuwiki/ -type f -name '*.sh' -exec chmod ug-x {} \;

#find permissions of files using tree and grep on *.sh files - all scripts - *.sh
sudo apt-get -y install tree
cd /var/www/html
tree -ifpugDs $PWD |grep "\.sh"





#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# incorrect from name fromname wrong..
# solution..
# email had old name vamp206b.vamp206b
#sudo dpkg-reconfigure ssmtp
#or edit /etc/ssmtp/ssmtp.conf
#change fully qualified hostname and allow user to enter any from name.


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function info()
{
exit 999
exit 9
_____________



******  Print out cron listing  sorted by hour and minute...


...\bash-take-nth-column-in-a-text-file,know.txt

sudo crontab -u albe -l | grep -v SHELL > /tmp/cronl
awk '{printf "%s ~ %s ~ %s\n", $2,$1,$0}' < /tmp/cronl | sort
#

sample output...

albe@pmdsdata3:/srv/web/shiftcsd1p272$ sudo crontab -u albe -l | grep -v SHELL > /tmp/cronl
albe@pmdsdata3:/srv/web/shiftcsd1p272$ awk '{printf "%s ~ %s ~ %s\n", $2,$1,$0}' < /tmp/cronl | sort
11 ~ 31 ~ 31 11 * * 4   /var/www/html/shiftcsd2sup/actions/email_tnopen_script.sh >> /home/albe/log/emailtnopen1.log 2<&1
15 ~ 22 ~ 22 15 * * 0-6 /var/www/html/0docs-pmdsdata/backup2.sh >> /home/albe/log/backup2.log 2<&1
15 ~ 43 ~ 43 15 * * 1-5 /var/www/html/lukup/actions/imp-lukup.sh >> /home/albe/log/lukupimp.log 2<&1
15 ~ 49 ~ 49 15 * * 1-5 /var/www/html/cilist/actions/import-csv-mysql-cridian-eerprise.sh >> /home/albe/log/importceren....1.log 2<&1
6,18 ~ 55 ~ 55 6,18 * * 1-7  /var/www/html/prodrpt/actions/sendemail_recentdowntime_cron.sh >> /home/albe/log/sendrecentdowntime_cron.log 2<&1




_____________



remove all:
crontab -r 

cron know..
http://unix.stackexchange.com/questions/119481/how-come-crontab-e-is-different-from-less-etc-crontab
http://stackoverflow.com/questions/878600/how-to-create-cronjob-using-bash

/var/spool/cron/crontabs/albe

#sudo crontab -u pmdsu -l | { cat; echo "*/2 * * * * cript.sh"; } | sudo crontab -u pmdsu -


offline:

#test 2016-07-13_Wed_15.42-PM
sudo crontab -u albe -l | { cat; echo "49 15 * * 1-7 /var/www/html/0docs-pmdsdata/backup2.sh >> /home/albe/log/backup2.log 2<&1"; } | sudo crontab -u albe -  #add


#sudo crontab -u albe -l | { cat; echo "21 8 * * 1-6 /home/albe/shc/53imp.sh >> /home/albe/log/cronlog.log 2<&1"; } | sudo crontab -u albe -  #add
#sudo crontab -u albe -l | { cat; echo "21 15 * * 1-6 /home/albe/shc/53imp.sh >> /home/albe/log/cronlog.log 2<&1"; } | sudo crontab -u albe -  #add
#sudo crontab -u albe -l | { cat; echo "20 07,15,23 * * 1-7 /home/albe/bin/mysqlbk1.sh >> /home/albe/log/mysqlbk1.log 2<&1"; } | sudo crontab -u albe -  #add
#sudo crontab -u albe -l | { cat; echo "25 07,15,23 * * 1-7 /home/albe/bin/htmlbk1.sh >> /home/albe/log/htmlbk1.log 2<&1"; } | sudo crontab -u albe -  #add

#sudo crontab -u albe -l | { cat; echo "51 21 * * 1-7 /var/www/html/0docs-pmdsdata/backup2.sh >> /home/albe/log/backup2.log 2<&1"; } | sudo crontab -u albe -  #add

dont try to put a date in the filename..
#just use logrotate... this is dumb...sudo crontab -u albe -l | { cat; echo '58 13 * * 1-5 /var/www/html/cilist/actions/import-csv-mysql-c-e.sh >> /home/albe/log/importcerent....1_"/bin/date +\%Y\%m\%d\%H\%M\%S.log" 2<&1'; } | sudo crontab -u albe -  #add

# test...
sudo crontab -u albe -l | { cat; echo "16 15 * * 2 /var/www/html/cilist/actions/email_owners_script.sh >> /home/albe/log/testowners_taskemail1.log 2<&1"; } | sudo crontab -u albe -  #add
sudo crontab -u albe -l | { cat; echo "22 15 * * 2 /var/www/html/cilist/actions/email_originators_script.sh >> /home/albe/log/testorigina_taskemail1.log 2<&1"; } | sudo crontab -u albe -  #add

# begin block comment =============================
: <<'END'

x

END
# end block comment ===============================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#blank one...

# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# min hr  dom mon dow   command


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


kill a cron job

ps -ef

output like:

albe     11412 11219  0 08:15 ?        00:00:00 sshd: albe@pts/0
albe     11413 11412  0 08:15 pts/0    00:00:00 -bash
albe     11655 11413  0 08:15 pts/0    00:00:00 bash /var/www/html/0docs-pmdsdata/scrapimport.sh
albe     11656 11413  0 08:15 pts/0    00:00:00 tee -a /home/albe/log/scrapimport1.log
albe     11848 11655 19 08:17 pts/0    00:00:15 mysql -uroot -px xxxxx




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


}
#
date