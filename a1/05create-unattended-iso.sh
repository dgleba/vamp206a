#!/usr/bin/env bash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#David Gleba 2015-10-01_Thu_12.11-PM using vamp198e
#
# I sync ntmp with vagrant..
mkdir -p /var/varvamp/files  # destination folder to store the final iso file
ntmp="/var/varvamp/files"    # destination folder to store the final iso file


# 2016-05-09 added date string to hostname. not yet tested.
nhostname="vamp206b"
hnow=$(date +"%Y%m%d%k%M%S")

# also consider https://github.com/ryanwalder/ubuntu-unattended

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# define spinner function for slow tasks
# courtesy of http://fitnr.com/showing-a-bash-spinner.html
spinner()
{
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# define download function
# courtesy of http://fitnr.com/showing-file-download-progress-using-wget.html
download()
{
    local url=$1
    echo -n "    "
    wget --progress=dot $url 2>&1 | grep --line-buffered "%" | \
        sed -u -e "s,\.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
    echo -ne "\b\b\b\b"
    echo " DONE"
}

# define function to check if program is installed
# courtesy of https://gist.github.com/JamieMason/4761049
function program_is_installed {
    # set to 1 initially
    local return_=1
    # set to 0 if not found
    type $1 >/dev/null 2>&1 || { local return_=0; }
    # return value
    echo $return_
}

# print a pretty header
echo
echo " +---------------------------------------------------+"
echo " |            UNATTENDED UBUNTU ISO MAKER            |"
echo " +---------------------------------------------------+"
echo

mkdir -p $ntmp
mkdir -p $ntmp/iso_org
mkdir -p $ntmp/iso_new


# ask whether to include vmware tools or not
while true; do
    echo " which ubuntu edition would you like to remaster:"
    echo
    echo "  [1] Ubuntu 12.04.4 LTS Server amd64 - Precise Pangolin"
    echo "  [2] Ubuntu 14.04.3 LTS Server amd64 - Trusty Tahr"
    echo
    read -p " please enter your preference: [1|2]: " ubver
    case $ubver in
        [1]* )  download_file="ubuntu-12.04.4-server-amd64.iso"           # filename of the iso to be downloaded
                download_location="http://releases.ubuntu.com/12.04/"     # location of the file to be downloaded
                new_iso_name="ubuntu-12.04.4-server-amd64-unattended.iso" # filename of the new iso file to be created
                break;;
        [2]* )  download_file="ubuntu-14.04.3-server-amd64.iso"             # filename of the iso to be downloaded
                #David Gleba edited.
                download_location="http://mirror.pnl.gov/releases/14.04.3/"     # location of the file to be downloaded
                new_iso_name="ubuntu-14.04.3-server-amd64-unattended.iso"   # filename of the new iso file to be created
                break;;
        * ) echo " please answer [1] or [2]";;
    esac
done

# ask the user questions about his/her preferences
read -ep " please enter your preferred timezone: " -i "America/Detroit" timezone
read -ep " please enter your preferred username: " -i "albe" username
read -sp " please enter your preferred password: " password
printf "\n"
read -sp " confirm your preferred password: " password2
printf "\n"

# check if the passwords match to prevent headaches
if [[ "$password" != "$password2" ]]; then
    echo " your passwords do not match; please restart the script and try again"
    echo
    exit
fi

# download the ubunto iso
cd $ntmp
if [[ ! -f $ntmp/$download_file ]]; then
    echo -n " downloading $download_file: "
    download "$download_location$download_file"
fi

# download netson seed file
seed_file="netson.seed"
rm $ntmp/$seed_file
if [[ ! -f $ntmp/$seed_file ]]; then
    echo -h " downloading $seed_file: "
    #download "https://github.com/dgleba/vamp206a/blob/master/netson.seed"
    #download "https://github.com/netson/ubuntu-unattended/raw/master/$seed_file"
    #download "https://raw.githubusercontent.com/dgleba/vamp206a/master/$seed_file"
    download "https://github.com/dgleba/vamp206a/raw/master/$seed_file"
fi

# install required packages
echo " installing required packages"
if [ $(program_is_installed "mkpasswd") -eq 0 ] || [ $(program_is_installed "mkisofs") -eq 0 ]; then
    (apt-get -y update > /dev/null 2>&1) &
    spinner $!
    (apt-get -y install whois genisoimage > /dev/null 2>&1) &
    spinner $!
fi

# create working folders
echo " remastering your iso file"

# mount the image
if grep -qs $ntmp/iso_org /proc/mounts ; then
    echo " image is already mounted, continue"
else
    (mount -o loop $ntmp/$download_file $ntmp/iso_org > /dev/null 2>&1)
fi

# copy the iso contents to the working directory
(cp -rT $ntmp/iso_org $ntmp/iso_new > /dev/null 2>&1) &
spinner $!

# set the language for the installation menu
cd $ntmp/iso_new
echo en > $ntmp/iso_new/isolinux/lang

# set late command
#http://serverfault.com/questions/560150/how-to-include-additional-software-in-preseed-cfg-for-ubuntu-server-13-10
late_command="chroot /target wget -N -O /home/$username/11get.sh https://github.com/dgleba/vamp206a/raw/master/11get.sh ;\
    chroot /target chmod +x /home/$username/11get.sh ; "

# copy the netson seed file to the iso
cp -rT $ntmp/$seed_file $ntmp/iso_new/preseed/$seed_file

# include firstrun script
echo "
# setup firstrun script
d-i preseed/late_command                                    string      $late_command" >> $ntmp/iso_new/preseed/$seed_file

# generate the password hash
pwhash=$(echo $password | mkpasswd -s -m sha-512)

# update the seed file to reflect the users' choices
# the normal separator for sed is /, but both the password and the timezone may contain it
# so instead, I am using @
sed -i "s@{{username}}@$username@g" $ntmp/iso_new/preseed/$seed_file
sed -i "s@{{pwhash}}@$pwhash@g" $ntmp/iso_new/preseed/$seed_file
sed -i "s@{{hostname}}@$nhostname$hnow@g" $ntmp/iso_new/preseed/$seed_file
sed -i "s@{{timezone}}@$timezone@g" $ntmp/iso_new/preseed/$seed_file

#change grub timeout 
sed -i "s@timeout 0@timeout 210@g" $ntmp/iso_new/isolinux/isolinux.cfg

# calculate checksum for seed file
seed_checksum=$(md5sum $ntmp/iso_new/preseed/$seed_file)

# add the autoinstall option to the menu
sed -i "/label install/ilabel autoinstall\n\
  menu label ^Autoinstall NETSON Ubuntu Server\n\
  kernel /install/vmlinuz\n\
  append file=/cdrom/preseed/ubuntu-server.seed initrd=/install/initrd.gz auto=true priority=high preseed/file=/cdrom/preseed/netson.seed preseed/file/checksum=$seed_checksum --" $ntmp/iso_new/isolinux/txt.cfg

echo " creating the remastered iso"
cd $ntmp/iso_new
(mkisofs -D -r -V "NETSON_UBUNTU" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o $ntmp/$new_iso_name . > /dev/null 2>&1) &
spinner $!

# cleanup
umount $ntmp/iso_org
rm -rf $ntmp/iso_new
rm -rf $ntmp/iso_org

# print info to user
echo " -----"
echo " finished remastering your ubuntu iso file"
echo " the new file is located at: $ntmp/$new_iso_name"
echo " your username is: $username"
echo " your password is: $password"
echo " your nhostname is: $nhostname"
echo " your timezone is: $timezone"
echo

# unset vars
unset username
unset password
unset nhostname
unset timezone
unset pwhash
unset download_file
unset download_location
unset new_iso_name
unset ntmp
unset seed_file
