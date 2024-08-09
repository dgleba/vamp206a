#!/usr/bin/env bash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set -x
cd
source shc/21env.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function nowebfiles() 
{
#if you want to proceed with no web data, run this...
cd
touch tmp01/htdocs.PMDS-DATA.latest.7z
mkdir -p tmp01/htdocs
#
}

nowebfiles

#
