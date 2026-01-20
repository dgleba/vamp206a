#!/usr/bin/env bash
set -euo pipefail

OUTPUT="out.txt"
BASE="/ap"

# Start fresh
: > "$OUTPUT"

# Find MySQL datadirs under any sysdata directory, excluding tmp/ test/ and /620/
find "$BASE" \
    \( -path "*/tmp"  -o -path "*/tmp/*"    -o -path "*/test" -o -path "*/test/*" \
       -o -path "*/620*"  -o -path "*/620*/*"    -o -path "*/m-etabase-oldies/*"   -o -path "*/x/*" \)    -prune \
    -o -type d \( -name mysqldata* -o -name mysql_data*  -o -name maria \)    -print \
| while read -r dir; do
    echo "===== $dir =====" >> "$OUTPUT"
    getfacl "$dir" >> "$OUTPUT"
    echo >> "$OUTPUT"
done


echo "ACL listing complete: $OUTPUT"


#################################################################


notes () {


# Find MySQL datadirs under any sysdata directory
find "$BASE" -type d \( -name mysqldata -o -name mysql_data \) | while read -r dir; do
    echo "===== $dir =====" >> "$OUTPUT"
    getfacl "$dir" >> "$OUTPUT"
    echo >> "$OUTPUT"
done


}