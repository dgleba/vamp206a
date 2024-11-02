1#!/usr/bin/env bash
cd
set -vx    # echo on
set +vx    # echo off
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function notes()
{
exit 999
# begin block comment =============================
: <<'END'

search..

**************   table of contents   ****************

>21. * find newest files

>31. find file excluding some folders

>51.  grep

>52.  *  grep with find exclude paths..

>71.  *  grep

>151  *  find folders named..

>171 find files system wide in the last hour

>181 locate

>191 find with perms,user,group,mtime,size


http://askubuntu.com/questions/208030/search-for-files-with-gui

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


===
commonly used..
===

date1=$(date +"__%Y.%m.%d_%b-%a_%H.%M.%S")
echo $date1

#find newest..
  # sort -k1 for newest date and -k3 for size.
  find  . -mtime -249 -type f -print0 | xargs -0 stat --printf='%.16y\t%s\t%n\n'  | sort -h -k1 |  grep -v '.git/' | grep -v tmp/ |grep -v x/ |grep -v datasys/ |grep -v sysdata/ |grep -v djangosite/static |grep -v venv |grep -v log/ |grep -v prg/  | tail -n1254 
  # |grep gpt


===
grep  short line files..
===

grep -rLZE '.{499}' --exclude-dir={tmp,log,vendor,node_modules,data,datasys,sysdata,sprockets,cache,x,static} --exclude={*.log,*.lockzz,*lockzz*} . | xargs -r0 grep -in --color "env.produ"

grep -rLZE '.{599}' --exclude-dir={tmp,log,vendor,node_modules} --exclude={*.lock,*lock*} . | xargs -r0 grep -in --color 'ldap_server'
 


# ignore case 
 grep -rLZE '.{400}' --exclude-dir={tmp,log,vendor,node_modules} --exclude={*.log,*.lockz,*lockz*} . | xargs -r0 grep -in --color debug
 
 # case.. 
 grep -rLZE '.{400}' --exclude-dir={tmp,log,vendor,node_modules} --exclude={*.log,*.lockz,*lockz*,} . | xargs -r0 grep -n --color 9999
 
 
  grep -rLZE '.{400}'  . | xargs -r0 grep -in --color 192.168
  
  
 grep -inr --color 'ConfigureServices'


grep-exclude-multiple-strings - works good. see rsnew and shouldbe.named___rsynbk-redwe458sh

grep -v exclude with multiple patterns, strings.
    grep 'test' somefile | grep -vE '(error|critical|warning)'


grep -ri  --include={"*.yaml",*.yml,*.py,*.ipynb} --exclude-dir={tmp,log,vendor,node_modules} 'evaluate' * 


===
find newest...  [ -mtime -3 means less than 3 days old ]
===

  # sort -k1 for newest date and -k3 for size.
  find  . -mtime -152 -type f -print0 | xargs -0 stat --printf='%.16y\t%s\t%n\n'  | sort -h -k1 |  grep -v '.git/' | grep -v tmp/ |grep -v x/ |grep -v datasys/ |grep -v sysdata/ |grep -v djangosite/static | tail -n1254 
  # |grep gpt

 
  find  . -mtime -14 -type f -print0 | xargs -0 stat --printf='%.16y\t%A %a %h %U %u %G %g\t%s\t%n\n'  |  grep -v '.git/' | grep -v tmp/ |grep -v x/ |grep -v /sysdata/ | sort -n | tail -n1254

# eg: --printf='%.16y %A %U %G %s\t%n\n' 

  # -mtime -29 = 29 days 
    sudo  find  . -mtime -29 -type f -print0 | sudo xargs -0 stat --printf='%.16y %A %a %h %U %u\t %G %g\t %s\t %n\n'  | sort -n |  grep -v '.git/' | grep -v tmp/ |grep -v x/ | tail -n1254


------------

*************        Find one newest file in each subfolders.
this no worky..   see  D:\n\sfile\serve\vamp206a\bin1\single.newest.file.each.folder.txt.paste-gpt.py

  find . -mtime -322 -type f -exec stat -c '%y %n' {} + | sort -k1,1 | awk '!seen[$2]++' | grep -v '.git/' | grep -v tmp/ |grep -v x/ | grep -v /sysdata/  
  
  |grep gpt



===
sort by file size 
===

  #human readable.
	find  . -mtime -943 -type f -print0 | xargs -0 stat --printf='%.16y\t%s\t%n\n' | grep -v '.git/'| grep -v tmp/ | grep -v x/|  sort -n -k3 | numfmt --field=3 --to=iec-i |tail -n1254


	find  . -mtime -92343 -type f -print0 | xargs -0 stat  --printf='%.16y %A %h %U\t%G\t%s\t%n\n'   | sort -n -k 7,11 |  grep -v '.git/' | grep -v tmp/ |grep -v x/ | tail -n1254
  
	find  . -type f -print0 |  xargs -0 stat  --printf='%.16y %A %a %h %U %u\t %G %g\t %s\t %n\n'| sort  -n -k 10,10 |   tail -n150  | tee -a ${ft}_find.txt



===
disk usage
===
 
  sudo du . --max-depth=1  -cxh   | sort -h 



# find folders named...

# works..
  fnd='*relay*' ; f1=/tmp/findtmp ; sudo find . -type d -not \( -name tmp -prune \) ! \( -name node_modules -prune \) \
    -iname "$fnd" >"$f1"; echo .;  echo '==== OUTPUT -- FOLDERS LIKE.. ' "$fnd"; cat "$f1" | sort 


# This can be just right if you do not need locate db updated.
	locate relay |grep compose


locate-to-search-for-  folders-only. 182

  #exact match on folder name...
  locate --ignore-case -r '/465$'
  #just a string.
  locate --ignore-case -r 'mevn-stack'


===
separator
===


  dts=$(date +"%Y-%m-%d_%H.%M.%S"); seq 1 49 | xargs -I{} date ; echo  Just the spacer only __ $dts \_\_ -=-=-=-=-=-=-=-=-=-=-=-



tree -d -L 3 >tree.dir3.out.txt
tree -d -L 4 >tree.dir4.out.txt
tree -d -L 5 >tree.dir5.out.txt
tree -d  >tree.dir.out.txt
tree -D >tree.file.out.txt


find folders named....

  fnd='*djangoproj*' ; f1=/tmp/findtmp ;  find . -type d -not \( -name tmp -prune \) ! \( -name node_modules -prune \) \
    -iname "$fnd" >"$f1"; echo .;  echo '==== OUTPUT -- FOLDERS LIKE.. ' "$fnd"; cat "$f1" | sort 






#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






scratch..








#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

scratch..


cd /srv  
  find  . -mtime -92343 -type f -print0 | xargs -0 stat --printf='%.16y %A %h %U\t%G\t%s\t%n\n' | sort -n |  grep -v '.git/' | grep -v tmp/ |grep -v x/ | tail -n1254
s=96 ; date ; read -t $s -p "press Enter or wait $s seconds" ; echo ; date;

cd /home/dclark  
  find  . -mtime -92343 -type f -print0 | xargs -0 stat --printf='%.16y %A %h %U\t%G\t%s\t%n\n' | sort -n |  grep -v '.git/' | grep -v tmp/ |grep -v x/ | tail -n1254
s=96 ; date ; read -t $s -p "press Enter or wait $s seconds" ; echo ; date;

cd /var/www 
  find  . -mtime -92343 -type f -print0 | xargs -0 stat --printf='%.16y %A %h %U\t%G\t%s\t%n\n' | sort -n |  grep -v '.git/' | grep -v tmp/ |grep -v x/ | tail -n1254
s=96 ; date ; read -t $s -p "press Enter or wait $s seconds" ; echo ; date;


cd /var/www 
  find  . -mtime -92343 -type f -print0 | xargs -0 stat --printf='%.16y %A %h %U\t%G\t%s\t%n\n' | sort -n |  grep -v '.git/' | grep -v tmp/ |grep -v x/ | tail -n1254
s=96 ; date ; read -t $s -p "press Enter or wait $s seconds" ; echo ; date;


 

 grep -rLZE '.{400}' --exclude-dir={tmp,log,vendor,node_modules,spec} --exclude={*.log,*.lock,*lock*} . | xargs -r0 grep -in --color exp


find  . -mtime -92343 -type f -print0 | xargs -0 stat --printf='%.16y %A %h %U\t%G\t%s\t%n\n' | sort -n |  grep -v '.git/' | grep -v tmp/ |grep -v x/ | grep admi
tail -n1254
 
 
command with date seperator spacer

dts=$(date +"%Y-%m-%d_%H.%M.%S"); seq 1 45 | xargs -I{} date ;     \
   docker-compose logs --tail 999 -t -f db web nginx    \
            ; seq 1 5 | xargs -I{} date ;  echo Started__ $dts \_\_ -=-=-=-=-=-=-=-=-=-=-=-




dts=$(date +"%Y-%m-%d_%H.%M.%S"); seq 1 49 | xargs -I{} date ; echo  Just the spacer only __ $dts \_\_ -=-=-=-=-=-=-=-=-=-=-=-

      

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
date
#

#main...

#works...
sudo apt-get install catfish

#do gui visible in lxde. may not work in lxde...
sudo apt-get install  gnome-search-tool




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


>19.

command with date seperator spacer

dts=$(date +"%Y-%m-%d_%H.%M.%S"); seq 1 45 | xargs -I{} date ;     \
   docker-compose logs --tail 999 -t -f db web nginx    \
            ; seq 1 5 | xargs -I{} date ;  echo Started__ $dts \_\_ -=-=-=-=-=-=-=-=-=-=-=-




dts=$(date +"%Y-%m-%d_%H.%M.%S"); seq 1 49 | xargs -I{} date ; echo  Just the spacer only __ $dts \_\_ -=-=-=-=-=-=-=-=-=-=-=-

 



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>21. find new files...



nice. sorted by file size. column 10 and only 10 , - 10,10

	sudo find  ./sysdata/mysqldata  -type f -print0 | sudo xargs -0 stat --printf='%.16y %A %a %h %U %u\t %G %g\t %s\t %n\n' | sort -n -k 10,10 |  grep -v '.git/' | tail -n50  |tee -a $ft.find

	sudo find  ./sysdata/mysqldata  -type f -print0 | sudo xargs -0 stat --printf='%.16y %A %a %h %U %u\t %G %g\t %s\t %n\n' | sort -n -k 10 |  grep -v '.git/' | tail -n50  |tee -a $ft.find

		stat -c '%.16y %A %a %h %U\t %G\t %s\t %n\n' /etc/passwd
		stat --printf='%.16y %A %a %h %U %u\t %G %g\t %s\t %n\n' /etc/passwd
		stat -c '%a' /etc/passwd



find . -type f | xargs stat --format '%Y :%y %n' | sort -nr | cut -d: -f2- | head

or

newest file last.
stat --printf="%y %n\n" $(ls -tr $(find * -type f))

exclude tmp folder...
stat --printf="%y %n\n" $(ls -tr -Itmp $(find * -type f)) | grep -v tmp/ | tail -n44


i think this lists folders, but not tmp.
ls -tr -Itmp


works..
find $1 -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -nr | cut -d: -f2- | head 

find $1 -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v tmp/ 


#list 55 newest files. exclude tmp .git 

find $1 -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/ | tail -n99


#use other.. worked..
find . /home /var/www /srv/web -iname kami* -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/ | tail -n155

#worked.. files only
find . /home/albe/web /var/www /srv/web -iname drail246b* -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/ 

find  /home/share203 /home/albe/web /var/www/html /srv/web -iname *242* -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/ 

#worked.. files only
find . /home/albe/web /var/www /srv/web  -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/ | tail -n155

#worked.. files only
find  /home/albe/share203 /home/albe/web /var/www/html /srv/web  -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/ | tail -n955 | \
grep 249 > ~/0/lcout.txt

find  /home/albe/web/drail/drail246b   -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/ | tail -n955 | grep gitignor > ~/0/lcout.txt

find  .   -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/ | tail -n955 | grep   items   > ~/0/lcout.txt


# newest files ....
find  /home/albe/share203 /home/albe/web /var/www/html /srv/web  -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/ | tail -n654

find    /srv/web  -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/ | tail -n454

# newest files ....
# yes
find  .  -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/ | tail -n654
# no
find  .  -type f -print0 | xargs -0 stat --printf='%y %A %h %U %G %s  %n\n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/ | tail -n654


good..
# https://unix.stackexchange.com/questions/184814/stat-print-time-in-long-iso-format
find  .  -type f -print0 | xargs -0 stat --printf='%.16y %A %h %U %G %s\t %n\n' | sort -n |  grep -v '.git/' | grep -v tmp/ | tail -n654


# good
# last 1 hour modified
# sudo find  . -mmin -60 -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/  2>&1 | tee -a /home/albe/find21.txt
# really good.. http://www.liamdelahunty.com/tips/linux_find_exclude_multiple_directories.php
  sudo find  .  -path './sys' -prune -o   -path './proc' -prune -o   -mmin -60 -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/  2>&1 | tee  /home/albe/find21.txt
  or
  # good..
    sudo find  .   -path './sys' -prune -o   -path './proc' -prune -o  -mmin -110  -type f -print0 | xargs -0 stat --printf='%Y:%y %A %h %U %G %s \t %n\n'  | sort -n | cut -d: -f2- | grep -v '.git/' | grep -v tmp/  2>&1 | tee  /home/albe/find21.txt



# last 1 day
find  . -mtime -1 -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -n | cut -d: -f2- | grep -v '.git/' |  grep -vE '(tmp/|log/|vendor/|fonts/|node_modules/)' | tail -n354




# grep grav 42 days..
find  . -mtime -42 -type f -print0 | xargs -0 stat --printf='%.16y %A %h %U\t%G\t%s\t%n\n' | sort -n |  grep -v '.git/' | grep -v tmp/ |grep -v x/ | grep -i grav

no..
find  . -mtime -82 -type f -print0 -iname *.html | xargs -0 stat --printf='%.16y %A %h %U\t%G\t%s\t%n\n' | sort -n |  grep -v '.git/' | grep -v 'node_modules/' | grep -v tmp/ |grep -v x/ | grep -i searchOnTable


# good..
find  . -mtime -89 -type f -print0 | xargs -0 stat --printf='%.16y %A %h %U\t%G\t%s\t%n\n' | sort -n |  grep -v '.git/' | grep -v tmp/ |grep -v x/ | tail -n154

 

http://stackoverflow.com/questions/5566310/how-to-recursively-find-and-list-the-latest-modified-files-in-a-directory-with-s

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>31.   find file excluding some folders


excluding file names..
find . -type f \! -name "*.js"  -print0 | xargs -0 grep -i content

find . -type f \! -name "*.rb"  -print0 | xargs -0 grep -i stf_empl


#works..
find . -type f \! -name "*.js"  \! -name "*mdb.min.css"  ! -path "./tmp/*" ! -path "./.git/*" ! -path "./log/*"   -print0 | xargs -0 grep -i content

# works..
#   find files excluding all folders named tmp, etc...
find .    ! -name "*.env"  ! -path "*/tmp/*" ! -path "*/.git/*" ! -path "*/log/*" ! -path "*/node_modules/*" | grep mong

# works..
find .    ! -name "*.env"  ! -path "*/tmp/*" ! -path "*/.git/*" ! -path "*/log/*" ! -path "*node_modules*" ! -path "*92dkr*" | grep mong

#noworky..
find .    ! -name "*.env"   ! -path {"*node_modules*","*92dkr*"} | grep mong


# exclude list of folders from file..   find exclude list of multiple paths
# https://stackoverflow.com/questions/29652123/excluding-unknown-number-of-multiple-directories-from-find-search-unix
      # Exclude dirs from file . Just create your find command from the file:
      # exclude=' ! -path "./'$(paste -s -d'#' dirstoexclude | sed 's/#/\/\*" ! -path "\.\//g')'/*"'
      # find . -type f ${exclude}
#
#vexcludedir=' ! -path "./'${vdirs/,/\/*\" ! -path \"./}'/*"'
 # vexcludedir=' ! -path "*'${vdirs/,/*\" ! -path \"*}'*"'
#
# noworky..
 vdirs=92dkr,node_modules
 vexcludedir=' ! -path "*'${vdirs/,/*\" ! -path \"*}'*"'
echo $vexcludedir
find .  ! -name "*.env"  $vexcludedir | grep mong





~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>51. grep..


#less than 400 character lines.

 grep -rLZE '.{400}' --exclude-dir={tmp,log,vendor,node_modules} . | xargs -r0 grep -in --color api





grep -Ri --exclude-dir='public/admin/js'  --exclude-dir={node_modules,tmp,log,vendor,dist,'public/admin/js',jsx} --exclude={yarn.lock*,CHANGELOG.md,bulma.min.css,vendor.js,*.css,s*.sql,chunk*.js,app*.js}  '3333' * |less


grep -ri  --include={"*.yaml",*.yml} --exclude-dir={tmp,log,vendor,node_modules} '\[' * 

grep -ri  --include={"*.py",*.yml} --exclude-dir={tmp,log,vendor,node_modules} blut * 

grep -ri  --include={"*.rb",*.yml} --exclude-dir={tmp,log,vendor,node_modules} stf_empl * 

grep -ri  --include={"*.php",*.yml} --exclude-dir={tmp,log,vendor,node_modules,templates_c} vw_reportemails * 


grep -ri --exclude-dir={node_modules,tmp,log,vendor,dist} ':8080' *


grep -ri --exclude-dir={node_modules,tmp,log,vendor,dist} --exclude={yarn.lock*,CHANGELOG.md,bulma.min.css,vendor.js} 'redis' *

#only filenames = -l  -- when the output is too long to see what file to exclude.
grep -l -ri --exclude-dir={node_modules,tmp,log,vendor,dist} --exclude={yarn.lock*,CHANGELOG.md,bulma.min.css} '3030' *



grep -ri --exclude-dir={node_modules,tmp,log,vendor,dist} vue-template-compiler *

grep -ri --exclude-dir={node_modules,tmp,log,vendor,dist} brail *



grep -ri --exclude-dir={tmp,log,vendor} __1 *   | grep -vi __1



grep -r --exclude-dir={node_modules,tmp,log,vendor} localhos *



grep -r --exclude-dir={node_modules,tmp,log,vendor} DB: * 

grep -ri  --include="*.js" --exclude-dir={tmp,log,vendor,node_modules} hood * 


grep -ri  --include="*.yaml" --exclude-dir={tmp,log,vendor,node_modules} mail * 




grep -ri  --include="*.js"  --exclude="openNote.bundle.js" --exclude-dir={tmp,log,vendor,node_modules,data,} functionality * 

grep -ri  --include="*.html"  --exclude="openNote.bundle.js" --exclude-dir={tmp,log,vendor,node_modules,data,} searchontable * 


eg:
grep -rli --exclude-dir={proc,boot,root,sys} hello /

grep -r --exclude-dir={node_modules,.git,boot,root,sys} data *



grep -v exclude with multiple patterns, strings.
    grep 'test' somefile | grep -vE '(error|critical|warning)'

    
Excluding multiple patterns with one grep command..
  grep -v -e 90.192.142.138 -e PIX -e Intrusion cisco.log-20151103.log
https://unix.stackexchange.com/questions/240470/excluding-multiple-patterns-with-one-grep-command

  https://stackoverflow.com/questions/16212656/grep-exclude-multiple-strings
  grep -Fv -e 'Sync.Cache' -e 'seafile-data'


  
grep -rin --color=always  rail2 .  |    grep -vi -e deploy -e tmp -e .git -e log -e /offline -e readme -e docs -e mtime -e offlin
 
grep -ir --include="*.rb" path

grep -ir --include="*.txt" variab .
grep -ir --include="*.sql" variab .
 grep -ir --include="*.sql" -l declare .

 grep -ir --include="*.sql" -l set.*@ .
 grep -ir --include="*.sh"  most_columns_2excel *
 grep -ir --include="*.ini"  datagrid *
 
 
 grep -ir --include={"Make*",*.txt} development .
 grep -ir rail.*development .
 
 grep -ir --include="*.sql" -l declare .

 grep -ir --include="*.sql" -l set.*@ .
 
 
 
 grep -ir --include="*.rb" whodunn .
 
 
 grep -ir --include="*.rb" paper_tr .
 
 grep -ir  --include={*.sh,*.sql} 'import-enterprise2.sh'
 

 # match product or products

 
  grep -ri --include="*.sh" -E 'product(s|\s)'  *



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



>52. grep with find exclude paths..



##seperator....

dts=$(date +"%Y-%m-%d_%H.%M.%S"); seq 1 45 | xargs -I{} date ;     \
  docker-compose build  \
   ;  seq 1 5 | xargs -I{} date ;  echo Started__ $dts \_\_ -=-=-=-=-=-=-=-=-=-=-=-

_____________



# works..
#
# grep files in . folder excluding strings.. 
#
# list files..
find .  -type f -print > /tmp/filelist1
# exclude these strings using grep..
cat /tmp/filelist1 | grep -v  \
    -e 'public/admin/js/' \
    -e 'public/admin/css/'  \
    -e '/vendor/'  \
    -e 'schema.sql'  \
    -e 'adminer.php' > /tmp/filelist
cat /tmp/filelist
# grep list of files shown in the file
while read filename; do     grep -Hin --color    "book"  \
   "$filename"; done < /tmp/filelist




_____________


# works..  but see last one..

# grep found files which exclude the list of folders and excluded files....
#
# exclude folder list..  Folders below this list will be excluded. you have to exclude the files in the first level below..
exclude_file=/tmp/exclfile
echo -e "public/admin/js/*" > "$exclude_file"
echo -e "public/admin/css/*" >> "$exclude_file"
echo -e "vendor/*" >> "$exclude_file"
echo -e "xxmigrations/*" >> "$exclude_file"
cat "$exclude_file"
#
#print the files to search..
find . -type d \( $(printf -- "-path */%s -o " $(cat "$exclude_file")) -false \) -prune    -o -type f -print > /tmp/filelist1
# exclude these strings using grep..
cat /tmp/filelist1 | grep -v  \
-e 'public/admin/js/' \
-e 'public/admin/css/'  \
-e '/vendor/'  \
-e 'schema.sql'  \
-e 'adminer.php' > /tmp/filelist
cat /tmp/filelist
#grep list of files shown in the file
while read filename; do grep -Hin --color "book" "$filename"; done < /tmp/filelist



_____________

_____________

# didn't work.. 

# (cat "$exclude_file") -exec  grep --exclude={s*.sql,adminer.php} --color -Hn "book" {} 2>/dev/null \;

# won't exclude files in excluded folder... find . -type d \( $(printf -- "-path */%s -o " $(cat "$exclude_file")) -false \) -prune    -o -type f -print
# no works...  find . -type d \( $(printf -- "-path */%s -o " $(cat "$exclude_file")) -false \) -prune  $(printf -- "! -name %s " $(cat "$exclude_file"))  -o -type f -print
# files..  $(printf "! -name %s " $(cat skip_files))

# not used..  grep.. 
find . -type d \( $(printf -- "-path */%s -o " $(cat "$exclude_file")) -false \) -prune -o -type f  -exec  grep --exclude={s*.sql,adminer.php} --color -Hn "book" {} 2>/dev/null \;





~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>61.

 
Find *.txt file but ignore hidden .txt file such as .vimrc or .data.txt file:

$ find . -type f \( -iname "*.txt" ! -iname ".*" \)



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


>71. GREP grep >>




# find crea*.rb containing v and w 
  find .  -iname *crea*\.rb | grep v |grep w
 
find -iname "*\.rb" | grep -i  create

grep -ri 6L_output /var/www/html/django/trakberry 

 grep -ri collection .|grep html |grep -v sql |grep 1ror |grep -v workspace
 grep -ri select .|grep html |grep -v sql |grep 1ror |grep -v workspace

 grep -ri commit .|grep sh|grep git|grep -v sql|grep 27
 _____________
 
 
grep '@example'  -ria  --exclude-dir={tmp,bin,shared,log,nbproject,.git} --exclude={*.sublime-workspace,*.geany,error_log,*.sqlit*}

  >~/0/gout.txt

grep 'devise'  -ria  --exclude-dir={tmp,bin,shared,log,nbproject,.git} --exclude={*.sublime-workspace,*.geany,error_log}

grep 'before_filter'  -ria  --exclude-dir={tmp,bin,shared,log,nbproject} --exclude={*.sublime-workspace,*.geany,error_log}

grep 'tempera'  -ria  --exclude-dir={tmp,bin,shared,log,nbproject} --exclude={*.sublime-workspace,*.geany,error_log}

grep 'DROP Procedure'  -ria  --exclude-dir={tmp,bin,shared,log,nbproject} --exclude={*.sublime-workspace,*.geany,error_log}



grep 'mcmaster'  -ria  --exclude-dir={tmp,bin,shared,log,nbproject,templates_c,backup,test,test2} --exclude={*.sublime-workspace,*.geany,error_log,*.sql,*.msg} .

grep 'coderre'  -ria --include={*.php,}  --exclude-dir={tmp,bin,shared,log,nbproject,templates_c,backup,test,test2} --exclude={*.sublime-workspace,*.geany,error_log,*.msg,___check.these___,*.sql,java*.*,JAVA*.*,*.csv,*.CSV,*.txt} .


grep 'mysql'  -ria   --exclude-dir={tmp,bin,shared,log,nbproject,templates_c,backup,test,test2,docs,docsbr} --exclude={*.sublime-workspace,*.geany,error_log,*.msg,___check.these___,*.sql,java*.*,JAVA*.*,*.csv,*.CSV,*.txt} .

grep -ri lib.templates.erb.scaffold.


grep 'segeren'  -ria --include={*.php,*.txt} --exclude-dir={tmp,bin,shared,log,nbproject,templates_c,backup,test,test2} --exclude={*.sublime-workspace,*.geany,error_log,*.sql,*.msg}  . 


grep 'vw_reportemails.*array.*reportname'  -ria --include={*.php,*.txt} --exclude-dir={tmp,bin,shared,log,nbproject,templates_c,backup,test,test2} --exclude={*.sublime-workspace,*.geany,error_log,*.sql,*.msg}  . 

./shiftcsd1/actions/ncl_send_email.php:        $el = df_get_records_array('vw_reportemails', array('reportname'=>'=CSD1_Shift_Reports__NCL_Rpt',
./truenorth/actions/team_leader_send_email.php:        $el = df_get_records_array('vw_reportemails', array('reportname'=>'=true_north_reports__team_leader_rpt',
./shiftcsd1sup/actions/superv1_send_email.php: 

password.
al123

cd /var/www/html
cd /srv/
grep 'dgleba'  -ria --include={*.php,*.rb,*.yml,*.txt,*.ini,*.py,*.con*,*.dbc,*.sh,*.t} \
     --exclude-dir={tmp,bin,shared,log,nbproject,templates_c,backup,test,test2,datatest,data,xdatax1,xdata1-offline,.git} \
     --exclude={*.sublime-workspace,*.geany,error_log,*.sql,*.msg,*.sqlite,*.log}  . |sort -n   \
     >~/pas123-723-c.txt

grep 'password'  -ria --include={*.php,*.rb,*.yml,*.txt,*.ini,*.py,*.con*,*.dbc} --exclude-dir={tmp,bin,shared,log,nbproject,templates_c,backup,test,test2} --exclude={*.sublime-workspace,*.geany,error_log,*.sql,*.msg}  . | sort -n >~/paspas.txt


# trakberry
grep 'main_log'  -ria --include={*.php,*.rb,*.yml,*.txt,*.ini,*.py,*.con*,*.dbc,*.htm*} --exclude-dir={tmp,bin,shared,log,nbproject,templates_c,backup,test,test2} --exclude={*.sublime-workspace,*.geany,error_log,*.sql,*.msg}  . | sort -n 


grep 'ude pun'  -ria  --exclude-dir=tmp

grep nt.sqlite3 -ria

grep cif207 -B1 -C1 -r -i -a /etc/apache2

=
sudo find .  -name *.rb | grep _path

sudo find .  -name *themerc* 

=
list lines that end in a  az-09 charater
cat /home/dg/tmp/ij,2009-01-26-1233001792 |grep '[a-zA-Z0-9]'$





= 



>81. find..



>.find

sudo find / -mount -name *phpMyAdmin*

find /mnt/GLEBAD7/c/d  -name *who*.xls
doesnt work on mail.com: gotmail -u glebadavid@iname.com -p ashley -d mail.com -f gleba@sympatico.ca

find /etc -name *version*  ; what distribution of linux am I running?
head /etc/*version*  ; what distribution/version of linux am I running?
and/or
head /etc/*release*  ; what distribution/version of linux am I running?
find /etc -name *version*  ;  head /etc/*version*  ; head /etc/*release*  ;
another: cat /proc/version

find / -type f -iname '????\.??' | xargs grep -i 'word' /dev/null ,  will do a case insensitive file match for all files with 4 chars followed by a literal '.' followed by 2 chars then do a case insensitive search for 'word' on those files. Adding /dev/null below so that grep outputs the filename(s) it found the pattern match in.  Without it, grep will only print out the line containing the match.

find / -mount -name konqueror
find /mydata/mnt/GLEBAD7/c/d  -name *who*.xls

find /amn/redet/c/d/1/  -iname *nuvex*
find /mnt/hdb2/b2/bkjr -iname *.dat*
find /amn/reddq/c/d/  -iname *dnote*  |grep we
find /amn/glebad7/c/  -iname *pcw*
find /amn/glebad7/c/d/  -iname *grub* |grep cd





>91. grep..



>.grep

grep "nuvexp" -B1 -C1 -r -i -a /amn/redet/c/d/1/linuxcommand/1
grep "du" -B3 -C3 -r -i -a /amn/redet/c/d/1/linuxcommand/1

grep "ftp" -B3 -C3 -r -i -a /amn/redet/c/d/1/linuxcommand/1

grep "klik" -B0 -C0 -r -i -a /amn/glebad7/c/d/1/0favorites
grep "rani" -B0 -C0 -r -i -a /amn/glebad8/m/3/a*.txt
grep "pcoc" -B3 -C3 -r -i -a /amn/glebad7/c/d/d |grep -B4 -C4 -i xp
grep -B3 -C3 -r 'depend' /opt/kde/share/doc/HTML/en/kpackage
grep -a = binary files are like text.
grep "nmbd" -B0 -C0 -r -i /etc

=

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2017-06-13[Jun-Tue]20-19PM


>101. grep..



_____________


>111. # find folders with this file..


# Just show lines matching, no name.
find . -type f -name "database.yml" | xargs grep ENV
 
# Just show names matching.. 
find . -iname 'database.yml' -type f -exec grep -l ENV '{}' \; 



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2018-01-02[Jan-Tue]11-45AM

>131.

exclude the two lines that have this part_no..

grep -v  '795907' /srv/file/argostat/datatest/in/3/imp_argo_tosql_3_2018.01.01_22.34.02.txt >  imp_argo_tosql_3_2018.01.01_22.34.02-reworked-dg.txt

grep -va --text  '795907' /srv/file/argostat/datatest/in/3/imp_argo_tosql_3_2018.01.01_22.34.02.txt >  imp_argo_tosql_3_2018.01.01_22.34.02-reworked-dg.txt


split --bytes=260M /srv/file/argostat/datatest/in/3/imp_argo_tosql_3_2018.01.01_22.34.02-reworked-dg.txt  split_imp_argo_tosql_3_2018.01.01__


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>132.

list files recursively by size..

du -ah . | grep -v "/$" | sort -rh > ~/t1.txt

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2018-03-02[Mar-Fri]15-45PM


was141 see183

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2017-07-14[Jul-Fri]23-39PM


>151.     find folders named...




# works..
  fnd='*djangoproj*' ; f1=/tmp/findtmp ; sudo find . -type d -not \( -name tmp -prune \) ! \( -name node_modules -prune \) \
    -iname "$fnd" >"$f1"; echo .;  echo '==== OUTPUT -- FOLDERS LIKE.. ' "$fnd"; cat "$f1" | sort 

# -not - ! means  not i think.
 
# works without root...

  fnd='*djangoproj*' ; f1=/tmp/findtmp ;  find . -type d -not \( -name tmp -prune \) ! \( -name node_modules -prune \) \
    -iname "$fnd" >"$f1"; echo .;  echo '==== OUTPUT -- FOLDERS LIKE.. ' "$fnd"; cat "$f1" | sort 


# works..
  fnd='*brail*' ; f1=/tmp/findtmp ; sudo find . -type d -not \( -name tmp -prune \)  -iname "$fnd" >"$f1"; echo .;  echo '==== OUTPUT -- FOLDERS LIKE.. ' "$fnd"; cat "$f1" | sort 

  
  
  
fnd='data' ; f1=/tmp/findtmp ; sudo find . -type d -not \( -name tmp -prune \) -iname "$fnd" >"$f1"; echo .;  echo '==== OUTPUT -- FOLDERS LIKE.. ' "$fnd"; cat "$f1" | sort 



fnd='*tutori*' ; f1=/tmp/findtmp ; sudo find . -type d -not \( -name tmp -prune \) -iname "$fnd" >"$f1"; echo .; echo '==== OUTPUT -- FOLDERS LIKE.. ' "$fnd"; cat "$f1" | sort 




find . -maxdepth 2 -type d -name lpa34*

find . -type d -name .git -exec dirname {} \;



find .  \( ! -name tmp -prune \) -o \( ! -name root -prune \)  -name "*.pl" -print

no..
find .  \( ! -name tmp -prune \)   -name lpa346 -print


yes..
find . -type d -not \( -name tmp -prune \) -iname lpa346
find . -type d -not \( -name tmp -prune \) -iname lpa346

cd /srv
find . -type d -not \( -name tmp -prune \) -iname 'hrap*'

works..
f1=/tmp/findtmp ; find . -type d -not \( -name tmp -prune \) -iname 'lpa*' >"$f1" ; echo OUTPUT............. ; cat "$f1" | grep -v 'denied'



Excluding multiple patterns with one grep command..
  grep -v -e 90.192.142.138 -e PIX -e Intrusion cisco.log-20151103.log
https://unix.stackexchange.com/questions/240470/excluding-multiple-patterns-with-one-grep-command

  
# Look for tmp as well....  
fnd='*tmp*' ; f1=/tmp/findtmp ; sudo find . -type d -not \( -name txxmp -prune \) -iname "$fnd" >"$f1"; echo .;  echo '==== OUTPUT -- FOLDERS LIKE.. ' "$fnd"; cat "$f1" | sort 

  
 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2018-06-10[Jun-Sun]20-25PM



>171.


from rsnap21.sh



show all files on the system / root folder changed in the last 60 mintues.

This shows you what to restore to put the system back to the way it was earlier.


# list files  --  last 1 hour modified  -- very good and fast.


  export num_minutes=11 ; datef='%.19y \t%.19z \t%A \t%U \t%G \t%s \t%n\n'  ;  mkdir -p $HOME/historybackup ; date1=$(date +"__%Y.%m.%d_%H.%M.%S") ; echo $date1 
  
  cd / ; sudo find  .   -path './sys' -prune -o  -path './proc' -prune -o  -path './run' -prune -o -path './rsnapshot' -prune -o  -mmin -$num_minutes  -type f -print0 | xargs -0 stat --printf="${datef}"  | sort -n | grep -vE '(.git/|tmp/|lxcfs/cgroup)' 2>&1 | tee  $HOME/historybackup/find21_$date1.txt
  
  echo -e '#\n#\n#\n######## ----------------------  Created...\n#\n#\n'   >>$HOME/historybackup/find21_$date1.txt
  cd / ; sudo find  .   -path './sys' -prune -o  -path './proc' -prune -o  -path './run' -prune -o -path './rsnapshot' -prune -o  -cmin -$num_minutes  -type f -print0 | xargs -0 stat --printf="${datef}"  | sort -n | grep -vE '(.git/|tmp/|lxcfs/cgroup)' 2>&1 | tee -a $HOME/historybackup/find21_$date1.txt
  #
  echo -e '#\n#\n#\n########       Sorted by Name   ----------------------  \n#\n#\n'   >>$HOME/historybackup/find21_$date1.txt
  #
  cd / ; sudo find  .   -path './sys' -prune -o  -path './proc' -prune -o  -path './run' -prune -o -path './rsnapshot' -prune -o  -mmin -$num_minutes  -type f -print0 | xargs -0 stat --printf="${datef}"  | sort -n | grep -vE '(.git/|tmp/|lxcfs/cgroup)' 2>&1 | tee  -a $HOME/historybackup/find21_$date1.txt
  
  echo -e '#\n#\n#\n######## ----------------------  Created...\n#\n#\n'   >>$HOME/historybackup/find21_$date1.txt
  cd / ; sudo find  .   -path './sys' -prune -o  -path './proc' -prune -o  -path './run' -prune -o -path './rsnapshot' -prune -o  -cmin -$num_minutes  -type f -print0 | xargs -0 stat --printf="${datef}"  | sort -n | grep -vE '(.git/|tmp/|lxcfs/cgroup)' 2>&1 | tee -a $HOME/historybackup/find21_$date1.txt
  

  
  
  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



>181.  locate..


# good..
# dirs too, newest last:  need at least 3 character search or it will take a long time....
locate -0   ockerfile-app | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $1" "  $8" "'} | grep -vE '(.git/|tmp/|lxcfs/cgroup|wrecked|cache|node_modules)' | sort -n  


locate -0   brail | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $1" "  $8" "'} | grep -vE '(.git/|tmp/|lxcfs/cgroup|wrecked|cache|node_modules)' | sort -n  



>~/0/lcout2.txt



only files..

locate -b0 drail246 | xargs -r0 ls -aldtr

dirs too..
locate -0 brail | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $8" "'} | grep -v '.git/' | grep -v tmp/ | sort -n  >~/0/lcout.txt
#awk only cols 6,7,8



# find all 237 grep mfile..  show all 237 [projects and just show the Gemfile]
locate -0   237    | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $1" "  $8" "'} | grep -v '.git/' | grep -v tmp/ | sort -n  |grep mfile

#noworks..
locate -0   237  | grep mfile  | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $1" "  $8" "'} | grep -v '.git/' | grep -v tmp/ | sort -n  

works..
locate -0r   237.*mfile    | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $1" "  $8" "'} | grep -v '.git/' | grep -v tmp/ | sort -n  

locate -0r   mfile    | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $1" "  $8" "'} | grep -v '.git/' | grep -v tmp/ | sort -n  

locate and list newest files last...

locate -0r  actions.ini   | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $1" "  $8" "'} | grep -v '.git/' | grep -v tmp/ | sort -n  

locate -0   256    | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $1" "  $8" "'} | grep -v '.git/' | grep -v tmp/ | sort -n  

# too long...
locate -0   *   | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $1" "  $8" "'} | grep -v '.git/' | grep -v tmp/ | sort -n  

# 4 lines below  > >  look in 3 folders, list newest last...
sudo updatedb
ls
locate -0  /home/albe/web  | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $1" "  $8" "'} | grep -v '.git/' | grep -v tmp/ | sort -n  >~/0/lcout99.txt
locate -0  /home/albe/share203  | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $1" "  $8" "'} | grep -v '.git/' | grep -v tmp/ | sort -n  >>~/0/lcout99.txt
locate -0  /srv        | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $1" "  $8" "'} | grep -v '.git/' | grep -v tmp/ | sort -n >>~/0/lcout99.txt
locate -0  /var/www    | xargs -r0 ls -ald --time-style=long-iso |  awk {'print $6" " $7" " $1" "  $8" "'} | grep -v '.git/' | grep -v tmp/ | sort -n  >>~/0/lcout99.txt
cat ~/0/lcout99.txt | sort -n | tail -n722 | grep  249


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


>182.

see also >141

locate-to-search-for-  folders-only  - exact full folder name match..

https://superuser.com/questions/408060/how-to-use-locate-to-search-for-folders-only
Actually, locate has what it takes if you use the --regexp option and you dont mind it spitting out files that have the same name as the directories you seek. The "end of line" position marker gets the job done:
locate also supports --ignore-case

locate --ignore-case -r '/bashrail$'



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>183. was>141.


see also >151 and >182...


locate folders named brail*

not worky. it works in regexer.com

locate -r "/brail(.){0,9}$/mg"

no worky..

locate -r 'brail' | grep "brail(.){0,9}$"


#look for this app every dir except /web/ 

    locate -r 'hrapp361'  | grep -v -e '/tmp' -e '/.git'  -e '/test' -e '/app' -e '/spec' -e '/web'
    
    locate -r 'hrapp361'  | grep -v -e '/tmp' -e '.git'  -e '/test' -e '/app' -e '/spec'             -e '/public'

    locate -r 'brail' | grep "brail(.){0,9}$"

    
    locate -r 'brail347'  | grep -v -e '/tmp' -e '/.git'  -e '/test' -e '/app' -e '/spec' -e '/web'
    locate -r 'brail347'  | grep -v -e '/tmp' -e '/.git'  -e '/test' -e '/app' -e '/spec'

  
https://stackoverflow.com/questions/4742357/how-to-match-only-strings-that-do-not-contain-a-dot-using-regular-expressions

^[^.]*$



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>191
>191 find with perms,user,group,mtime,size



find . -exec stat --printf="%A %U %G %y %s \t %n\n" {} \; 2>/dev/null | awk -v OFS='\t' '{ print  $1, $2, $3, $4, $5, $6, $7, $8 }'

find . -exec stat --printf="%A %U %G %y %s \t %n\n" {} \; 2>/dev/null




the next one's didn't work out...
no..
$7, $8, $9
find . -exec stat --printf="%A %U %G %y %s %n\0" {} \; 2>/dev/null | awk -v OFS='\t' '{ print  $1, $2, $3, $4, $5, $6, $7, $8 ; print " " }'

find . -exec stat --printf="%A %U %G %y %s %n\0" {} \; 2>/dev/null | awk -v OFS='\t' '{ print $0, $1, $2, $3, $4, $5, $6, $7 }'

find . -exec stat --printf="%A %U %G %y %s %n\0" {} \; 2>/dev/null | awk -v OFS='\t' '{ print $0, $1, $2, $3, $4, $5, $6 }'

find . -printf '%A@ %u %g %Tm %Td %TY %Tk:%TM %8s %p\n' 2>/dev/null


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


















~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






Scratch..
Scratch..
Scratch..
Scratch..
Scratch..
Scratch..



find  /c/crib -mtime -32123  -print0 | xargs -0 stat --printf='%.16y %A %h %U\t%G\t%s\t%n\n' | sort -n > finddir.txt
 
 
 
 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  find images on drive dock.
#@  
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   2023-04-01[Apr-Sat]08-56AM 



Find files less than 1 day old -mtime -1 
      or -mmin -1000 =  less than 1000 minutes old.
        or since:  -newermt "2023-03-31 16:00:56"

date;
  cd /media/albe/vi641-002/mcdata/mc_6365_vision_1;
  cd /media/albe/vi641-002/mcdata/mc_6365_vision_2/image_data;
  find . -mtime -1 -type f -print0 | xargs -0 stat --printf='%.16y\t%s\t%n\n'  | sort -h -k1 | grep outer.*png$ | wc -l ;
date;

## >~/out.txt


  find . -newermt "2023-03-31 12:00:56"  -type f -print0 | xargs -0 stat --printf='%.16y\t%s\t%n\n'  | sort -h -k1 | grep outer.*png$ ;
  find . -newermt "2023-03-08 16:00:56"  -type f -print0 | xargs -0 stat --printf='%.16y\t%s\t%n\n'  | sort -h -k1 | grep xml$ ;
  find . -newermt "2023-03-29 14:00:06"  -type f -print0 | xargs -0 stat --printf='%.16y\t%s\t%n\n'  | sort -h -k1 | grep xml$ ;


  find . -mmin -1100 -type f -print0 | xargs -0 stat --printf='%.16y\t%s\t%n\n'  | sort -h -k1 | grep outer.*png$ ;




=================================================
=================================================

