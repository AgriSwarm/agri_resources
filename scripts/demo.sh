#!/bin/bash

TERMINAL2_CMD="
rosrun hardware_utils cmd_cli.py
"

TERMINAL4_CMD="
roslaunch agri_resources demo.launch
"

gnome-terminal -- bash -c "$TERMINAL2_CMD; exec bash" &
gnome-terminal -- bash -c "$TERMINAL4_CMD; exec bash"