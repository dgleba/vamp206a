# usage: cd to within the folder you want compressed.  open this file in a text editor. Copy all of it to clipboard. paste it into a bash terminal command prompt.
#
# bash to find files in current folder excluding archives, /sysdata, /log, and /tmp. 
# then tar gzip them into a file named with the current folder and the timestamp in the name.
mkdir -p $HOME/bin
f=$HOME/bin/tarcg
tee $f <<- 'HEREDOC'

#!/bin/bash

# Get the current folder name
current_folder=$(basename "$PWD")
curfolder=${PWD##*/}
fnpath="${PWD////_}" 
echo  hostname=$HOSTNAME fnpath=$fnpath   current_folder=$current_folder :: curfolder=$curfolder

# Set the output filename with the current folder and timestamp
# output_filename="${current_folder}_$(date +%Y-%m-%d_%s).tar.gz"
timestamp=$(date +"%Y-%m-%d_%H.%M.%S")
output_filename="${HOSTNAME}${fnpath}_${timestamp}.tgz"

# Find files in the current folder excluding archives, /sysdata, /log, and /tmp, etc.
find . -type f      \
    ! -name "*.tar.gz" ! -name "*.tgz"  ! -name "*.zip" \
    ! -path "*/sysdata/*"  ! -path "*/tmp/*" ! -path "*/zip/*"  ! -path "*/x/*"  \
    ! -path "*/log/*" ! -path "*/logs/*"   \
    ! -path "*/djangosite/static/*"   \
    ! -path "*/datasys/*"   \
    ! -path "*/node_modules/*"   \
    ! -path "*_pic/*"   \
    ! -path "*/upload/images/*"   \
    ! -path "*/stacks/data/*"   \
    ! -path "*/argostat/data/*"   \
    ! -path "*/etldb/*"   \
    ! -path "*/file/tsf/*"   \
    ! -path "*/data/crib/*"   \
    ! -path "*/datatest/*"   \
    ! -path "*/logoutput/*"   \
    ! -path "*/db/uploads/*"   \
    ! -path "*/nc/uploads/*"   \
    ! -path "*/djangosite/upload/*"   \
    ! -path "./test/*"   \
  -print0 | \
  tar --null -czvf "$output_filename" --files-from -


echo -e "\n Files archived as $output_filename"

HEREDOC
bash $f
