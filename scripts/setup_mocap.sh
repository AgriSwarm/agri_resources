#!/bin/bash

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: mocap <server_ip>"
    exit 1
fi

SERVER_IP=$1
CLIENT_IP=$(hostname -I | awk '{print $1}')

COMMON_SETUP="
source \${HOME}/.bashrc
source ~/.bash_profil
"

LAUNCH_CMD="
$COMMON_SETUP
roslaunch agri_resources natnet_ros.launch serverIP:=${SERVER_IP} clientIP:=${CLIENT_IP}
"

gnome-terminal -- bash -c "$LAUNCH_CMD; exec bash"