#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: network <WiFi_Name>"
    exit 1
fi

WIFI_NAME="$1"

# Disable autoconnect for all WiFi connections
for conn in $(nmcli -t -f NAME,TYPE connection show | grep ':wifi$' | cut -d':' -f1); do
    nmcli connection modify "$conn" connection.autoconnect no
done

# Enable autoconnect for the specified WiFi
nmcli connection modify "$WIFI_NAME" connection.autoconnect yes

# Get the IP address
IP_ADDRESS=$(nmcli -g ipv4.addresses connection show "$WIFI_NAME" | cut -d'/' -f1)

if [ -z "$IP_ADDRESS" ]; then
    echo "Failed to get IP address for $WIFI_NAME"
    exit 1
fi

# Update .bash_profile
sed -i "s/export ROS_IP=.*/export ROS_IP=$IP_ADDRESS/" ~/.bash_profile

echo "Network switched to $WIFI_NAME"
echo "ROS_IP updated to $IP_ADDRESS"

# Reconnect to the specified network
nmcli connection up "$WIFI_NAME"

# Source the updated .bash_profile
source ~/.bash_profile