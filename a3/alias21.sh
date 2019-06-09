#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array
date ; set +vx  ; set -vx ; # echo off, then echo on
#


# usage on it own..   prg=~/shc/a3/alias21.sh ; chmod +x $prg ; $prg



#
# You can just pass paramaters to an alias.
#    https://unix.stackexchange.com/questions/3773/how-to-pass-parameters-to-an-alias
#
# Use a function to get alias like behavior with parameters.
#    https://stackoverflow.com/questions/7131670/make-a-bash-alias-that-takes-a-parameter
#      bash$ myfunction() { mv "$1" "$1.bak" && cp -i "$2" "$1"; }
#





#alias for ls -la
#

echo "alias ll='ls -la'" >>   ~/.bash_aliases
echo "alias lsl='ls -la'" >>   ~/.bashrc
sudo chmod ugo+rw  ~/.bash_aliases
echo "alias psg='ps -ef|grep '" >>   ~/.bash_aliases

echo "alias dc='docker-compose'" >>   ~/.bash_aliases
echo "alias dkup='docker-compose up'" >>   ~/.bash_aliases
echo "alias dkd='docker-compose down'" >>   ~/.bash_aliases
echo "alias dkst='docker-compose stop'" >>   ~/.bash_aliases
echo "alias dkupd='docker-compose up -d'" >>   ~/.bash_aliases
echo "alias dkupr='docker-compose  up --build  --force-recreate  '" >>  ~/.bash_aliases
echo "alias dkupp='docker-compose up -f docker-compose.prod.yml -d'" >>  ~/.bash_aliases

echo "alias dkps='set -vx; docker images; docker network ls; docker volume ls;	docker ps -a; docker ps; set +vx'" >> ~/.bash_aliases
	
echo "alias shx='chmod -R +x *.sh'" >>   ~/.bash_aliases
 
# a function takes parameters... 
echo 'dcl() { docker-compose logs "$@" ; }' >>   ~/.bashrc
 
 
#
#
#
# list aliases....
echo "alias aa='cat ~/.bashrc|grep alias; echo '========'; cat ~/.bash_aliases; '" >> ~/.bash_aliases


cat ~/.bash_aliases


#~~~~~



# write history immediately...
#
# back ticks evaluate date when run... # http://stackoverflow.com/questions/1859113/append-date-and-time-to-an-environment-variable-in-linux-makefile
# http://askubuntu.com/questions/67283/is-it-possible-to-make-writing-to-bash-history-immediate
# https://askubuntu.com/questions/391082/how-to-see-time-stamps-in-bash-history
# https://askubuntu.com/questions/885531/half-of-bash-history-is-missing?rq=1
sudo cat <<EOF >> $HOME/.bashrc
# -------------------------------------------------------------------
#
shopt -s histappend
# PROMPT_COMMAND="history -a;history -r;$PROMPT_COMMAND"
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
#
# export PROMPT_COMMAND='history -a;history -r'
export HISTTIMEFORMAT="%y-%m-%d %T "
export HISTSIZE=10000
export HISEFILESIZE=30000
#
EOF


#~~~~~~

mkdir -p bin
sudo chown -R $userv bin
sudo chgrp -R $userv bin
cd
sudo cp shc/bin1/* bin

sudo echo  '#!/usr/bin/env bash' >> ~/bin/blank.sh
sudo chmod +x ~/bin/blank.sh
cat ~/bin/blank.sh


# install z-jump
  cd $HOME
  mkdir -p $HOME/bin
  git clone https://github.com/dgleba/z.git  bin/zjump
  echo . $HOME/bin/zjump/z.sh >> $HOME/.bashrc
  
  source $HOME/.bashrc
  cd /var/www/html
  # cd /etc/network
  cd /var/log
  z -h
  z -h
  cd
  z
  z

sudo chmod -R +x bin
sudo chown -R $userv bin
sudo chgrp -R $userv bin




