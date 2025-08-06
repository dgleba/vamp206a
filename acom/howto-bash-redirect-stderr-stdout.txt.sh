---
tags: 
---
#  bash,heredoc,pipe,to,sed,tee,cat,redirect-stderr-stdout2&1,knowk555.txt.sh

ref:
D:\n\sfile\knowtes\knowledge-csd-dg\computer\linux-know\bash,heredoc,pipe,to,sed,tee,cat,redirect-stderr-stdout2&1,knowk555.txt.sh


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@   2>&1  redirect and  tee
#@  
#@@@@@@@@@@@@@@@@@@@@@@@   2022-06-03[Jun-Fri]15-55PM 


ls filename > output.txt 2>&1

```
# crontab -u albe -l | { cat; echo "43 15 * * 1-5 /var/www/html/lukup/actions/imp-lukup.sh >> /home/albe/log/lukupimp.log 2<&1"; } | crontab -u albe -  #add
  crontab -u albe -l | { cat; echo "33 12 * * 1-6 /var/www/html/lukup/actions/imp-lukup.sh 2>&1 | tee -a  /home/albe/log/lukupimp.log"; } | crontab -u albe -  #add
```

Some scripts like model_main_tf2.py need    "  2>&1 "  for tee to work.

```
echo -=-=-=-=-=-=-=-=-=-=--=-=-=- date vars.. dt=%dt%  ts=%ts% rand=%rand1%  2>&1 |D:\data\script\tools599\mlutil599\tee -a training\trainout.txt

```

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  sudo tee heredoc to file.
#@  
#@@@@@@@@@@@@@@@@   2022-10-27[Oct-Thu]10-30AM 

    ###  Check this..  do you NEED sudo or -a  ---  sudo tee -a $fil ?
    #
    fil0=/tmp/0_this_dgleba.sh
    tee  $fil0 <<- 'HEREDOC'
    {
        just a test file  
    }
HEREDOC
    cat $fil0
    chmod +x $fil0
    # bash $fil0

# 


=================================================

#################################################################
#@  
#@  
#@  
####################################   2025-02-25[Feb-Tue]10-13AM 



How to redirect Windows cmd stdout and stderr to a single file?
You want:
dir > a.txt 2>&1


# nohup

```

\\corp-fs01\CORP-PM\data_eng\project_folders\0221_ML_gen-software\tf1678_v02\current\gpu-older\tf1678_instructions_aftersetup_ver-21.txt

nohup  python model_main.py --logtostderr --trainz=train  2>&1 |tee -a mdlz_$(date +"%Y-%m-%d-%H.%M.%S_%Z").log.txt   &


```



#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@   tee to file then run it bash.
#@  
#@@@@@@@@@@@@@@@@@@@@@@@@@@@   2022-06-03[Jun-Fri]15-56PM 



f=/tmp/keep.sh
tee $f <<- 'HEREDOCB'
echo hello
i=0 
while true
do
   echo "$i"
   let i++
   sleep 60
done
HEREDOCB
echo
bash $f



#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  may be better to run this after sudo su -
#@  
#@@@@@@@@@@@@@@@@@@@@@@@@@   2022-04-22[Apr-Fri]14-51PM 

tee ~/dgtsh <<- 'HEREDOCB'
dofunc1 () {
sudo  tee -a $fila <<- 'HEREDOCA'
# dgleba added this 2022-04-22.
[Allow Wifi Scan]
Identity=unix-user:*
Action=org.freedesktop.NetworkManager.wifi.scan;org.freedesktop.NetworkManager.enable-disable-wifi;org.freedesktop.NetworkManager.settings.modify.own;org.freedesktop.NetworkManager.settings.modify.system;org.freedesktop.NetworkManager.network-control
ResultAny=yes
ResultInactive=yes
ResultActive=yes
HEREDOCA
}
fila=/etc/polkit-1/localauthority/50-local.d/10-network-manager-dg.pkla
echo cat.. $fila
sudo cat $fila
#
if sudo test -f "$fila"; then
    echo;echo "  ***  $fila - exists - oops - you must resolve this yourself.";echo;
else    
    echo;echo "  ***  $fila - not present - proceeding.";echo;
    dofunc1
    echo;echo "  ***  $fila - written.";echo;
fi
echo cat.. $fila
sudo cat $fila
HEREDOCB
echo
bash ~/dgtsh
echo


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#################################################################
#@  
#@  
#@  
####################################   2025-02-25[Feb-Tue]10-13AM 



'HEREDOC' single quotes means no variable expansion..

    eg: see alias21.sh


# comment out line containing pattern - alias sp=
sed -i.$(date +"%Y-%m-%d_%H.%M.%S").backup   '/alias.sp=/s/^/# /' ~/.bash_aliases  
# now add the line we want.. 

# 'HEREDOC' single quotes means no variable expansion..
tee -a ~/.bash_aliases <<- 'HEREDOC'
alias sp='dts=$(date +"%Y-%m-%d_%H.%M.%S"); seq 1 49 | xargs -I{} date ; echo  Just the spacer only __  $dts -=-=-=-=-=-=-=-=-=-=-=-'
HEREDOC

#
# These no worky.. (use above heredoc)
# echo 'alias sp="dts=$(date +"%Y-%m-%d_%H.%M.%S");seq 1 49 | xargs -I{} date;echo Just a spacer  __ $dts \_\_ -=-=-=-=-=-=-=-=-=-=-=-"'>> ~/.bash_aliases
# echo 'alias sp=`dts=$(date +"%Y-%m-%d_%H.%M.%S");seq 1 49 | xargs -I{} date;echo Just a spacer  __ $dts \_\_ -=-=-=-=-=-=-=-=-=-=-=-`'>> ~/.bash_aliases
# echo "'alias sp='dts=$(date +"%Y-%m-%d_%H.%M.%S");seq 1 49 | xargs -I{} date;echo Just a spacer  __ $dts \_\_ -=-=-=-=-=-=-=-=-=-=-=-''">> ~/.bash_aliases



#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  
#@  
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   2022-04-14[Apr-Thu]15-35PM 



sudo tee -a /etc/docker/daemon.json <<- 'HEREDOC'
{
    "iptables": false
}
HEREDOC

cat /etc/docker/daemon.json
=================================================



#################################################################
#@  
#@  
#@  
####################################   2025-02-25[Feb-Tue]10-13AM 




how-can-i-write-a-heredoc-to-a-file-in-bash-script


https://stackoverflow.com/questions/2953081/how-can-i-write-a-heredoc-to-a-file-in-bash-script



tee -a newfile <<EOF
line 1
line 2
line 3
EOF


cat << EOF > /tmp/yourfilehere
These contents will be written to the file.
        This line is indented.
EOF



#################################################################
#@  
#@  
#@  
####################################   2025-02-25[Feb-Tue]10-12AM 







https://stackoverflow.com/questions/7046381/multiline-syntax-for-piping-a-heredoc-is-this-portable

cmd1 << EOF | cmd2
text
EOF



ls
tac << 'EOF' | sed 's/a/X/'
tac,toe,
)text(.
EOF




ls

tac << HEREDOCHEREDOC | sed 's/a/X/'
text,(.,
)tac,toe,
HEREDOCHEREDOC




# remove comma from end of line if the next line starts with a ')'...

ls
tac << HEREDOCHEREDOC | sed -e '/^)/{n;s/,$//}' | tac
te,xt(.a,
)tac() toe
HEREDOCHEREDOC


