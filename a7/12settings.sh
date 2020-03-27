# ---------------------------------------------------

# - after getting a new shell


# User settings: run these with every new shell.
#
# Start Step 1
#

export pw1=a

export userv=$USER
# or
# just set it explictly..
# export userv=albe
export hpath=/home/$userv
echo $userv, $hpath
umask 002 # make group writable.
timeout1=15 > /dev/null 2>&1; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..."  || true   
# End Step 1

# ---------------------------------------------------

