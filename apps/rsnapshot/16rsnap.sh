#!/usr/bin/env bash
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
set +vx
echo ~----------~----------Startinga `dirname "$0"`/`basename "$0"`
# echo ~----------~----------Startingc  `$(readlink -f $0)` 
echo ~----------~----------Startingd $HOSTNAME, pwd: `pwd`, "$0", "${BASH_SOURCE[0]}", $(date +"%Y-%m-%d_%H.%M.%S")
# https://stackoverflow.com/questions/8911724/how-to-find-out-name-of-script-called-sourced-by-another-script-in-bash
echo "from file.... ${BASH_SOURCE[0]}"
echo "${BASH_SOURCE[@]}"  # echo full bashsource array


saynow()
{
date1=$(date +"__%Y.%m.%d_%H.%M.%S")
echo $date1
timeout1=5 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
# I think with lib.trap.sh the read prompt doesn't show. so..   timeout1=111 ; echo "Press ENTER or wait ${timeout1} seconds...." ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
  
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function blockcomment21() {
: <<'BLOCKCOMMENT'

  Purpose: -  usr rsnapshot to backup system, install some package, then restore the system to the state before the package was installed.


BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#main...
saynow


echo
echo 'moved to rsnap function in  https://github.com/dgleba/vamp206a/blob/master/a2/15samsh.sh'
echo  ' notes follow below this message..'
echo  ' I had no luck restoring the system with this. It didnt work correctly after restore. Use timeshift. '
echo

rsnap1() {


cp shc/bin1/histb.sh  $HOME/bin
source bin/histb.sh


sudo apt -y install ncdu rsnapshot

# get copy of /etc/rsnapshot.conf for editing.
cd
file1="/etc/rsnapshot.conf"
sudo cp $file1 $file1$(date +"__%Y.%m.%d_%H.%M.%S").bak.txt     # do you need sudo cp?
mkdir ~/work
cp $file1 work/

sudo cp shc/apps/rsnapshot/rsnapshot.conf /etc

sudo rsnapshot alpha

}

#




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
return 1
end of file comment - this will not excecute.




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Notes:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


These are step by step notes...

Some of this done by the above.


>21.

install ncdu and look for large folders to exclude from the rsnapshot. Then edit the rsnapshot.conf for the excludes.

sudo apt -y install ncdu

sudo ncdu



>31.

sudo apt install rsnapshot


>41.

# copy my rsnapshot.conf to this folder, edit as necessary and copy to /etc..
cd
file1="/etc/rsnapshot.conf"
sudo cp ~/work/rsnapshot.conf $file1 
tail -n95 $file1
ls -la /etc/rsnapsh*


my conf...  https://github.com/dgleba/vamp206a/blob/master/apps/rsnapshot/rsnapshot.conf


>51.

run the alpha snapshot.

sudo rsnapshot alpha


I think...
alpha.0 is always the latest snapshot.
alpha.1 is older



how much space do the backup folders take?

      sudo du /rsnapshot --max-depth=3  -cxh   | sort -h 

      
      

>53.

histb.sh  - store command history..    https://github.com/dgleba/vamp206a/blob/master/bin1/histb.sh


# install a package to see what happens to the system..

sudo apt install aspell



apps ideas to test system restore.

https://searchdatacenter.techtarget.com/tutorial/Linux-command-line-tools-The-top-50



>61.

excluding folders -  how to ...

https://stackoverflow.com/questions/7788046/how-do-you-get-rsync-to-exclude-any-directory-named-cache






>71.

show all files on the system / root folder changed in the last 60 mintues.

This shows you what to restore to put the system back to the way it was earlier.


# list files  --  last 1 hour modified  -- very good and fast.


  export num_minutes=18 ; datef='%.19y \t%.19z \t%A \t%U \t%G \t%n \t%s\n'  ;  mkdir -p $HOME/historybackup ; date1=$(date +"__%Y.%m.%d_%H.%M.%S") ; echo $date1 
  
  cd / ; sudo find  .   -path './sys' -prune -o  -path './proc' -prune -o  -path './run' -prune -o -path './rsnapshot' -prune -o  -path './timeshift' -prune -o -mmin -$num_minutes  -type f -print0 | xargs -0 stat --printf="${datef}"  | sort -n | grep -vE '(.git/|tmp/|lxcfs/cgroup)' 2>&1 | tee  $HOME/historybackup/findlatest_$date1.txt
  
  echo -e '#\n#\n#\n######## ----------------------  Created...\n#\n#'   >>$HOME/historybackup/findlatest_$date1.txt
  cd / ; sudo find  .   -path './sys' -prune -o  -path './proc' -prune -o  -path './run' -prune -o -path './rsnapshot' -prune -o  -path './timeshift' -prune -o -cmin -$num_minutes  -type f -print0 | xargs -0 stat --printf="${datef}"  | sort -n | grep -vE '(.git/|tmp/|lxcfs/cgroup)' 2>&1 | tee -a $HOME/historybackup/findlatest_$date1.txt
  #
  echo -e '#\n#\n#\n########       Sorted by Name   ----------------------  \n#\n#'   >>$HOME/historybackup/findlatest_$date1.txt
  #
  cd / ; sudo find  .   -path './sys' -prune -o  -path './proc' -prune -o  -path './run' -prune -o -path './rsnapshot' -prune -o  -path './timeshift' -prune -o -mmin -$num_minutes  -type f -print0 | xargs -0 stat --printf="${datef}"  | sort -n | grep -vE '(.git/|tmp/|lxcfs/cgroup)' 2>&1 | tee  -a $HOME/historybackup/findlatest_$date1.txt
  
  echo -e '#\n#\n#\n######## ----------------------  Created...\n#\n#'   >>$HOME/historybackup/findlatest_$date1.txt
  cd / ; sudo find  .   -path './sys' -prune -o  -path './proc' -prune -o  -path './run' -prune -o -path './rsnapshot' -prune -o  -path './timeshift' -prune -o -cmin -$num_minutes  -type f -print0 | xargs -0 stat --printf="${datef}"  | sort -n | grep -vE '(.git/|tmp/|lxcfs/cgroup)' 2>&1 | tee -a $HOME/historybackup/findlatest_$date1.txt
  

  


  
>81.

restore:


# restore any folders you wish... 

sudo rsync -av /rsnapshot/alpha.2/localhost/usr/  /usr   --delete  

sudo rsync -av /rsnapshot/alpha.2/localhost/var/  /var   --delete  

sudo rsync -av /rsnapshot/alpha.2/localhost/etc/  /etc   --delete  



# todo.. 
#   https://unix.stackexchange.com/questions/47557/in-a-bash-shell-script-writing-a-for-loop-that-iterates-over-string-values
    # http://sharadchhetri.com/2012/12/13/rsync-fileshidden-filessymlinkshardlinks-remotes-linux-server/
    # rsync all files,hidden files,symlinks,hardlinks to remotes Linux Server -- I have used these flags -ravpzHogt along with rsync command many times in server migration. And I always get good results.
    # -I, --ignore-times   don't skip files that match size and time
    
set -vx
for fr in var usr etc 
do
  echo "${fr}"  
  sudo rsync -ravpzHogt     /rsnapshot/alpha.0/localhost/"${fr}"  /"${fr}" --delete 
  # sudo rsync -ravpzHogt -I /rsnapshot/alpha.0/localhost/"${fr}"  /"${fr}" --delete 
done
set +vx


# example...
# for fname in a.txt b.txt c.txt
# do
  # echo "${fname}"
# done




# example..  rsync -av ./mt/ ./mt2 --delete  # copies folder mt to mt2 and deletes anything in mt2 that is not in mt

#  ref..
cd ; rm -r tmp/mt tmp/mt2
a=tmp/mt
mkdir -p $a ; touch $a ; cd $a
touch a1; touch b1; #mkdir data ; touch data/d1
#
cd; cd tmp
rsync -av ./mt/ ./mt2 # works as expected, makes copy in mt2 that looks like folders in mt/
#  
# delete and sync...   works.
find ; rm mt/b1 ; echo '------- removed mt/b1  ------'; find ;  
rsync -av ./mt/ ./mt2 --delete
find;






=