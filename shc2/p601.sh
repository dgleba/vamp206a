#!/usr/bin/env bash

# chown and chgrp the html files appropriately.. chgrp -hR www-data /var/www/html
sudo chown -R root /var/www/html
sudo chgrp -hR www-data /var/www/html
# also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared . jris198944 May 13 '14 at 8:43 
sudo chmod -R g+rws  /var/www/html
sudo chmod -R o-rw /var/www/html
# make only folders +x so they can be cd into.
sudo find /var/www/html -type d -exec chmod g+x {} +


