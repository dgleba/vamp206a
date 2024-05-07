#!/usr/bin/env bash

saynow()
{
# works.
date +"__%Y-%m-%d_%a_%k.%M.%S-%Z"   # %k has no leading zero not what I want...
date +"__%Y-%m-%d_%a_%H.%M.%S-%Z"   # %H has leading zero
date +"%Y-%m-%d_%H-%M-%S"
date +"%s"  # seconds since unix epoch
echo $(date +"__%Y-%m-%d_%a_%H.%M.%S-%Z")


#preferred format for backup of file with date...
date +"_%Y.%m.%d_%H.%M.%S.bak.txt"
mkdir -p ~/tmp01/tmp
cp  /etc/hosts  ~/tmp01/tmp/hosts$(date +"__%Y.%m.%d_%H.%M.%S").bak.txt

echo $(date +"%Y.%m.%d_%H.%M.%S")>>~/now.log.dg.txt

date1=$(date +"%Y.%m.%d_%H.%M.%S")
echo $date1



}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
offlinestuff()  
{
echo tmp1
exit 999
# begin block comment =============================
: <<'END'
ls
END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#main...

saynow
#

