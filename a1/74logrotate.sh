#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

cd
source shc/21env.sh

# http://www.thegeekstuff.com/2010/07/logrotate-examples

sudo tee /etc/logrotate.d/home$uservlog <<EOF
/home/$userv/log/*.log {
    daily
    size 3K
    missingok
    rotate 32
    compress
    delaycompress
    notifempty
}
EOF

sudo tee /etc/logrotate.d/homefilebackup <<EOF
/home/file/backup/mysql/*.sql {
    daily
    size 3K
    missingok
    rotate 5
    compress
    notifempty
}
EOF

sudo tee /etc/logrotate.d/raillog_shiftcsd1p272 <<EOF
# Rotate Rails application logs based on file size
# Rotate log if file greater than ..
/srv/web/shiftcsd1p272/log/*.log {
    size=15k
    daily
    missingok
    rotate 62
    compress
    delaycompress
    notifempty
    copytruncate
}
EOF


sudo tee /etc/logrotate.d/raillog_humidex248 <<EOF
# Rotate Rails application logs based on file size
# Rotate log if file greater than ..
/srv/web/humidex248/log/*.log {
    size=15k
    daily
    missingok
    rotate 62
    compress
    delaycompress
    notifempty
    copytruncate
}
EOF


sudo tee /etc/logrotate.d/var_www_tempfiles_xls <<EOF
# Rotate Rails application logs based on file size # Rotate log if file greater than ..
/var/www/tempfilesdg/*.xls {
    size=1k
    weekly
    missingok
    rotate 8
    compress
    delaycompress
    notifempty
    copytruncate
}
EOF

sudo tee /etc/logrotate.d/var_www_tempfiles <<EOF
# Rotate Rails application logs based on file size # Rotate log if file greater than ..
/var/www/tempfilesdg/*.txt {
    size=1k
    monthly
    missingok
    rotate 8
    compress
    delaycompress
    notifempty
    copytruncate
}
EOF


sudo tee /etc/logrotate.d/home_file_cmm_archive <<EOF
# packup cmm data merge files. delete after 2 years...
/home/file/cmm_archive  {
    rotate 104
    weekly
    missingok
    compress
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


