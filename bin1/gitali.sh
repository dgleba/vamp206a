#!/usr/bin/env bash

# this is https://github.com/dgleba/vamp206a/blob/master/bin1/gitali.sh

set -vx

git config --global alias.pu 'pull'
git config --global alias.s 'status'
git config --global alias.lds 'log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'

git config --global alias.cap '!func(){ git add . && git commit -aqm "$1" &&
    git pull -q --no-progress && git push -q; }; func'

git config --global alias.ca '!func(){ git add . && git commit -aqm "$1" ; }; func'

git config --global alias.d 'diff'
git config --global alias.r 'remote -v'

# ----------



git config --global alias.psa "push --all origin"

git config --global alias.l 'log -p -n 1'
git config --global alias.ld 'log --pretty=format:"%C(yellow)%h\\ %C(green)%ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short --graph'
git config --global alias.tre "log --oneline --decorate --all --graph"
git config --global alias.ldt 'log --pretty=format:"%C(yellow)%h\\ %C(green)%ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short --all --graph'


git config --global alias.ll 'log --name-status HEAD^..HEAD' # list last commit files..  git log --name-status HEAD^..HEAD
# diff to last commit..  git diff HEAD^ HEAD

# print last diff...
# git log --name-status HEAD^..HEAD > diff1
# git diff HEAD^ HEAD>>diff1



git config --global alias.b 'branch'

git config --global alias.co 'checkout'   

git config --global alias.sh 'show  - put hash here'
       
    

#
# Run this in repo folder...
# sed -i -e '/searchstring/ s/mystring/1/ ; s/mystring/0/' $target # if line contains searchstring, replace mystring with 1 otherwise replace it with 0
target='.git/config'
sed -i -e '/filemode/ s/true/false/' $target  # turn filemode to false..
#
 git config --global core.fileMode false
 git config  --global --replace-all core.filemode false
  git config core.eol lf
  git config core.autocrlf input
#
# Win:
git config --global credential.helper wincred
# linux..
git config credential.helper store




function userinfo() 
{

  # paste this if needed..
  git config --global user.email "dgleba@gmail.com"
  git config --global user.name "David Gleba"
  git config --global github.user dgleba
  
}



function my_aliases()
{

cat << 'HEREDOC' >> ~/.bashrc
#
# dgleba aliases
#
#. /home/dgleba/bin/zjump/z.sh
#
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
#
HEREDOC

cat ~/.bashrc
source ~/.bashrc
# ? exec bash

}

set +vx
 
# sleep 3