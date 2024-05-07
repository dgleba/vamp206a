#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  sync clock

# https://help.ubuntu.com/community/UbuntuTime
# http://superuser.com/questions/639202/updating-time-ntpdate3108-the-ntp-socket-is-in-use-exiting/639206

sudo ntpdate -u ntp.ubuntu.com pool.ntp.org


END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...

# needed?
sudo apt-get update
sudo  apt-get -y install ntp

# begin block comment =============================
: <<'END'
# not needed?

sudo tee  /etc/cron.daily/ntpdate <<EOF
#!/bin/sh
ntpdate ntp.ubuntu.com pool.ntp.org
#
EOF
#
sudo chmod 755 /etc/cron.daily/ntpdate
#

END
# end block comment ===============================



#
date
#
