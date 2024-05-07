#!/usr/bin/env bash

cd
# echo off
set +vx
# echo on
set -vx

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#update trakberry

cd /var/www/html/django/trakberry
git pull origin master
# or just 
git pull
service apache2 reload


# if getting error: error: Your local changes to the following files would be overwritten by merge: ...  Please, commit your changes or stash them before you can merge.
git stash save --keep-index
#If you don't need them anymore, you now can drop that stash:
git stash drop


#http://stackoverflow.com/questions/15166722/use-own-username-password-with-git-and-bitbucket
#dclark@pmdsdata3:/var/www/html/django/trakberry$ git remote -v
#origin  https://dgleba@bitbucket.org/dgleba/trakberry.git (fetch)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function offline()
{
exit 999

# begin block comment =============================
: <<'END'

#get repo..
cd /var/www/html
git clone https://github.com/dgleba/ciy207.git
composer install
git pull origin master
# not this, use next line... composer global require "fxp/composer-asset-plugin:1.0.0"
composer global require "fxp/composer-asset-plugin"
#sudo chmod g+x /var/www/html/ciy207/yii
composer --prefer-dist install

#error:
#PHP Fatal error:  Call to undefined method Fxp\Composer\AssetPlugin\Package\Version\VersionParser::parseLinks() in /home/albe/.composer/vendor/fxp/composer-asset-plugin/Repository/VcsPackageFilter.php on line 272
#soln: composer global require "fxp/composer-asset-plugin"


END
# end block comment ===============================

}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
date
#

