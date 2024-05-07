

https://www.howtoforge.com/how-to-install-x2goserver-on-ubuntu-14.04-as-vnc-alternative


sudo apt-get update
sudo apt-get install -y python-software-properties
sudo apt-add-repository ppa:x2go/stable -y
sudo apt-get update
sudo apt-get install -y x2goserver x2goserver-xsession
#sudo apt-get install -y x2golxdebindings  # if you use LXDE/lubuntu
sudo apt install x2gomatebindings


_____________ 




dg@red5amx ~ $ sudo add-apt-repository ppa:x2go/stable
You are about to add the following PPA:
 Quick howto to turn your machine into an X2Go server:

sudo apt-add-repository ppa:x2go/stable
sudo apt-get update
sudo apt-get install x2goserver x2goserver-xsession
sudo apt-get install x2gomatebindings  # if you use MATE/mubuntu
sudo apt-get install -y x2golxdebindings  # if you use LXDE/lubuntu

Quick howto to install the x2goclient:

sudo apt-add-repository ppa:x2go/stable
sudo apt-get update
sudo apt-get install x2goclient

Enjoy!
 More info: https://launchpad.net/~x2go/+archive/ubuntu/stable
Press Enter to continue or Ctrl+C to cancel

Executing: /tmp/tmp.GD1B9IwjBX/gpg.1.sh --keyserver
hkp://keyserver.ubuntu.com:80
--recv-keys
0A53F9FD
gpg: requesting key 0A53F9FD from hkp server keyserver.ubuntu.com
gpg: key 0A53F9FD: public key "Launchpad PPA for x2go" imported
gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)
dg@red5amx ~ $ 





_____________ 

install win client..


http://wiki.x2go.org/doku.php/download:start

http://code.x2go.org/releases/X2GoClient_latest_mswin32-setup.exe

_____________ 



sudo service x2goserver restart

