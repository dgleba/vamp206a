#!/bin/bash
# Grabs and kill a process from the pidlist that has the word  metabase.jar

sudo /etc/init.d/metabase1 stop

timeout1=31 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;

sudo /etc/init.d/metabase1 start

sudo date >> /home/albe/log/varlibmysql.dir.txt
sudo ls -lah /var/lib/mysql >> /home/albe/log/varlibmysql.dir.txt

echo
echo Completed running metabase_stopstart.sh.
echo