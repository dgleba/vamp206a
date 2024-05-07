
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# install sendmail...
#    http://askubuntu.com/questions/47609/how-to-have-my-php-send-mail
sudo apt-get -y install ssmtp

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# remove line containing  'mailhub'  and replace th line completely with the new text...
# add marker line above my edits... 
# add a marker comment like: #David Gleba 2015-10-16... http://stackoverflow.com/questions/11694980/using-sed-insert-a-line-below-or-above-the-pattern
# now replace the line... http://stackoverflow.com/questions/16440377/sed-replace-whole-line-when-match-found
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sudo sed -i "/mailhub/i # \n# David Gleba kdg54 $nowdg1 ...\n#"  /etc/ssmtp/ssmtp.conf
sudo sed -i 's/.*mailhub.*/mailhub=MESG01.stackpole.ca/g' /etc/ssmtp/ssmtp.conf

#working on --  hostname=
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sudo sed -i "/hostname=/i # \n# David Gleba kdg54 $nowdg1 ...\n#"  /etc/ssmtp/ssmtp.conf
sudo sed -i "s/.*hostname=.*/hostname=$default_hostname.$default_domain/g" /etc/ssmtp/ssmtp.conf


#working on --  FromLineOverride=
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sudo sed -i "/FromLineOverride=/i # \n# David Gleba kdg54 $nowdg1 ...\n#"  /etc/ssmtp/ssmtp.conf
sudo sed -i 's/.*FromLineOverride=.*/FromLineOverride=YES/g' /etc/ssmtp/ssmtp.conf

cat /etc/ssmtp/ssmtp.conf

# set mail name

sudo cp /etc/mailname /etc/mailname.$(date "+%Y-%m-%d_%s").bk
sudo echo $default_hostname.$default_domain | sudo tee /etc/mailname
cat /etc/mailname

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# edit /etc/php5/apache2/php.ini
# sudo nano /etc/php5/apache2/php.ini
sudo sed -i "s@;sendmail_path =@sendmail_path = /usr/sbin/sendmail -t@g"  /etc/php5/apache2/php.ini


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#https://askubuntu.com/questions/522431/how-to-send-an-email-using-command-line
#https://www.linuxquestions.org/questions/linux-server-73/how-to-sendmail-to-multiple-recipient-in-command-892158/
#https://askubuntu.com/questions/12917/how-to-send-mail-from-the-command-line
# see also mail man page.  -r=reply -s=subject 
sudo apt-get -y install mailutils
 
echo "Test mail 3 from postfix" | mail -v -r dgleba@stackpole.com -s "Test Postfix"  dgleba@stackpole.com dgleba@stackpole.ca

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

