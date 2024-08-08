

# Install mariadb columnstore on ubuntu 16.04



# don't use sudo..


#   usage:    

#         Just paste items from this file to the console.. shc/apps/mcs/marmariadbcolumnstore-step2.sh



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

echo just paste this from the command line, dont execute as script..
exit 98

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# set root password..

cd
set +vx
cd; source safe/21env.sh
set -vx

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tmpfile9='/tmp/heredoctmpfile99b.sql'
cat << HEREDOC> $tmpfile9
 SET PASSWORD FOR 'root'@'localhost' = PASSWORD("$mysqlrootpassw");
 SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD("$mysqlrootpassw");
 SET PASSWORD FOR 'root'@'::1'       = PASSWORD("$mysqlrootpassw");
 SET PASSWORD FOR 'pma'@'localhost'  = PASSWORD("$mysqlrootpassw");
  FLUSH PRIVILEGES;

HEREDOC

cat $tmpfile9

mcsmysql  < $tmpfile9

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# run this to setup db's and users...

echo '<?php phpinfo(); ?>' > /var/www/html/test2/phpinfo.php
  
cd
cd; source safe/21env.sh
set -vx
shc/apps/mcs/53mcsimp.sh
  

  

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# set permissions..


dir1='/usr/local/mariadb/columnstore'
sudo setfacl -R -m group:www-data:rwx $dir1
sudo getfacl $dir1
sudo usermod -a -G mysql  albe
# this didn't work, so I just did ...
sudo chmod -R 775  $dir1
sudo chmod -R g+rws  $dir1



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# optional..


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#    create columnstores...

cd; source safe/21env.sh
cd /var/www/html/backup/mysql
mcsmysql -uroot -p$mysqlrootpassw  < cmmdata-mcs.sql
mcsmysql -uroot -p$mysqlrootpassw  < cmmlist-mcs.sql

mcsmysql -uroot -p$mysqlrootpassw  < pmdsdata3-cmmdb-regulr_no-maindata-mysql.sql



#ERROR 1178 (42000) at line 30: The storage engine for the table doesn't support IDB-2029: Lock table command is currently not supported in Columnstore.
#mcsmysql -uroot -pa  < pmdsdata3-cmmdb-spectables-mysql.sql

#cpimport dbName tblName [loadFile]

cd /var/www/html/backup/mysql
cpimport cmmdb cmmdata cmmdata.txt -s '\t'
cpimport cmmdb cmmlist cmmlist.txt -s '\t'


cd /var/www/html/backup/mysql
cpimport cmmdb cmmdata cmmdata-1m.txt -s '\t'

cd /var/www/html/backup/mysql
cpimport cmmdb cmmdata cmmdata-5m.txt -s '\t'

cd /var/www/html/backup/mysql
cpimport cmmdb cmmdata cmmdata-16.36m.txt -s '\t'
#  rsync -avv  /var/lib/mysql-files/cmmdb/cmmdata-16.36m.txt   10.4.1.245:/var/www/html/backup/mysql/
tail /var/lib/mysql-files/cmmdb/cmmdata-16.36m.txt


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~








# end of code.








#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

exit 0

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

notes..


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# mcsmysql -uroot
# then...
# SET PASSWORD FOR 'root'@'localhost' = PASSWORD('a');
# SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD('a');
# SET PASSWORD FOR 'root'@'::1'       = PASSWORD('a');
# SET PASSWORD FOR 'pma'@'localhost'  = PASSWORD('a');
#  FLUSH PRIVILEGES;
  
  
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


sudo nano /usr/local/mariadb/columnstore/etc/Columnstore.xml

https://mariadb.com/kb/en/library/configuring-columnstore-cross-engine-joins/


from..

	<CrossEngineSupport>
		<Host>unassigned</Host>
		<Port>3306</Port>
		<User>unassigned</User>
		<Password/>
	</CrossEngineSupport>

to.. 

    <CrossEngineSupport>
        <Host>127.0.0.1</Host>
        <Port>3306</Port>
        <User>root</User>
        <Password>pwd</Password>
    </CrossEngineSupport>


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ldap

http://discourse.metabase.com/t/need-some-ldap-help/1885/3

DC=STACKPOLE,DC=CA
User search base does not exist or is unreadable


(&(|(sAMAccountName={login})(userPrincipalName={login}))(memberOf:1.2.840.113556.1.4.1941:=cn=Metabase,ou=Services,dc=stackpole,dc=ca))

(&(|(sAMAccountName={login})(userPrincipalName={login}))(memberOf:1.2.840.113556.1.4.1941:=ou=Users,dc=stackpole,dc=ca))

(&(|(sAMAccountName={login})(userPrincipalName={login})) )

(&(|(sAMAccountName={login}) ) )

http://discourse.metabase.com/t/cant-login-with-ldap-user/1872/3


refer 

ftp://albe@pmdsdata3/srv/web/lpa346/config/ldap.yml

ftp://albe@pmdsdata3/srv/web/utilities-rails/ldapsearchrb/ldap-dept-list3.rb

/var/www/html/test2/ldapquery/ldap-test-4-search-works.php

ftp://albe@pmdsdata3/var/www/html/shiftcsd1sup/conf.ini



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2017-09-27[Sep-Wed]21-33PM


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

https://mariadb.com/kb/en/library/mariadb-columnstore-software-upgrade-1011-to-110-beta/


export tsv

mysqldump -u <username> -p<password> -T <output_directory> --no-create-info <database_name>
cd
mkdir -p dump
mysqldump -uroot -pa -T ~/dump --no-create-info dgnote130

# just structure only...
mysqldump --user=root --password=$mysqlrootpassw  -d --databases  cilist leanmfg shift_smsmeer shiftcsd1 shiftcsd2 shiftcsd1suprv shiftcsd2suprv dgnote130 hrdb lukup --complete-insert  --quote-names --add-drop-database --allow-keywords | grep -v 'SQL SECURITY DEFINER' > pmdsdata3-some-structure-mysql.sql

sudo ls -la /var/lib/mysql-files/leanmfg/
sudo chmod -R 777  /var/lib/mysql-files

see a2/62grpshare.sh

# 2017-09-20
#allow export to this folder due to..
#   mysqldump: Got error: 1290: The MySQL server is running with the --secure-file-priv option so it cannot execute this statement when executing 'SELECT INTO OUTFILE'
#    mysqldump: Got error: 1: Can't create/write to file '/var/lib/mysql-files/leanmfg/dataface__failed_logins.txt' (Errcode: 13) when executing 'SELECT INTO OUTFILE'
sudo setfacl -R -m group:www-data:rwx /var/lib/mysql-files/
sudo getfacl /var/lib/mysql-files/
sudo usermod -a -G mysql  albe
# this didn't work, so I just did ...
sudo chmod -R 777  /var/lib/mysql-files
sudo chmod -R g+rws  /var/lib/mysql-files




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 
see sftp://albe@10.4.1.245/var/www/html/0docs/cmmimportdata-pd6.sh


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
