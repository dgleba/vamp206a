#!/bin/bash

# http://unix.stackexchange.com/questions/231313/batch-timeout-alternative

# mkdir -p bin in home folder, put this in that folder. Debian adds home bin to the path.
# usage: timeout1.sh s   -  where s is seconds to wait.
# eg:    timeout1.sh 12



IFS=_
count=0
count="$1"
echo -e " \n"
while [ $count -ge 1 ]
do
    echo -e -n "\r  Hit a key to continue...  $count      "
    read -n 1 -s -t 1 myresponse
    if [ "$myresponse" ]
    then
        echo -e -n "\n  You entered:  $myresponse\n\n"
        break
    fi
    ((count--))
done
if [ $count -eq 0 ]
then
    echo -e  "\n  You did not enter anything, continuing...\n"
fi

