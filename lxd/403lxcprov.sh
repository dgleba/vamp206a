#!/usr/bin/env bash
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
set +vx
echo ~----------~----------Startinga `dirname "$0"`/`basename "$0"`
# echo ~----------~----------Startingc  `$(readlink -f $0)` 
# echo ~----------~----------Startingd $HOSTNAME, pwd: `pwd`, "$0", "${BASH_SOURCE[0]}", $(date +"%Y-%m-%d_%H.%M.%S")
# https://stackoverflow.com/questions/8911724/how-to-find-out-name-of-script-called-sourced-by-another-script-in-bash

# error in lxc exec - lxc exec lx21 -- sh /home/ubuntu/$f21
#		 echo "from file.... ${BASH_SOURCE[0]}"  			#  /home/ubuntu/403lxcprov.sh: 8: /home/ubuntu/403lxcprov.sh: Bad substitution

# echo "${BASH_SOURCE[@]}"  # echo full bashsource array

#

saynow()
{
date1=$(date +"__%Y.%m.%d_%H.%M.%S")
echo $date1
timeout1=5 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
# I think with lib.trap.sh the read prompt doesn't show. so..   timeout1=111 ; echo "Press ENTER or wait ${timeout1} seconds...." ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
  
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
blockcomment21() {
: <<'BLOCKCOMMENT'

  Purpose:   
    
        provision the container.

		
ref.

lxc exec lx21 -- sudo --login --user ubuntu
		

BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#main...
saynow
#

source /home/ubuntu/safe/21env.sh

#_____________


# setting various helpers like aliases, command history timestamps, etc...

export userv=ubuntu

if ! grep -q "history -a" /home/$userv/.bashrc ; then
{
cd
echo "alias lsl='ls -la'" >>   /home/$userv/.bash_aliases
sudo chmod ugo+rw  ~/.bash_aliases
echo "alias psg='ps -ef|grep '" >>   /home/$userv/.bash_aliases
cat /home/$userv/.bash_aliases

# write history immediately...
#
# back ticks evaluate date when run...
# http://stackoverflow.com/questions/1859113/append-date-and-time-to-an-environment-variable-in-linux-makefile
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sudo cat <<EOF >> /home/$userv/.bashrc
# -------------------------------------------------------------------
# David Gleba $nowdg1
#write history immediately...
# http://askubuntu.com/questions/67283/is-it-possible-to-make-writing-to-bash-history-immediate
# https://askubuntu.com/questions/391082/how-to-see-time-stamps-in-bash-history
# https://askubuntu.com/questions/885531/half-of-bash-history-is-missing?rq=1
#
shopt -s histappend
# PROMPT_COMMAND="history -a;history -r;$PROMPT_COMMAND"
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
#
# 2018-06-13
# export PROMPT_COMMAND='history -a;history -r'
export HISTTIMEFORMAT="%y-%m-%d %T "
export HISTSIZE=10000
export HISEFILESIZE=30000
#
EOF

echo "Running provision onetime routine - 403lxcprov.sh  ${nowdg1}" >> 403lxcprov.sh${nowdg1}.txt
echo "Running provision onetime routine - 403lxcprov.sh  ${nowdg1}" >> /home/$userv/403lxcprov.sh${nowdg1}.txt

cd
mkdir -p bin
sudo chown $userv bin
sudo chgrp $userv bin
cd

# 
mkdir -p tmp01
mkdir -p safe
chmod -R 700 safe/ 

sudo mkdir -p /tmp01/tempfiles
sudo chmod -R 700 tmp01
sudo chmod -R 700 /tmp01/tempfiles
sudo chown -R $userv   tmp01 

}
fi


#_____________


timedatectl 2>&1 | tee -a  timezonesetting.txt
sudo timedatectl set-timezone America/Toronto
timedatectl 2>&1 | tee -a  timezonesetting.txt


sudo apt-get update

# use this to test port 80...
# sudo apt-get -y install nginx mc


#_____________


sudo tee <<EOF  /var/www/html/index.nginx-debian.html
<!DOCTYPE html><title>!</title>
<h1>614a</h1>
<h6>2018-05-30</h6>
<h4>Welcome to nginx webserver on LXD container! </h4>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>
EOF

# sudo cat  /var/www/html/index.nginx-debian.html


#_____________



export pat='PasswordAuthentication'
export fil='/etc/ssh/sshd_config'
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
#
sudo cp  $fil   $fil$(date +"__%Y.%m.%d_%H.%M.%S").bak.txt
#
sudo sed -i "/^${pat}/i # \n# David Gleba kdg54 $nowdg1 \n#"  $fil
sudo sed  -i "s/^${pat}.*/PasswordAuthentication yes/" $fil 
cat /etc/ssh/sshd_config | grep -i passwordau
# cat ./tmpf1 | grep -i passwordau



# _____________
# _____________


# Add use albe..

#adduser asks questions and does more...
sudo adduser albe --gecos "albe,RM,wPhone,hPhone" --disabled-password
#echo "albe:$pw1" | sudo chpasswd
echo "albe:a" | sudo chpasswd
# sudo usermod -a -G adm,dialout,plugdev,www-data,sudo,docker albe
sudo usermod -a -G www-data,sudo albe
#sudo usermod -a -G sudo  albe
sudo gpasswd -a albe sudo
sudo gpasswd -a albe www-data
newgrp www-data
newgrp sudo


#_____________


# setting various helpers like aliases, command history timestamps, etc...

export userv=albe

if ! grep -q "history -a" /home/$userv/.bashrc ; then
{
cd
echo "alias lsl='ls -la'" >>   /home/$userv/.bash_aliases
sudo chmod ugo+rw  ~/.bash_aliases
echo "alias psg='ps -ef|grep '" >>   /home/$userv/.bash_aliases
cat /home/$userv/.bash_aliases

# write history immediately...
#
# back ticks evaluate date when run...
# http://stackoverflow.com/questions/1859113/append-date-and-time-to-an-environment-variable-in-linux-makefile
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sudo cat <<EOF >> /home/$userv/.bashrc
# -------------------------------------------------------------------
# David Gleba $nowdg1
#write history immediately...
# http://askubuntu.com/questions/67283/is-it-possible-to-make-writing-to-bash-history-immediate
# https://askubuntu.com/questions/391082/how-to-see-time-stamps-in-bash-history
# https://askubuntu.com/questions/885531/half-of-bash-history-is-missing?rq=1
#
shopt -s histappend
# PROMPT_COMMAND="history -a;history -r;$PROMPT_COMMAND"
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
#
# 2018-06-13
# export PROMPT_COMMAND='history -a;history -r'
export HISTTIMEFORMAT="%y-%m-%d %T "
export HISTSIZE=10000
export HISEFILESIZE=30000
#
EOF

echo "Running provision onetime routine - 403lxcprov.sh  ${nowdg1}" >> 403lxcprov.sh${nowdg1}.txt
echo "Running provision onetime routine - 403lxcprov.sh  ${nowdg1}" >> /home/$userv/403lxcprov.sh${nowdg1}.txt

cd
mkdir -p /home/$userv/bin
sudo chown /home/$userv bin
sudo chgrp /home/$userv bin
cd

# 
mkdir -p /home/$userv/tmp01
mkdir -p /home/$userv/safe
chmod -R 700 /home/$userv/safe/ 

sudo mkdir -p /home/$userv//tmp01/tempfiles
sudo chmod -R 700 /home/$userv/tmp01
sudo chmod -R 700 /home/$userv/tmp01/tempfiles
sudo chown -R $userv   /home/$userv/tmp01 

}
fi


# _____________


# _____________


# sudo usermod -a -G adm,dialout,plugdev,www-data,sudo ubuntu
# echo "ubuntu:$pw1" | sudo chpasswd
set -vx

# sets the password to a
echo "ubuntu:a" | sudo chpasswd


sudo systemctl restart ssh


# _____________





#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#exit 0  # bad idea. exit will prevent next script. return will give error if not returning from function. Use blockcomment.
# end of file comment this will not excecute.
#
