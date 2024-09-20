#!/bin/bash

# Function to list WiFi profiles
list_wifi_profiles() {
    echo "Available WiFi profiles:"
    nmcli -t -f NAME,TYPE connection show | grep ':802-11-wireless$' | cut -d':' -f1
}

# If no argument is provided, list WiFi profiles and exit
if [ $# -eq 0 ]; then
    list_wifi_profiles
    exit 0
fi

WIFI_NAME="$1"

# Check if the specified WiFi profile exists
if ! nmcli connection show "$WIFI_NAME" &> /dev/null; then
    echo "Error: unknown connection '$WIFI_NAME'."
    list_wifi_profiles
    exit 1
fi

# Disable autoconnect for all WiFi connections
for conn in $(nmcli -t -f NAME,TYPE connection show | grep ':802-11-wireless$' | cut -d':' -f1); do
    sudo nmcli connection modify "$conn" connection.autoconnect no
done

# Enable autoconnect for the specified WiFi
sudo nmcli connection modify "$WIFI_NAME" connection.autoconnect yes

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
sudo nmcli connection up "$WIFI_NAME"

# Source the updated .bash_profile
source ~/.bash_profile