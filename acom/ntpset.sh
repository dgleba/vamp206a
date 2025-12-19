#!/usr/bin/env bash

# purpose: point at ntp server

CONFIG_FILE="/etc/systemd/timesyncd.conf"
cat $CONFIG_FILE
NTP_SERVER="rose.jehl.internal"
NTP_fSERVER="ntp.ubuntu.com"

# Backup the original config file
sudo cp -p "$CONFIG_FILE" "$CONFIG_FILE.$(date +%Y%m%d_%H%M%S)"

# Uncomment or add the NTP= line with the desired server
if grep -q "^#NTP=" "$CONFIG_FILE" || grep -q "^NTP=" "$CONFIG_FILE"; then
    sudo sed -i "s|^#\?NTP=.*|NTP=$NTP_SERVER|" "$CONFIG_FILE"
else
    echo "NTP=$NTP_SERVER" | sudo tee -a "$CONFIG_FILE"
fi

# Uncomment or add the FallbackNTP= line with the desired server
if grep -q "^#\?FallbackNTP=" "$CONFIG_FILE"; then
    sudo sed -i "s|^#\?FallbackNTP=.*|FallbackNTP=$NTP_fSERVER|" "$CONFIG_FILE"
else
    echo "FallbackNTP=$NTP_fSERVER" | sudo tee -a "$CONFIG_FILE"
fi

# Restart the timesyncd service
sudo systemctl restart systemd-timesyncd

cat $CONFIG_FILE

echo "*"
echo "NTP server set to $NTP_SERVER and systemd-timesyncd restarted."
echo "*"

# Show the last 20 log entries for systemd-timesyncd
journalctl -u systemd-timesyncd.service -n 60
