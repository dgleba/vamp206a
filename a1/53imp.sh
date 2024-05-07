#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:
        import mysql data...

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd
source shc/21env.sh
date
#echo requested commands...
set -vx

#test:
# \\10.4.1.227\home\ubuntuUser\0\dump-adhoc.sql
#   mysql -uroot -p$mysqlrootpassw   <  ~/0/dump-adhoc.sql
# mysql -uroot -p$mysqlrootpassw   < /home/file/tmp/out2.sql


function scrap_pre1() {

# test importing the scrap data 2016-10-29 ...
#
# Comment out drop table..
sed -i -e 's/DROP TABLE/-- #DROP TABLE/' /home/file/import1/scrapdumpDetail.sql
#grep -ri  -b2 'drop table' /home/file/import1/scrapdumpDetail.sql
# next line will turn on drop table if it was commented out...
# sed -i -e 's/DROP TABLE/\nDROP TABLE/' /home/file/import1/scrapdumpDetail.sql
#grep -ri 'drop table' /home/file/import1/scrapdumpDetail.sql
#
# make it create table if not exists..
sed -i -e 's/CREATE TABLE/CREATE TABLE if not exists/' /home/file/import1/scrapdumpDetail.sql
#grep -ri 'create table' /home/file/import1/scrapdumpDetail.sql
# make it insert ignore..
sed -i -e 's/INSERT INTO/INSERT ignore INTO/' /home/file/import1/scrapdumpDetail.sql
# comment out autocommit=1...
sed -i -e 's/SET autocommit=1/-- #SET autoco.../' /home/file/import1/scrapdumpDetail.sql
#
# insert at beginning..  sed -i '1s/^/<added text> /' file
sed -i -e '1s/^/SET autocommit=0;\nSET unique_checks=1;\nSET foreign_key_checks=0;\n/' /home/file/import1/scrapdumpDetail.sql
sed -i -e '$aCOMMIT;\nSET autocommit=1;\nSET unique_checks=1;\nSET foreign_key_checks=1;\n' /home/file/import1/scrapdumpDetail.sql
#
#fix my error
#sed -i -e 's/INSERT ingore INTO/INSERT ignore INTO/' /home/file/import1/scrapdumpDetail.sql
#sed -i -e 's/INSERT INTO/INSERT ingore INTO/' ./scrapdumpDetail.sql
#

# speed things up by setting some things off for the import..
#   ref: http://dba.stackexchange.com/questions/98814/mysql-dump-import-incredibly-slow-on-my-developers-machine
sed -i -e '1s/^/SET autocommit=0;\nSET unique_checks=0;\nSET foreign_key_checks=0;\n/' /home/file/import1/scrapdumpMaster.sql
sed -i -e '$aCOMMIT;\nSET autocommit=1;\nSET unique_checks=1;\nSET foreign_key_checks=1;\n' /home/file/import1/scrapdumpMaster.sql

}

 mysql -uroot -p$mysqlrootpassw   < /home/file/import1/scrapdumpDetail.sql
 mysql -uroot -p$mysqlrootpassw   < /home/file/import1/scrapdumpMaster.sql



date


# Main..

mysql -uroot -p$mysqlrootpassw -e "create database cilist";
mysql -uroot -p$mysqlrootpassw -e "create database dgnote130";
mysql -uroot -p$mysqlrootpassw -e "create database leanmfg";
mysql -uroot -p$mysqlrootpassw -e "create database prodrptdb";
mysql -uroot -p$mysqlrootpassw -e "create database shift_smsmeer";
mysql -uroot -p$mysqlrootpassw -e "create database shiftcsd1";
mysql -uroot -p$mysqlrootpassw -e "create database shiftcsd1suprv";
mysql -uroot -p$mysqlrootpassw -e "create database shiftcsd2";
mysql -uroot -p$mysqlrootpassw -e "create database shiftcsd2suprv";
mysql -uroot -p$mysqlrootpassw -e "create database prodrptdb_archive";
mysql -uroot -p$mysqlrootpassw -e "create database lukup";
mysql -uroot -p$mysqlrootpassw -e "create database hrdb";
mysql -uroot -p$mysqlrootpassw -e "create database greygold";

#not a good idea to import 'mysql' database.
#mysql --user=root --password=xx < /var/www/html/backup/mysql/pmdsdata-all-mysql.sql
#
#import one database at a time from the backup of all the mysql data.
# i think this randomly causes a second empty database created. This has wiped out the mysql database and other system databases.
#  don't do this anymore...

#mysql -uroot -p$mysqlrootpassw --one-database greygold < /home/ubuntuUser/share203/pmdsdata-all-mysql-706.sql
#mysql -uroot -p$mysqlrootpassw   <  /var/www/html/backup/mysql/pmdsdata3t-greygold2-mysql.sql
#
#mysql -uroot -p$mysqlrootpassw --one-database cilist < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
#mysql -uroot -p$mysqlrootpassw --one-database dgnote130 < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
#mysql -uroot -p$mysqlrootpassw --one-database leanmfg < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
#mysql -uroot -p$mysqlrootpassw --one-database prodrptdb < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
#mysql -uroot -p$mysqlrootpassw --one-database shift_smsmeer < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
#mysql -uroot -p$mysqlrootpassw --one-database shiftcsd1 < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
#mysql -uroot -p$mysqlrootpassw --one-database shiftcsd1suprv < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
#mysql -uroot -p$mysqlrootpassw --one-database shiftcsd2 < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
#mysql -uroot -p$mysqlrootpassw --one-database shiftcsd2suprv < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql



#preferred..
#commented to prevent accidentally wiping out production data.
if [ $HOSTNAME = "pmdsdata3" ] ; then
    sleep 1
    date1=$(date +"__%Y.%m.%d_%H.%M.%S")
    echo $date1
    timeout1=15 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
    echo 'pmdsdata3 - will NOT import.'
else
    echo 'this is not pmdsdata3 we WILL import data'

    #   ****** to import or not to import, that is the question...

    mysql -uroot -p$mysqlrootpassw  < /var/www/html/backup/mysql/pmdsdata3-some-mysql.sql
    mysql -uroot -p$mysqlrootpassw  < /var/www/html/backup/mysql/pmdsdata3-prodrptdb-mysql.sql

fi

#mysql -uroot -p$mysqlrootpassw  < /var/www/html/backup/mysql/pmdsdata3-some-mysql.sql
#mysql -uroot -p$mysqlrootpassw  < /var/www/html/backup/mysql/pmdsdata3-prodrptdb-mysql.sql


# use here document to provide input...
#  https://ignaciopp.wordpress.com/2011/08/08/heredoc-tip-execute-mysql-commands-from-shell-with-multiline-scripts-or-queries/
#    heredoc not working just do one line at a time.
mysql -uroot -p$mysqlrootpassw  -e "CREATE USER 'dg417'@'localhost' IDENTIFIED BY '$mysqluserpass';"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'dg417'@'localhost' IDENTIFIED BY '$mysqluserpass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
#mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON cilist.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "revoke ALL PRIVILEGES ON cilist.* from dg417@localhost ;"

mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON dgnote130.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON leanmfg.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON prodrptdb.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON shift_smsmeer.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON shiftcsd1.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON shiftcsd2.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON shiftcsd1suprv.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON shiftcsd2suprv.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON prodrptdb_archive.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON greygold.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON qualitydb.* TO dg417@localhost ;"

mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON prodrptdb.tkb_prodtrak TO 'dg417'@'%' IDENTIFIED BY '$mysqluserpass' ;"
# I ran this on the commandlne...
#              mysql -uroot -p  -e "GRANT ALL PRIVILEGES ON prodrptdb.tkb_prodtrak TO 'dg417'@'%' IDENTIFIED BY '34asfviektighdiekjs' ;"


mysql -uroot -p$mysqlrootpassw  -e "CREATE USER 'ciuser'@'localhost' IDENTIFIED BY '$mysql_ciuser_pass';"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'ciuser'@'localhost' IDENTIFIED BY '$mysql_ciuser_pass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'ciuser'@'%' IDENTIFIED BY '$mysql_ciuser_pass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON cilist.* TO 'ciuser'@'localhost' IDENTIFIED BY '$mysql_ciuser_pass' ;"
# ran at the command line...
#  mysql -uroot -p  -e "GRANT ALL PRIVILEGES ON cilist.* TO 'cilistu1'@'%' IDENTIFIED BY 'replaceme-er33k456k43ikdi3' ;"

mysql -uroot -p$mysqlrootpassw  -e "CREATE USER 'lukup'@'localhost' IDENTIFIED BY '$mysql_lukup_pass';"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON lukup.* TO lukup@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'lukup'@'localhost' IDENTIFIED BY '$mysql_lukup_pass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'lukup'@'%' IDENTIFIED BY '$mysql_lukup_pass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"

mysql -uroot -p$mysqlrootpassw  -e "CREATE USER 'hruser'@'localhost' IDENTIFIED BY '$mysql_hruser_pass';"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'hruser'@'localhost' IDENTIFIED BY '$mysql_hruser_pass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'hruser'@'%' IDENTIFIED BY '$mysql_hruser_pass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON hrdb.* TO hruser@localhost IDENTIFIED BY '$mysql_hruser_pass';"

# i had to change definer on views looking at lukup database. Got error: View 'cilist.vw_enterprise_all' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them
# see C:\n\Dropbox\csd\serve\vboxyard\vamp206a\mysql-user-change\viewdefiner-2016-10-11-mysqlknow-changeuser.txt

#mysql -uroot -p$mysqlrootpassw  -e "GRANT SELECT, show view ON lukup.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "revoke ALL PRIVILEGES ON lukup.* from dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "revoke ALL PRIVILEGES ON lukup.* from dg417@'%' ;"

mysql -uroot -p$mysqlrootpassw  -e "GRANT SELECT, show view ON lukup.* TO ciuser@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT SELECT ON lukup.* TO hruser@localhost ;"


mysql -uroot -p$mysqlrootpassw  -e "CREATE USER 'stuser'@'localhost' IDENTIFIED BY '$mysqluserpass';"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'stuser'@'localhost' IDENTIFIED BY '$mysql_stuser_pass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'stuser'@'%' IDENTIFIED BY '$mysql_stuser_pass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT SELECT ON lukup.* TO stuser@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON greygold.* TO stuser@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON greygold.* TO 'stuser'@'%' ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT select ON prodrptdb.* TO stuser@localhost ;"
#
mysql -uroot -p$mysqlrootpassw  -e "CREATE USER 'stread'@'localhost' IDENTIFIED BY '$mysql_stread_pass';"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'stread'@'localhost' IDENTIFIED BY '$mysql_stread_pass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'stread'@'%' IDENTIFIED BY '$mysql_stread_pass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"

mysql -uroot -p$mysqlrootpassw  -e "GRANT select ON greygold.* TO stread@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT select ON greygold.* TO 'stread'@'%' ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT select ON prodrptdb.* TO stread@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT select ON cmmdb.* TO stread@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT select ON cmmdb.* TO stread@'%' ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT select ON qualitydb.* TO stread@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT select ON qualitydb.* TO stread@'%' ;"
mysql -uroot -p$mysqlrootpassw  -e "revoke ALL PRIVILEGES ON lukup.* from stread@localhost ;"

mysql -uroot -p$mysqlrootpassw  -e "CREATE USER 'sthistorian'@'localhost' IDENTIFIED BY '$mysql_sthistorian_pass';"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'sthistorian'@'localhost' IDENTIFIED BY '$mysql_sthistorian_pass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'sthistorian'@'%' IDENTIFIED BY '$mysql_sthistorian_pass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON ignition.* TO sthistorian@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON ignition.* TO 'sthistorian'@'%' ;"
#

mysql -uroot -p$mysqlrootpassw -e "create database cmmdb";
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON cmmdb.* TO sthistorian@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON cmmdb.* TO 'sthistorian'@'%' ;"
#


#perms...

sudo sudo mkdir -p /var/www/html


#templates_c

sudo mkdir /var/www/html/cilist/templates_c
sudo mkdir /var/www/html/dgnote130/templates_c
sudo mkdir /var/www/html/leanmfg/templates_c
sudo mkdir /var/www/html/prodrpt/templates_c
sudo mkdir /var/www/html/shiftcsd1/templates_c
sudo mkdir /var/www/html/shiftcsd1sup/templates_c
sudo mkdir /var/www/html/shiftcsd2/templates_c
sudo mkdir /var/www/html/shiftcsd2sup/templates_c
sudo mkdir /var/www/html/shiftsmsmeer/templates_c


sudo chmod -R 777  /var/www/html/cilist/templates_c
sudo chmod -R 777  /var/www/html/dgnote130/templates_c
sudo chmod -R 777  /var/www/html/leanmfg/templates_c
sudo chmod -R 777  /var/www/html/prodrpt/templates_c
sudo chmod -R 777  /var/www/html/shiftcsd1/templates_c
sudo chmod -R 777  /var/www/html/shiftcsd1sup/templates_c
sudo chmod -R 777  /var/www/html/shiftcsd2/templates_c
sudo chmod -R 777  /var/www/html/shiftcsd2sup/templates_c
sudo chmod -R 777  /var/www/html/shiftsmsmeer/templates_c

#userconfig:

sudo mkdir /var/www/html/cilist/user_config
sudo mkdir /var/www/html/dgnote130/user_config
sudo mkdir /var/www/html/leanmfg/user_config
sudo mkdir /var/www/html/prodrpt/user_config
sudo mkdir /var/www/html/shiftcsd1/user_config
sudo mkdir /var/www/html/shiftcsd1sup/user_config
sudo mkdir /var/www/html/shiftcsd2/user_config
sudo mkdir /var/www/html/shiftcsd2sup/user_config
sudo mkdir /var/www/html/shiftsmsmeer/user_config

sudo chmod -R 777  /var/www/html/cilist/user_config
sudo chmod -R 777  /var/www/html/dgnote130/user_config
sudo chmod -R 777  /var/www/html/leanmfg/user_config
sudo chmod -R 777  /var/www/html/prodrpt/user_config
sudo chmod -R 777  /var/www/html/shiftcsd1/user_config
sudo chmod -R 777  /var/www/html/shiftcsd1sup/user_config
sudo chmod -R 777  /var/www/html/shiftcsd2/user_config
sudo chmod -R 777  /var/www/html/shiftcsd2sup/user_config
sudo chmod -R 777  /var/www/html/shiftsmsmeer/user_config



date

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function notes() {
# begin block comment =============================
: <<'END'

Mysql users

read1       read data
dg417       write typical data
lukup       write lookup info like names, parts, etc
ciuser    write ci data
hruser     write safety incident data

dg417,cilistu1,etc       select on lukup

note:
write means read and write.

_____________ 
2017-03-13 
ubu 16.04

+ mysql -uroot -px -e 'create database cilist'
mysql: [Warning] Using a password on the command line interface can be insecure.
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)

mysql was not installed. it specified ver 5.6 and that is not available in 16.04

_____________ 



_____________ 



END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

