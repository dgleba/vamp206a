# usage: cd to within the folder you want compressed.  open this file in a text editor. Copy all of it to clipboard. paste it into a bash terminal command prompt.
#
# bash to find files in current folder excluding archives, /sysdata, /log, and /tmp. 
# then tar gzip them into a file named with the current folder and the timestamp in the name.
mkdir -p $HOME/bin
f=/$HOME/bin/tarcgs
tee $f <<- 'HEREDOC'
#!/bin/bash

# Get the current folder name
current_folder=$(basename "$PWD")
curfolder=${PWD##*/}
fnpath="${PWD////_}" 
echo  hostname=$HOSTNAME fnpath=$fnpath   current_folder=$current_folder :: curfolder=$curfolder
tfile=/tmp/tmpfilefindtar23234recnt-size.txt; 

# Set the output filename with the current folder and timestamp
# output_filename="${current_folder}_$(date +%Y-%m-%d_%s).tar.gz"
timestamp=$(date +"%Y-%m-%d_%H.%M.%S")
output_filename="${HOSTNAME}${fnpath}_sizrecent_${timestamp}.tgz"

# Find files in the current folder excluding archives, /sysdata, /log, and /tmp, etc.
find . -type f   -size -290k   -mtime -120    \
    ! -name "*.tar.gz" ! -name "*.tgz"  ! -name "*.zip" \
    ! -path "*/sysdata/*" ! -path "*/log/*" ! -path "*/tmp/*" ! -path "*/zip/*"  ! -path "*/x/*"  \
    ! -path "*/djangosite/static/*"   \
    ! -path "*/datasys/*"   \
    ! -path "*/node_modules/*"   \
  -print0 > $tfile
  tar --null -czvf "$output_filename" -T $tfile
  #tar --null -czvf "$output_filename" --files-from -


echo -e "\n Files archived as $output_filename"
HEREDOC
bash $f
