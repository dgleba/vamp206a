#!/usr/bin/env bash
cd
# echo off
set +vx
# echo on
set -vx
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function offline()
{
exit 999
# begin block comment =============================
: <<'END'

search..



http://askubuntu.com/questions/208030/search-for-files-with-gui



END
# end block comment ===============================
}
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

find new files

find . -type f | xargs stat --format '%Y :%y %n' | sort -nr | cut -d: -f2- | head

or

stat --printf="%y %n\n" $(ls -tr $(find * -type f))


_____________

http://superuser.com/questions/597321/how-to-display-file-details-size-date-etc-from-linux-locate-command
Use xargs. This takes as input a series of parameters, and carries out an operation on them:
 locate -eb0P somefile | xargs -r0 ls -ald
xargs will carry out the ls -ald command using the results of the locate as parameters.
The -e switch tells locate to check that files found in the database really exist, and ignore any which don't.
The -b switch tells locate to match just basenames.
The -0 (zero) switch tells locate to generate null delimiters instead of blanks (so it can handle file names which contain blanks)
The -P switch tells locate to list broken symlinks
The -r switch tells xargs to not carry out the command if nothing is passed in - ie when the locate returns nothing.
The -0 switch tells xargs to expect nulls instead of blanks as delimiters
The -a switch tells ls to list even files that begin with "."
The -d switch tells ls to list directories rather than their contents
ls  -tr = t- sort by date decending
==
--this has mismatched columns and it doesn't sort properly. it has multiple sections starting at older dates in each.
dirs too..
locate -0 drail246 | xargs -r0 ls -aldtr | grep -v '.git/' | grep -v tmp/    > ~/lcout2
locate -0 drail246 | xargs -r0 ls -aldtr   > ~/lcout2
locate -0 drail246     > ~/lcout2

_____________






