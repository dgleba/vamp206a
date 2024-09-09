#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
#
# change ssh port
#
#


### echo "Port 46281">>/etc/ssh/sshd_config
# backup the file..
file1=/etc/ssh/sshd_config
sudo cp $file1 $file1$(date +"__%Y.%m.%d_%H.%M.%S").bak.txt     # do you need sudo cp?
 
sudo  sed -i '1iPort 46281' /etc/ssh/sshd_config
cat /etc/ssh/sshd_config
#    nano /etc/ssh/sshd_config
