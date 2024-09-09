
remove user and home folder...
userdel -r user's username


sudo  userdel -r pmdsu
sudo  userdel -r ftpup
sudo  userdel -r dgleba



#adduser asks questions and does more...
sudo adduser dgleba --gecos "david gleba,RM,wPhone,hPhone" --disabled-password
echo "dgleba:$pw1" | sudo chpasswd
#sudo useradd -d /home/dgleba -m dgleba
# no home dir... sudo useradd dgleba
#sudo passwd dgleba
sudo usermod -a -G adm,dialout,plugdev,sambashare,www-data dgleba
#sudo usermod -a -G sudo  dgleba

