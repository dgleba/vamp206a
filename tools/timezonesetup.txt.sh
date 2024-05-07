
https://www.digitalocean.com/community/tutorials/how-to-set-up-time-synchronization-on-ubuntu-16-04

2018-06-18_Mon_15.17-PM

date

# program [arguments...] 2>&1 | tee outfile
cd
timedatectl list-timezones  2>&1 | tee -a listtimezonelist.txt

timedatectl 2>&1 | tee -a  timezonesetting.txt

sudo timedatectl set-timezone America/Toronto




=