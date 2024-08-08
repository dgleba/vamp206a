#!/usr/bin/env bash
# ---------------------------------------------------
# ---------------------------------------------------


##  Step 2b  as albe - settings and create provision01.sh.
 
# copy paste step 2b into vps terminal. Just ctrl-A select all and paste all of this file.
 

cd
tee ./setup206-0fb.sh <<- 'EOF'


# ---------------------------------------------------


# use && \ to avoid command not running because the one above prevents further execution when pasting several commands at once.



 
##fail2ban

pkgtoin=fail2ban
command -v fail2ban-client >/dev/null 2>&1 ||
{ echo >&2 "$pkgtoin   is not installed. Installing..";
   sudo  apt-get -y install $pkgtoin
}



# ---------------------------------------------------

#
#
## get scripts and setup user helpers..
#
#




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#
#
#  fail2ban
# 
#
#


# albe@pmsdo545:/ap/tmp$ diff jail.local  jail.conf
# ---
# uncomment < bantime.increment = true
# uncomment and set 100 < bantime.rndtime = 100


sudo tee -a /etc/fail2ban/jail.local <<- 'HEREDOC'

bantime.increment = true
bantime.rndtime = 100
HEREDOC

sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo service fail2ban restart
sudo fail2ban-client status


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

EOF

export fil=setup206-0fb.sh ; export pth=~ ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;
# ---------------------------------------------------



