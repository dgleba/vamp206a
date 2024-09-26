cat << 'EOF' | tee /tmp/a.sh > /dev/null

#!/bin/bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
#
# change ssh port
#
#

# usage:    ssh -p 22462 user@hostname


file1=/etc/ssh/sshd_config
sudo cp $file1 $file1$(date +"__%Y.%m.%d_%H.%M.%S").bak.txt     # do you need sudo cp?
 

# Use sed to change the port and uncomment the line if needed
# sudo sed -i '/^#\?Port/s/^#\?Port.*/Port 46212/' /etc/ssh/sshd_config
# sudo sed -i '1iPort 22462' /etc/ssh/sshd_config
sed -i -E 's/^#?Port.*/Port 22462/' /etc/ssh/sshd_config

# cat /etc/ssh/sshd_config
#    sudo nano /etc/ssh/sshd_config


# Show lines with port..
grep -i "^port" /etc/ssh/sshd_config
# Count lines with port
grep -ic "^port" /etc/ssh/sshd_config


# ------------

# Verify the config file and count the number of Port lines


# Step 2: Count only uncommented Port lines (case-insensitive)
port_count=$(grep -iEc "^Port" /etc/ssh/sshd_config)
echo $port_count

# Step 3: Check the count of uncommented Port lines
if [ "$port_count" -gt 1 ]; then
    # Print a large red error message if more than one uncommented Port line is found
    echo -e "\e[31mERROR: More than one uncommented Port directive found in /etc/ssh/sshd_config!\e[0m"
elif [ "$port_count" -eq 1 ]; then
    # Print a success message if exactly one uncommented Port line is found
    echo -e "\e[32mSUCCESS: Only Port directive is found.\e[0m"
else
    # Print an error message if no uncommented Port lines are found
    echo -e "\e[31mERROR: No uncommented Port directive found in /etc/ssh/sshd_config!\e[0m"
fi

# sudo systemctl restart sshd

EOF

sudo bash /tmp/a.sh
