
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
#
#  Paste these commands..
# 
#
#

#  set firewall


sudo ufw disable
sudo ufw logging low 
sudo ufw limit 22/tcp # limit ssh attempts

sudo ufw default deny incoming

sudo ufw allow 80/tcp # http
sudo ufw allow 443/tcp # https
sudo ufw allow 46281/tcp  # ssh

# sudo ufw deny 2375
# sudo ufw deny 2376

# sudo ufw allow 6031/tcp # http
# sudo ufw allow 16123/tcp # http
# sudo ufw allow 16125/tcp # http
# sudo ufw allow 16126/tcp # http

# sudo ufw deny 6031/tcp # http
# sudo ufw deny 16123/tcp # http
# sudo ufw deny 16125/tcp # http
# sudo ufw deny 16126/tcp # http

# sudo ufw allow 25
# sudo ufw allow ssh


# vnc
# sudo ufw allow from any to any port 5900 proto tcp
# rdp
# sudo ufw allow from any to any port 3389 proto tcp

sudo ufw enable
sudo ufw status

sudo service ufw stop
sudo service ufw start


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~