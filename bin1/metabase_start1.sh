#!/bin/bash

cd
source shc/21env.sh
date

cd /srv/web/metabase

export MB_JETTY_PORT=2012

export MB_DB_TYPE=mysql
export MB_DB_DBNAME=metabasedb
export MB_DB_PORT=3306
export MB_DB_USER=sysuser
export MB_DB_PASS=$mysql_lukup_pass
#export MB_DB_HOST=127.0.0.1
export MB_DB_HOST=10.4.1.224

mkdir -p /home/albe/log2

set -vx
sleep 30


# disabled. 2020-07-15_Wed_12.47-PM. dgleba.     exec java -jar metabase.jar  >> /home/albe/log2/metabasebi.log 2<&1 &


date


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# https://github.com/metabase/metabase/issues/3063

# https://askubuntu.com/questions/99232/how-to-make-a-jar-file-run-on-startup-and-when-you-log-out

# Create the start and the stop script of your application. Put it on some directory, in our example is:

# Start Script: /usr/local/bin/myapp-start.sh
# Stop Script: /usr/local/bin/myapp-stop.sh
# Each one will provide the instructions to run/stop the app. For instance the myapp-start.sh content can be as simple as the following:

# #!/bin/bash

# java -jar myapp.jar 
# For the stop script it can be something like this:
# #!/bin/bash
# # Grabs and kill a process from the pidlist that has the word myapp

# pid=`ps aux | grep myapp | awk '{print $2}'`
# kill -9 $pid
# Create the following script (myscript) and put it on /etc/init.d.

# /etc/init.d/myscript content:
# #!/bin/bash
# # MyApp
# #
# # description: bla bla

# case $1 in
    # start)
        # /bin/bash /usr/local/bin/myapp-start.sh
    # ;;
    # stop)
        # /bin/bash /usr/local/bin/myapp-stop.sh
    # ;;
    # restart)
        # /bin/bash /usr/local/bin/myapp-stop.sh
        # /bin/bash /usr/local/bin/myapp-start.sh
    # ;;
# esac
# exit 0
# Put the script to start with the system (using SysV). Just run the following command (as root):
# update-rc.d myscript defaults 
# PS: I know that Upstart is great and bla bla, but I preffer the old SysV init system.

