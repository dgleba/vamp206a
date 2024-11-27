#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array



#################################################################
#@  
#@  A general purpose log folder with logrotate
#@  
####################################   2024-11-03[Nov-Sun]17-20PM 



cd
# source shc/21env.sh

# http://www.thegeekstuff.com/2010/07/logrotate-examples

sudo mkdir -p /ap/log
sudo chown -R $USER:$USER /ap/log
sudo chmod -R 777 /ap/log

sudo tee /etc/logrotate.d/ap_log <<EOF
/ap/log/*.log {
    daily
    size 2K
    rotate 60
    missingok
    notifempty
    copytruncate
}
EOF




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function my_notes() {
# begin block comment =============================
: <<'END'

#  notes:

logrotate is usually in cron, but if you want to 
to run it manually..
 sudo /usr/sbin/logrotate /etc/logrotate.conf


/var/log/aptitude {
  rotate 12
  monthly
  compress
    delaycompress
  missingok
  notifempty
}  

	create 0640 www-data $userv 
	sharedscripts

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


