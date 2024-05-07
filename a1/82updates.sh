#!/usr/bin/env bash

saynow()
{
date1=$(date +"__%Y.%m.%d_%H.%M.%S")
echo $date1
timeout1=5 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
}

backup1()
{
# create file hello, backup the original file once, and copy it with timestamp.
# An example of how to backup a file before editing it with a script.
mkdir -p ~/tmp01
file1="$HOME/tmp01/hello"
echo "hello" >$file1 ; echo "foo bar">>$file1
# backup original file once..
if [ ! -f $file1.orig ] ; then sudo cp $file1 $file1.orig ; fi
#back it up with a unique name using a timestamp..
sudo cp $file1 $file1$(date +"__%Y.%m.%d_%H.%M.%S").latestbak.txt
sudo cp $file1 $file1.bak.txt
# add line1's after line matching pattern1
pattern1='^hello'
line1=' \ \ #added line 1\n \ #added line 2 = ":8071" '
sudo sed -i.$(date +"_%Y%m%d_%H%M%S").sedbak.txt "/$pattern1/a $line1" $file1
# restore to orig.. sudo cp $file1.orig $file1
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function offline21() {
: <<'BLOCKCOMMENT'

  Purpose: do security updates..  


BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#main...
saynow

date1=$(date +"__%Y.%m.%d_%H.%M.%S") ; echo $date1 ; sudo unattended-upgrades -v --dry-run > ~/upgradesecurity$date1.txt

sudo unattended-upgrades -v --dry-run 

#  sudo unattended-upgrades -v 


#https://www.tecmint.com/auto-install-security-updates-on-debian-and-ubuntu/
#https://help.ubuntu.com/community/AutoWeeklyUpdateHowTo

sudo dpkg-reconfigure -plow unattended-upgrades


#Next, open /etc/apt/apt.conf.d/50unattended-upgrades with your preferred text editor and add this line inside the Unattended-Upgrade::Origins-Pattern block:
#Unattended-Upgrade::Mail "root";


saynow
#



