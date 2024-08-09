#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array
date ; set +vx  ; set -vx ; # echo off, then echo on
#


# usage on its own..   prg=~/shc/a3/alias21.sh ; chmod +x $prg ; $prg



#
# You can just pass paramaters to an alias.
#    https://unix.stackexchange.com/questions/3773/how-to-pass-parameters-to-an-alias
#
# Use a function to get alias like behavior with parameters.
#    https://stackoverflow.com/questions/7131670/make-a-bash-alias-that-takes-a-parameter
#      bash$ myfunction() { mv "$1" "$1.bak" && cp -i "$2" "$1"; }
#


# I'd recommend setting it up as a shell function instead.

# https://www.linuxquestions.org/questions/linux-newbie-8/remove-duplicate-lines-alias-927619/

# Aliases are designed generally for simple command substitutions (if the command name matches the alias, 
# the designated string is substituted before the line is executed), and are not really appropriate for more 
# complex commands like this. I'd recommend setting it up as a shell function instead.
# Code:
# dup(){
	# { rm -f "$1" && awk '!( $0 in t ){ t[$0] ; print }' > "$1" ;} <"$1"
# }




#alias for ls -la
#

chmod ugo+r  ~/.bash_aliases
chmod ug+rw  ~/.bash_aliases

echo "alias ll='ls -la'" >>   ~/.bash_aliases
echo "alias lsl='ls -la'" >>   ~/.bash_aliases
echo "alias psg='ps -ef|grep '" >>   ~/.bash_aliases
echo "alias dc='docker-compose'" >>   ~/.bash_aliases
echo "alias dkup='docker-compose up'" >>   ~/.bash_aliases
echo "alias dkd='docker-compose down'" >>   ~/.bash_aliases
echo "alias dkdro='docker-compose down --remove-orphans '" >>   ~/.bash_aliases
echo "alias dkdri='docker-compose down --remove-orphans --rmi all'" >>   ~/.bash_aliases
echo "alias dksp='docker-compose stop'" >>   ~/.bash_aliases
echo "alias dkupd='docker-compose up -d'" >>   ~/.bash_aliases
echo "alias dkupr='docker-compose  up --build  --force-recreate  '" >>  ~/.bash_aliases
echo "alias dkupp='docker-compose up -f docker-compose.prod.yml -d'" >>  ~/.bash_aliases
echo "alias dss='docker stats'" >>  ~/.bash_aliases

#alias to start up bash shell
echo "alias ba='bash'" >>  ~/.bash_aliases 


echo "alias dkps1='set -vx; docker images; docker network ls; docker volume ls;	docker ps -a; docker ps; set +vx'" >> ~/.bash_aliases

tee -a ~/.bash_aliases <<- 'HEREDOC'
dkps () {
	date; set -vx; 
	docker volume ls; 	echo; 
	docker network ls; 
	docker images; 
	docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Status}}\t{{.Size}}" | sort; 	echo;
	docker ps -a --format "table {{.Names}}\t{{.Ports}}\t{{.Status}}" | sort;  
	docker ps -a --format "table {{.Names}}\t{{.Status}}" | sort;  
	set +vx;date;echo;
}
HEREDOC


tee -a ~/.bash_aliases <<- 'HEREDOC'
dps () {
	date; set -vx;	
	docker ps -a --format "table {{.Names}}\t{{.Ports}}\t{{.Status}}" | sort;  
	docker ps -a --format "table {{.Names}}\t{{.Status}}" | sort;  
	set +vx;date;echo;
}
HEREDOC


	#
	# docker ps -a --format "table {{.Names}}\t{{.Ports}}\t{{.Status}}\t{{.RunningFor}}" | sort;  


# rm image by wildcard
tee -a ~/.bash_aliases <<- 'HEREDOC'
drmi () {
	#set -vx; 
	# docker delete images by wildcard 
	# patrn=adminer.*4.6
	patrn=$1
	echo searching images like .. $1
	 docker images | grep "${patrn}"
	 s=120 ; read  -rsp $"Wait $s seconds or press Escape-key or Arrow-keys to continue or Ctrl-c to cancel
	 images..." -t $s -d $'\e'; echo;echo;
	  docker images | grep "${patrn}" | awk '{print $1 ":" $2}' | xargs docker rmi   # delete image.
	set +vx;echo;
}
HEREDOC


# find image by wildcard
tee -a ~/.bash_aliases <<- 'HEREDOC'
dil () {
	set -vx; 
	# docker 
	images by wildcard 
	# patrn=adminer.*4.6
	patrn=$1
	  docker images | grep "${patrn}" 
	  	set +vx;echo;
}
HEREDOC

# no works. see function below..
# echo "alias drmv='docker volume rm $(docker volume ls -qf dangling=true)'" >>   ~/.bash_aliases
#
# rm dangling vol. careful it may be better to delete vol by name. see below..
tee -a ~/.bash_aliases <<- 'HEREDOC'
drmvoldang () {
	set -vx; 
	docker volume rm $(docker volume ls -qf dangling=true) 
	set +vx;echo;
}
HEREDOC

# delete volume by wildcard
tee -a ~/.bash_aliases <<- 'HEREDOC'
dvn () {
	set -vx; 
	vname=xxxxxx
	vname=$1
	docker volume rm -f $( docker volume ls |    grep $vname      | awk '{print $2}' )
	set +vx;echo;
}
HEREDOC


tee -a ~/.bash_aliases <<- 'HEREDOC'
dclean () {
	set -vx; 
	# careful removing volumes. if mysql data is in a volume i would not want to remove it inadvertently.
	# docker volume rm $(docker volume ls -qf dangling=true) 
	docker rm $(docker ps -qa --no-trunc --filter "status=exited") 
	docker rm $(docker ps -qa --no-trunc --filter "status=created") 
	# remove tagged <none> 
	docker rmi $(docker images | grep "^<none>" | awk '{ print $3 }') 
	set +vx;echo;
}
HEREDOC



tee -a ~/.bash_aliases <<- 'HEREDOC'
	dsc() { echo dsc-v3 ~ stop container by name  ; 	docker ps | grep $1 | awk '{print $1}' | xargs docker stop; }
HEREDOC



echo "alias shx='chmod -R +x *.sh'" >>   ~/.bash_aliases
# a function takes parameters... 
echo "alias ll='ls -la'" >>   ~/.bash_aliases
echo "alias hi='history'" >>   ~/.bash_aliases
echo 'dcl() { docker-compose logs "$@" ; }' >> ~/.bash_aliases

# comment out line containing pattern - alias sp=
sed -i.$(date +"%Y-%m-%d_%H.%M.%S").sedbackup   '/alias.sp=/s/^/# /' ~/.bash_aliases  
# now add the line we want.. 
# 'HEREDOC' single quotes means no variable expansion..
tee -a ~/.bash_aliases <<- 'HEREDOC'
alias sp='dts=$(date +"%Y-%m-%d_%H.%M.%S"); seq 1 149 | xargs -I{} date ; echo  Just the spacer only __  $dts -=-=-=-=-=-=-=-=-=-=-=-'
HEREDOC


tee -a ~/.bash_aliases <<- 'HEREDOC'

gra() {
  grep -rLZE ".{599}" --exclude-dir={tmp,log,vendor,node_modules,datasys,sysdata} --exclude={*.lock,*lock*,*tmp*} . | xargs -r0 grep -in --color  "${1}" 
  echo
}

HEREDOC





# =================================================

#
# These no worky.. (use above heredoc)
# echo 'alias sp="dts=$(date +"%Y-%m-%d_%H.%M.%S");seq 1 49 | xargs -I{} date;echo Just a spacer  __ $dts \_\_ -=-=-=-=-=-=-=-=-=-=-=-"'>> ~/.bash_aliases
# echo 'alias sp=`dts=$(date +"%Y-%m-%d_%H.%M.%S");seq 1 49 | xargs -I{} date;echo Just a spacer  __ $dts \_\_ -=-=-=-=-=-=-=-=-=-=-=-`'>> ~/.bash_aliases
# echo "'alias sp='dts=$(date +"%Y-%m-%d_%H.%M.%S");seq 1 49 | xargs -I{} date;echo Just a spacer  __ $dts \_\_ -=-=-=-=-=-=-=-=-=-=-=-''">> ~/.bash_aliases

#
# list aliases....
echo "alias cali='cat ./.bash_aliases'" >>   ~/.bash_aliases
echo "alias aa='cat ~/.bashrc|grep alias; echo '========'; cat ~/.bash_aliases; '" >> ~/.bash_aliases

echo "alias gcd='git clone --depth=1'" >>   ~/.bash_aliases


#~~~~~


# write history immediately...
#
# back ticks evaluate date when run... # http://stackoverflow.com/questions/1859113/append-date-and-time-to-an-environment-variable-in-linux-makefile
# http://askubuntu.com/questions/67283/is-it-possible-to-make-writing-to-bash-history-immediate
# https://askubuntu.com/questions/391082/how-to-see-time-stamps-in-bash-history
# https://askubuntu.com/questions/885531/half-of-bash-history-is-missing?rq=1
cat <<EOF >> $HOME/.bashrc
# -------------------------------------------------------------------
#
umask 002 # make group writable.
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
# -------------------------------------------------------------------
EOF

cat <<EOF >> $HOME/.bashrc
# 
# include commands with leading spaces in history. Solves lines pasted missing from history. 2024-01-02.
export HISTCONTROL=""
# 
#
EOF

# ~~~~~~




