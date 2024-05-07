exit 9
sleep 999
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2015-10-19[Oct-Mon]11-51AM


# bitbucket download tips...
# http://stackoverflow.com/questions/17682143/download-private-bitbucket-repository-zip-file-using-http-authentication
# https://bitbucket.org/site/master/issues/7393/in-addition-to-raw-allow-to-download-files
#works... 
# this gives the dl a name...
#curl    --user dgleba  https://bitbucket.org/dgleba/vamp206env/raw/master/vne.sh -o vne1.sh
# this uses name of source file...
curl -O --user dgleba  https://bitbucket.org/dgleba/vamp206env/raw/master/vne.sh 

#these don't work....
curl --digest --user dgleba: https://dgleba@bitbucket.org/dgleba/vamp206env.git/raw/master/vne.sh -o vne1.sh
curl --digest   --user dgleba: https://bitbucket.org/dgleba/vamp206env/raw/master/vne.sh -o vne1.sh
curl --digest -O  --user dgleba: https://bitbucket.org/dgleba/vamp206env/raw/master/vne.sh -o vne1.sh
curl --digest -O  --user dgleba: https://bitbucket.org/dgleba/vamp206env/raw/master/vne.sh 
https://dgleba@bitbucket.org/dgleba/vamp206env.git
https://bitbucket.org/dgleba/vamp206env/raw/master/vne.sh
#
# scp info...
# http://stackoverflow.com/questions/50096/how-to-pass-password-to-scp




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2015-10-19[Oct-Mon]11-29AM


#  edit /etc/ssmtp/ssmtp.conf -- edit  mailhub=mail .. replace entire line with mailhub...
# didn't work due to variation in original file. try to replace the line matching string with sed.
# backup file before editing...
sudo cp /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.bak.$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")
#2015-10-16_Fri_11.08-AM
# add a marker comment like: #David Gleba 2015-10-16... http://stackoverflow.com/questions/11694980/using-sed-insert-a-line-below-or-above-the-pattern
# now replace the line... http://stackoverflow.com/questions/16440377/sed-replace-whole-line-when-match-found
# need to replace line... not this... http://unix.stackexchange.com/questions/56123/remove-line-containing-certain-string-and-the-following-line
# 
#sudo sed -i "s@mailhub=mail@mailhub=MESG01.stackpole.ca@g"  /etc/ssmtp/ssmtp.conf

cd
cp /etc/ssmtp/ssmtp.conf  ~/tmp

# add marker line above my edits...
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sed -i "/mailhub/i # \n# David Gleba kdg54 $nowdg1 \n#"  ~/tmp/ssmtp.conf

# remove line containing mailhub and replace it with the new text...
sed -i 's/.*mailhub.*/mailhub=MESG01.stackpole.ca/g' ~/tmp/ssmtp.conf
cat ~/tmp/ssmtp.conf


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2015-10-19[Oct-Mon]10-53AM

ref..
sed
# need to replace line... not this... http://unix.stackexchange.com/questions/56123/remove-line-containing-certain-string-and-the-following-line


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2015-10-19[Oct-Mon]10-34AM


# back ticks evaluate date when run...
# http://stackoverflow.com/questions/1859113/append-date-and-time-to-an-environment-variable-in-linux-makefile
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sudo cat <<EOF >> /home/$userv/.bashrc
# -------------------------------------------------------------------
# David Gleba $nowdg1
#write history immediately...
#http://askubuntu.com/questions/67283/is-it-possible-to-make-writing-to-bash-history-immediate
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
#
EOF



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2015-10-18[Oct-Sun]22-54PM


# back ticks evaluate date when run...
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sudo cat <<EOF >> /home/$userv/.bashrc
# -------------------------------------------------------------------
# David Gleba $nowdg1
#write history immediately...
#http://askubuntu.com/questions/67283/is-it-possible-to-make-writing-to-bash-history-immediate
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
#
EOF




# back ticks evaluate date when run...
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sudo cat <<EOF >> /home/$userv/tmpf1
# -------------------------------------------------------------------
# David Gleba $nowdg1
#write history immediately...
#http://askubuntu.com/questions/67283/is-it-possible-to-make-writing-to-bash-history-immediate
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
#
EOF


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2015-10-18[Oct-Sun]22-09PM



# determine ubuntu version
ubuntu_version=$(lsb_release -cs)

# check for interactive shell
if ! grep -q "noninteractive" /proc/cmdline ; then
    stty sane

    # ask questions
#    read -ep " please enter the username you are currently logged in as: " -i "$userv" userv
#    read -ep " please enter your preferred hostname: " -i "$default_hostname" hostname
#    read -ep " please enter your preferred domain: " -i "$default_domain" domain
  
fi

# print status message
echo " preparing your server; this may take a few minutes ..."


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# backup hosts settings...

#
sudo cp /etc/hosts /etc/hosts.bak.$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")
sudo cp /etc/hostname /etc/hostname.bak.$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#why do this stuff again... ???
# set fqdn
fqdn="$default_hostname.$default_domain"
# update hostname
sudo echo "$default_hostname" > /etc/hostname
sudo sed -i "s@ubuntu.ubuntu@$fqdn@g" /etc/hosts
sudo sed -i "s@vamp206b.vamp206b@$fqdn@g" /etc/hosts
sudo sed -i "s@ubuntu@$default_hostname@g" /etc/hosts
sudo sed -i "s@vamp206b@$default_hostname@g" /etc/hosts
#hostname "$default_hostname"



xx1()
{

worked...
curl --digest --user dgleba:x123za https://bitbucket.org/dgleba/vamp198e/get/master.zip -o vamp198e.zip

192.168.88.86

}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2015-10-15[Oct-Thu]09-02AM

#rsync -av  10.4.10.243:/htdocs/ /var/www/html
#
# copy it over to webwork rename it and extract.
cd ~/tmp

#curl -u "domain\username:passwd" smb://server.example.com/share/file.txt
curl -u "stackpole\dgleba:x" smb://10.4.10.243/htdocs/index.html
curl -u "dg:h" smb://192.168.88.92/htdocs/index.html
curl: (1) Protocol smb not supported or disabled in libcurl

noworks:
smbget -u dg -p h  smb://192.168.88.92/htdocs/index.html
works:
cd tmp
#smbget -u dg -p h  smb://redwe/htdocs/index.html
smbget -u dg -p h  smb://REDWE\var\varvamp\files\htdocs-latest.7z

cd /home/$userv/tmp
#curl --digest --user dgleba https://bitbucket.org/dgleba/vamp198e/get/master.zip -o vamp198e.zip
smbget -u dg -p h  smb://REDWE\var\varvamp\files\htdocs-latest.7z
smbget -u=DG -p=h -w=WORKGROUP smb://REDWE/var/varvamp/files/vne.sh



curl -O -u vagrant:vagrant ftp://192.168.3.6/var/varvamp/files/vne.sh
curl  -O -u vagrant:vagrant ftp://10.4.10.241//home/vagrant/configv1.sh
#curl ftp://192.168.3.6/ -u david:dave -T /var/varvamp/files/htdocs.PMDS-DATA.latest.7z

7z x htdocs.7z
rsync -av ~/tmp/htdocs/ /var/www/html
chmod -R 755 /var/www/html 

curl  -O -u vagrant:vagrant ftp://10.4.10.241//home/vagrant/configv1.sh
curl  -O -u vagrant:vagrant ftp://192.168.3.6//home/vagrant/configv1.sh
curl -O -u vagrant:vagrant ftp://192.168.3.6//var/varvamp/files/vne.sh



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


offlinestuff()  {
#exit 8
echo offline
}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2015-10-11[Oct-Sun]12-39PM



#get the repo to a folder
cd 
wget -N https://codeload.github.com/dgleba/vamp203/zip/master
#unzip [ -j junk paths - all in one folder ]  
#rm -rf shc
# unzip one folder...  unzip  ~/share203/master vamp203-master/hyperv/* -d ./sh
# unzip to destination.. unzip ~/share203/master -d ./sh
unzip -u ./master
cp -a vamp203-master shc
# make files executable recursively
chmod -R 755 ./shc
chmod -R +x ./shc
cd 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
