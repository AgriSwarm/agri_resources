#!/bin/bash

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: rviz <ros_master_ip> <mocap_server_ip>"
    exit 1
fi

MASTER_IP=$1
SERVER_IP=$2
CLIENT_IP=$(hostname -I | awk '{print $1}')

# Update .bash_profile
sed -i "s/export ROS_IP=.*/export ROS_IP=${CLIENT_IP}/" ~/.bash_profile
sed -i "s|export ROS_MASTER_URI=.*|export ROS_MASTER_URI='http://${MASTER_IP}:11311/'|" ~/.bash_profile

# Source .bash_profile to get the updated variables
source ~/.bash_profile

COMMON_SETUP="
source \${HOME}/.bashrc
source ~/.bash_profile
"

# Run rviz.launch in the background
roslaunch agri_resources rviz.launch &

# Run rqt_reconfigure in the background
rosrun rqt_reconfigure rqt_reconfigure &

TERMINAL2_CMD="
$COMMON_SETUP
rosrun hardware_utils cmd_cli.py
"

TERMINAL4_CMD="
$COMMON_SETUP
roslaunch agri_resources natnet_ros.launch serverIP:=${SERVER_IP} clientIP:=${CLIENT_IP}
"

gnome-terminal -- bash -c "$TERMINAL2_CMD; exec bash" &
gnome-terminal -- bash -c "$TERMINAL4_CMD; exec bash"