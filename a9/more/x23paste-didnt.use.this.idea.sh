# paste this into terminal to make .env.sh and then edit the password in the created file.

cd
mkdir safe


tee ./safe/.env.sh <<- 'EOF'
#!/usr/bin/env bash
date ; set -vx  ; set +vx ; # echo on, then echo off
echo ~----------~----------Startinga `dirname "$0"`/`basename "$0"` $HOSTNAME, pwd: `pwd`, "$0", "${BASH_SOURCE[0]}", $(date +"%Y-%m-%d_%H.%M.%S") "from file.... ${BASH_SOURCE[0]}"
echo "full bash source array: ${BASH_SOURCE[@]}"  # echo full bashsource array
# ---------------------------------------------------

# - after getting a new shell


# User settings: run these with every new shell.
#
# Start Step 1
#



# password for user:


# after creating this file, edit the real password here.
export pw27=edityourpasswordhere








# save user to avoid any change user root is substituted:
export userv=$USER
# or
# just set it explictly..
# export userv=albe
export hpath=/home/$userv
echo $userv, $hpath

umask 002 # make group writable.

timeout1=5 > /dev/null 2>&1; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..."  || true   
# End Step 1

# ---------------------------------------------------

EOF
chmod +x ~/safe/.env.sh;

