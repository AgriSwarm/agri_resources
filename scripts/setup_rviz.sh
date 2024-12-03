#!/bin/bash

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: rviz <master_ip>"
    exit 1
fi

MASTER_IP=$1

# Update .bash_profile
sed -i "s/export ROS_IP=.*/export ROS_IP=$(hostname -I | awk '{print $1}')/" ~/.bash_profile
sed -i "s|export ROS_MASTER_URI=.*|export ROS_MASTER_URI='http://${MASTER_IP}:11311/'|" ~/.bash_profile

COMMON_SETUP="
source ~/.bash_profile
"

# TERMINAL1_CMD="
# $COMMON_SETUP
# roslaunch agri_resources rviz.launch
# "
roslaunch agri_resources rviz.launch &

TERMINAL2_CMD="
$COMMON_SETUP
rosrun hardware_utils cmd_cli.py
"

# TERMINAL3_CMD="
# $COMMON_SETUP
# rosrun rqt_reconfigure rqt_reconfigure
# "
rosrun rqt_reconfigure rqt_reconfigure &

simplescreenrecorder &

# gnome-terminal -- bash -c "$TERMINAL1_CMD; exec bash" &
# gnome-terminal -- bash -c "$TERMINAL3_CMD; exec bash" &
gnome-terminal -- bash -c "$TERMINAL2_CMD; exec bash"