#!/usr/bin/env bash

# import mysql data...

cd
source shc/21env.sh

date
#echo requested commands...
set -x


mysql -uroot -p$mysqlrootpassw -e "create database cilist"; 
mysql -uroot -p$mysqlrootpassw -e "create database dgnote130"; 
mysql -uroot -p$mysqlrootpassw -e "create database leanmfg"; 
mysql -uroot -p$mysqlrootpassw -e "create database prodrptdb"; 
mysql -uroot -p$mysqlrootpassw -e "create database shift_smsmeer"; 
mysql -uroot -p$mysqlrootpassw -e "create database shiftcsd1"; 
mysql -uroot -p$mysqlrootpassw -e "create database shiftcsd1suprv"; 
mysql -uroot -p$mysqlrootpassw -e "create database shiftcsd2"; 
mysql -uroot -p$mysqlrootpassw -e "create database shiftcsd2suprv"; 

#not a good idea to import 'mysql' database.
#mysql --user=root --password=xx < /var/www/html/backup/mysql/pmdsdata-all-mysql.sql
#
#import one database at a time from the backup of all the mysql data.
#
mysql -uroot -p$mysqlrootpassw --one-database cilist < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
mysql -uroot -p$mysqlrootpassw --one-database dgnote130 < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
mysql -uroot -p$mysqlrootpassw --one-database leanmfg < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
mysql -uroot -p$mysqlrootpassw --one-database prodrptdb < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
mysql -uroot -p$mysqlrootpassw --one-database shift_smsmeer < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
mysql -uroot -p$mysqlrootpassw --one-database shiftcsd1 < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
mysql -uroot -p$mysqlrootpassw --one-database shiftcsd1suprv < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
mysql -uroot -p$mysqlrootpassw --one-database shiftcsd2 < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql
mysql -uroot -p$mysqlrootpassw --one-database shiftcsd2suprv < /var/www/html/backup/mysql/pmdsdata3-all-mysql.sql


# use here document to provide input...
#  https://ignaciopp.wordpress.com/2011/08/08/heredoc-tip-execute-mysql-commands-from-shell-with-multiline-scripts-or-queries/
#    heredoc not working just do one line at a time.
mysql -uroot -p$mysqlrootpassw  -e "CREATE USER 'dg417'@'localhost' IDENTIFIED BY '$mysqluserpass';"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'dg417'@'localhost' IDENTIFIED BY '$mysqluserpass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON cilist.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON dgnote130.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON leanmfg.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON prodrptdb.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON shift_smsmeer.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON shiftcsd1.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON shiftcsd2.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON shiftcsd1suprv.* TO dg417@localhost ;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON shiftcsd2suprv.* TO dg417@localhost ;"



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

#
