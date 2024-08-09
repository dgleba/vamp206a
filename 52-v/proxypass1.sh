#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

# Purpose:   direct ip/f213f to ip:921  direct path to port.


result:
        works, but flask then cuts off the /f232f and just makes it ip/admin.
        so then it doesn't work any more.


sudo shc/52-v/proxypass1.sh

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

vhosts4()
{
sudo tee /etc/apache2/sites-available/proxypass1.conf <<EOF
############
#
ProxyRequests Off
<Proxy *>
    Order deny,allow
    Allow from all
    Allow from 127.0.0.1
</Proxy>
SSLProxyEngine on

ProxyPass         /f213f   http://localhost:921
ProxyPassReverse  /f213f   http://localhost:921

ProxyPass         /s179   http://localhost/test2/strap179
ProxyPassReverse  /s179   http://localhost/test2/strap179

ProxyPass         /cif207   http://localhost:920
ProxyPassReverse  /cif207   http://localhost:920

#
EOF
#
}


apache4()
{
  sudo a2enmod proxy proxy_http proxy_balancer
  sudo a2enmod ssl

  sudo a2dissite proxypass1.conf
  sudo a2ensite proxypass1.conf
  sudo service apache2 restart
  #sudo service apache2 reload
}

#main section....................................................................

vhosts4
apache4
date
#
