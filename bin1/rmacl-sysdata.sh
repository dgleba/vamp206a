#!/usr/bin/env bash

#################################################################
#@  
#@  
#@  
####################################   2026-01-22[Jan-Thu]12-09PM 


set -euo pipefail

timestamp() {
    date +"%Y-%m-%d_%H-%M-%S"
}

RUNLOG="sysdata_acl_fix_$(timestamp)"
mkdir -p "$RUNLOG"

echo "Run log directory: $RUNLOG"

# Find all directories named sysdata (case-sensitive)
mapfile -t SYSDATA_DIRS < <(find . -type d -name sysdata)

if [[ ${#SYSDATA_DIRS[@]} -eq 0 ]]; then
    echo "No sysdata directories found."
    exit 0
fi

for DIR in "${SYSDATA_DIRS[@]}"; do
    CLEAN_NAME="${DIR//\//_}"
    LOGDIR="$RUNLOG/$CLEAN_NAME"
    mkdir -p "$LOGDIR"

    echo "Processing: $DIR"
    echo "Logs: $LOGDIR"

    # 1. Log current ACLs (no sudo needed)
    getfacl -R "$DIR" >> "$LOGDIR/01_acls_before.txt"
    # 1b. Log ownership (no sudo needed)
    find "$DIR" -printf "%M %u %g %p\n" >> "$LOGDIR/01b_ownership.txt"
    ls -la "$DIR" >>"$LOGDIR/01c_ll-ownership.txt"

	# 1d. Log ownership WITH ACL plus sign
	find "$DIR" -printf "%M %u %g %p\n" | while read -r mode user group path; do
		if getfacl -c "$path" | grep -qE '^(user:|group:|mask:|other:).*:'; then
			echo "${mode}+ ${user} ${group} ${path}"
		else
			echo "${mode}  ${user} ${group} ${path}"
		fi
	done > "$LOGDIR/01d_ownership.txt"



    # 2. Strip ACLs (requires sudo)
     sudo setfacl -R -b "$DIR"
     sudo setfacl -R -k "$DIR" 2>/dev/null || true

    # 3. Log ownership (no sudo needed)
    find "$DIR" -printf "%M %u %g %p\n" >> "$LOGDIR/02_ownership-after.txt"

# 3b. Log ownership WITH ACL plus sign
find "$DIR" -printf "%M %u %g %p\n" | while read -r mode user group path; do
    if getfacl -c "$path" | grep -qE '^(user:[^:]+:|group:[^:]+:|mask:|default:)'; then
        echo "${mode}+ ${user} ${group} ${path}"
    else
        echo "${mode}  ${user} ${group} ${path}"
    fi
done > "$LOGDIR/03b_ownership-after.txt"

    # 4. Log modes (no sudo needed)
    find "$DIR" -printf "%M %p\n" >> "$LOGDIR/03_modes-after.txt"

    # 5. Verify ACL removal (no sudo needed)
    getfacl -R "$DIR" >> "$LOGDIR/04_acls_after.txt"

    grep -vE '^(#|user::|group::|other::)' \
        "$LOGDIR/04_acls_after.txt" \
        >> "$LOGDIR/04_acls_after_filtered.txt" || true

    # 6. Remove default ACL inheritance (requires sudo)
    sudo find "$DIR" -type d -exec setfacl -d -b {} \; 2>/dev/null || true

    echo "Completed: $DIR"
done

echo "All sysdata directories processed."
echo "Full logs in: $RUNLOG"
