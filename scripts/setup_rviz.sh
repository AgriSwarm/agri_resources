#!/bin/bash

COMMON_SETUP="
source \${HOME}/.bashrc
export ROS_IP=10.0.0.226
export ROS_MASTER_URI='http://10.0.0.1:11311/'
"

TERMINAL1_CMD="
$COMMON_SETUP
roslaunch agri_resources rviz.launch
"

TERMINAL2_CMD="
$COMMON_SETUP
rosrun hardware_utils cmd_cli.py
"

TERMINAL3_CMD="
$COMMON_SETUP
rosrun rqt_reconfigure rqt_reconfigure
"

gnome-terminal -- bash -c "$TERMINAL1_CMD; exec bash" &
gnome-terminal -- bash -c "$TERMINAL2_CMD; exec bash" &
gnome-terminal -- bash -c "$TERMINAL3_CMD; exec bash" &