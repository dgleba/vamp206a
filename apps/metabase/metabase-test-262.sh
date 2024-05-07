
cd
source shc/21env.sh
date


mysql -uroot -p$mysqlrootpassw  -e "CREATE USER 'sysuser'@'localhost' IDENTIFIED BY '$mysql_lukup_pass';"
mysql -uroot -p$mysqlrootpassw  -e "GRANT USAGE ON *.* TO 'sysuser'@'localhost' IDENTIFIED BY '$mysql_lukup_pass' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -uroot -p$mysqlrootpassw  -e "GRANT ALL PRIVILEGES ON metabasedb.* TO sysuser@localhost ;"


# migrate...

# example.. java -jar metabase.jar load-from-h2 <path-to-metabase-h2-database-file>

export MB_DB_TYPE=mysql
export MB_DB_DBNAME=metabasedb
export MB_DB_PORT=3306
export MB_DB_USER=sysuser
export MB_DB_PASS=$mysql_lukup_pass
export MB_DB_HOST=localhost

export MB_JETTY_PORT=3262

cd
source shc/21env.sh
date

meta=metabase262

cd /srv/web/$meta

wget http://downloads.metabase.com/v0.26.2/metabase.jar
mv metabase.jar $meta.jar


cd /srv/web/$meta
# leave the .mv.db off....
# java -jar metabase262.jar load-from-h2 /srv/web/metabase/metabase.db
java -jar metabase262.jar 



# ftp://albe@pmdsdata3/srv/web/metabase/metabase.db.mv.db

