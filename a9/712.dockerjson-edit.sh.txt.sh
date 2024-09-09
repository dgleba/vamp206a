# =================================================
# 2024-03-15 worked on pmdm-apps-02
# by chatgpt
#
# =================================================


fil=/home/albe/bin/dockerjson.sh
tee  $fil <<- 'HEREDOC'

import json
import os

# Define the data to add
new_data = {
    "default-address-pools": [
        {"base": "172.80.0.0/16", "size": 24}
    ],
    "iptables": False  # Adding iptables: false
}

# Path to the daemon.json file
file_path = '/etc/docker/daemon.json'

# Check if the directory exists, if not, create it
directory = os.path.dirname(file_path)
if not os.path.exists(directory):
    os.makedirs(directory)

# Check if the file exists
if not os.path.exists(file_path):
    # If the file doesn't exist, create it with the new data
    with open(file_path, 'w') as file:
        json.dump(new_data, file, indent=4)
    print("Created daemon.json with default-address-pools configuration and iptables set to false.")
else:
    # If the file exists, load existing data, update it with new data, and write it back
    try:
        with open(file_path, 'r') as file:
            existing_data = json.load(file)
    except json.JSONDecodeError:
        existing_data = {}

    # Update existing data with the new data
    existing_data.update(new_data)

    # Write the updated data back to daemon.json
    with open(file_path, 'w') as file:
        json.dump(existing_data, file, indent=4)
    print("Updated daemon.json with default-address-pools configuration and iptables set to false.")

HEREDOC

echo file written.
echo    it will be printed in a few seconds...
sleep 2

cat $fil

# sudo python3 /home/albe/bin/dockerjson.sh
