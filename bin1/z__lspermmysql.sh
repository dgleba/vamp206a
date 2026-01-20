#!/usr/bin/env bash

#################################################################
#@  
#@  using `mysqldata` folder nameing for search
#@  
####################################   2026-01-20[Jan-Tue]10-23AM 



set -euo pipefail

OUTPUT="mysql_acl_report.csv"

# CSV header
echo "directory,permissions,owner,group,acl_present" > "$OUTPUT"

# Find mysql data, excluding x/ and test/ and some more..
find . \
  -type d   \( -path "*/sysdata/mysqldata*" -o -path "*/sysdata/mysql_data*" \) \
  -not -path "*/x/*" \
  -not -path "*/test/*" \
  -not -path "*/tmp/*" \
  -not -path "*/m-etabase-oldies/*"  \
| while read -r dir; do


    # Basic stat info
    perms=$(stat -c "%a" "$dir")
    owner=$(stat -c "%U" "$dir")
    group=$(stat -c "%G" "$dir")

    # Detect whether ACLs exist
    if getfacl "$dir" 2>/dev/null | grep -q "default:"; then
        acl="yes"
    else
        acl="no"
    fi

    # Output CSV row
    echo "\"$dir\",$perms,$owner,$group,$acl" >> "$OUTPUT"
done

echo "CSV report written to $OUTPUT"


notes () {

find "$BASE" \
    \( -path "*/tmp"  -o -path "*/tmp/*"    -o -path "*/test" -o -path "*/test/*" \
       -o -path "*/620*"  -o -path "*/620*/*"    -o -path "*/m-etabase-oldies/*"   -o -path "*/x/*" \)    -prune \
    -o -type d \( -name mysqldata* -o -name mysql_data*  -o -name maria \)    -print \


}
