#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  

# allow users to reload apache without root access...

# note:

Generally all setup is done by scripts -  not by editing files in an editor.
Sudoers files are the exception because visudo checks for invalid setup.
See the bottom for the hell that one must go through to fix it if the syntax is wrong.
You have to take the server down and mount the disk in recovery mode to fix it.
Goodness gratious that's insane.
This is why visudo is used to edit sudoers files.


sudo service apache2 reload

# i don't think nginx needs to reload, it is flask217 uwsgi upstart service that needs to restart.


END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





######  ******  Just visudo to create the file. it checks for errors and saves having to manually fix it with the server offline.

sudo  visudo -f /etc/sudoers.d/websreload2





echo.. "do not run the rest. --- manually edit by visudo.."
echo .
read -t  999 -p "Hit ENTER or wait about 900 seconds" ; echo ;


function howto() {


# begin block comment =============================
: <<'END'
# better.. create the file in /tmp/dg/websreload2 , sudo chmod 0440 websreload2 , copy it into /etc/sudoers.d ...
# http://www.peppertop.com/blog/?p=1015
mkdir -p /tmp/dg
sudo tee /tmp/dg/websreload2 <<EOF
# safest to do this...
# sudo  visudo -f /etc/sudoers.d/websreload2
#
# www-data group on all machines can run this command...
%www-data   ALL= NOPASSWD:  /usr/bin/service apache2 reload, /usr/bin/service apache2 restart
EOF
sudo chmod 0440 /tmp/dg/websreload2
sudo cp /tmp/dg/websreload2 /etc/sudoers.d/websreload2
cat /etc/sudoers.d/websreload2
END

# end block comment ===============================
}



for metabase restart..

# sudo visudo

%www-data   ALL= NOPASSWD:  /user/binjava

%www-data ALL= NOPASSWD: /etc/init.d/metabase1

%www-data   ALL= NOPASSWD:  /home/albe/bin/metabase_stopstart.sh
%www-data   ALL= NOPASSWD:  /home/albe/bin/metabase_start.sh
%www-data   ALL= NOPASSWD:  /home/albe/bin/metabase_stop.sh



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

for mcs...


# sudo visudo
#resolve no tty cron error.. cpimport cron sudo: no tty present and no askpass program specified
# albe ALL=(ALL) NOPASSWD: ALL
works..
albe   ALL= NOPASSWD:  /usr/local/mariadb/columnstore/bin/cpimport





#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





### notes....







#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function notes() {
# begin block comment =============================
: <<'END'

sudo  visudo -f /etc/sudoers.d/websreload2

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#    service apache2 reload   service nginx reload
# not sure this is the way to go...
# http://stackoverflow.com/questions/525672/is-there-a-way-to-start-restart-stop-apache-server-on-linux-as-non-root-user
# http://www.softpanorama.org/Access_control/Sudo/sudoer_file_examples.shtml


#http://askubuntu.com/questions/229809/allow-non-sudo-group-to-control-upstart-job
# use...  sudo initctl stop flask217; sudo initctl start flask217


C:\n\Dropbox\csd\serve\vboxyard\vamp206a\older\61userrestartweb,nonsudogroup,sudo-onecommand--old.sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# clean up my junk...
#sudo rm /etc/sudoers.d/apache2reload
#sudo rm /etc/sudoers.d/apache2etcreload

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# try this...

sudo tee /usr/local/bin/webreload.sh <<EOF
#!/usr/bin/env bash
/bin/kill -HUP `cat /var/run/nginx.pid`
sudo service flask217 restart
#
EOF
sudo chmod ugo+x /usr/local/bin/webreload.sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#
#sudo rm /etc/sudoers.d/webreload2
# http://stackoverflow.com/questions/3011067/restart-nginx-without-sudo
#sudo tee /etc/sudoers.d/webreload2 <<EOF
#error, why?  pmdsu $HOSTNAME ALL=NOPASSWD:/usr/local/bin/webreload.sh
# ans. all is the hostname. remove $HOSTNAME.
#EOF

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# emperor mode? https://www.digitalocean.com/community/tutorials/how-to-serve-django-applications-with-uwsgi-and-nginx-on-ubuntu-14-04
# http://www.jeffwidman.com/blog/802/configuring-a-single-nginx-uwsgi-server-to-serve-multiple-flask-apps/

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# fix sudo error
#
# error ..  /etc/sudoers.d/webreload2: syntax error near line 2 sudo: parse error in /etc/sudoers.d/webreload2 near line 2 sudo: no valid sudoers sources found, quitting sudo: unable to initialize policy plugin
# fix..
#noworky... pkexec visudo -f /etc/sudoers.d/webreload2
#  had to boot to recovery and...
#  something here allowed me to rm the file...
#    3  mount -o remount,rw /dev/sda1 /mnt
#   27  mount -o remount,rw /dev/mapper/vamp206b--vg-root /mnt
#   30  mount -o remount,rw /
#   41  rm /etc/sudoers.d/webreload2
#

# noneed.. mount -o remount,rw /dev/sda1 /mnt
# noneed ..  mount -o remount,rw /dev/mapper/vamp206b--vg-root /mnt

#works...
# mount -o remount,rw /
# rm /etc/sudoers.d/webreload2
# rm /etc/sudoers.d/websreload2

#  sudo rm /etc/sudoers.d/websreload2

# best practice to create sudoer.d file, it checks for errors before writing it..
#
#  sudo visudo -f /etc/sudoers.d/websreload2

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
