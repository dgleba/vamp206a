#!/usr/bin/env bash

#################################################################
#@  
#@  ibdata based - output csv
#@  
####################################   2026-01-20[Jan-Tue]10-22AM 

set -euo pipefail


#!/usr/bin/env bash

csv="ibdata1_report.csv"

# CSV header
printf "path,permissions,links,owner,group,size,month,day,time_or_year\n" > "$csv"

find . -type d \
    -not -path "*/x/*" \
    -not -path "*/test/*" \
    -not -path "*/tmp/*" \
    -not -path "*/m-etabase-oldies/*" \
| while read -r dir; do
    file="$dir/ibdata1"
    if [ -e "$file" ]; then
        # Extract ls fields deterministically
        set -- $(ls -ld "$file")
        perms=$1
        links=$2
        owner=$3
        group=$4
        size=$5
        month=$6
        day=$7
        time_or_year=$8

        # Terminal output
        printf "%s %s %s %s %s %s %s %s %s\n" \
            "$file" "$perms" "$links" "$owner" "$group" "$size" "$month" "$day" "$time_or_year"

        # CSV output
        printf "%s,%s,%s,%s,%s,%s,%s,%s,%s\n" \
            "$file" "$perms" "$links" "$owner" "$group" "$size" "$month" "$day" "$time_or_year" \
            >> "$csv"
    fi
done
echo;echo "Printed to csv - ibdata1_report.csv";echo;




#################################################################


notes () {



# CSV header
printf "path,permissions,links,owner,group,size,month,day,time_or_year\n"

find . -type d \
    -not -path "*/x/*" \
    -not -path "*/test/*" \
    -not -path "*/tmp/*" \
    -not -path "*/m-etabase-oldies/*" \
| while read -r dir; do
    file="$dir/ibdata1"
    if [ -e "$file" ]; then
        # Extract ls fields deterministically
        set -- $(ls -ld "$file")
        perms=$1
        links=$2
        owner=$3
        group=$4
        size=$5
        month=$6
        day=$7
        time_or_year=$8

        # Emit CSV row
        printf "%s,%s,%s,%s,%s,%s,%s,%s,%s\n" \
            "$file" "$perms" "$links" "$owner" "$group" "$size" "$month" "$day" "$time_or_year"
    fi
done




# Find mysqldata or mysql_data directories and inspect ibdata1
find . -type d  \
	  -not -path "*/x/*" \
	  -not -path "*/test/*" \
	  -not -path "*/tmp/*" \
	  -not -path "*/m-etabase-oldies/*"  \
	| while read -r dir; do
    file="$dir/ibdata1"
    if [ -e "$file" ]; then
        #echo "===== $file ====="
        ls -l "$file"
        #getfacl "$file"
        #echo
	fi
done

------------



find . \
  -type d   \( -path "*/sysdata/mysqldata*" -o -path "*/sysdata/mysql_data*" \) \
  -not -path "*/x/*" \
  -not -path "*/test/*" \
  -not -path "*/tmp/*" \
  -not -path "*/m-etabase-oldies/*"  \
  #| while read -r dir; do


------------


find . -type d \( -path "*/sysdata/mysqldata" -o -path "*/sysdata/mysql_data" \) | while read -r dir; do
    file="$dir/ibdata1"
    if [ -e "$file" ]; then
        echo "===== $file ====="
        ls -l "$file"
        getfacl "$file"
        echo
    else
        echo "Skipping $dir (no ibdata1 found)"
        echo
    fi
done


}
