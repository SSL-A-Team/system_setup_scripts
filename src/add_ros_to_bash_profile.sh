#!/usr/bin/bash

# Installs SSL league software via docker.

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $SCRIPT_DIR/color_utils.sh
source $SCRIPT_DIR/error_trap_utils.sh

echo -e "\n\n${BLUE}Adding ROS to bash profile.${NC}"

BASH_PROFILE_FILE=$HOME/.bashrc

# Make file if it doesn't already exist
if [ ! -f "$BASH_PROFILE_FILE" ]; then
  touch "$BASH_PROFILE_FILE"
fi

# Add ROS environment source commands if they don't already exist

ROS_UNDERLAY_CMD="source /opt/ros/humble/setup.bash"
if ! grep -q "$ROS_UNDERLAY_CMD" "$BASH_PROFILE_FILE"; then
  echo "$ROS_UNDERLAY_CMD" >> "$BASH_PROFILE_FILE"
fi

ROS_OVERLAY_CMD="source $HOME/ateam_ws/install/setup.bash"
if ! grep -q "$ROS_OVERLAY_CMD" "$BASH_PROFILE_FILE"; then
  echo "$ROS_OVERLAY_CMD" >> "$BASH_PROFILE_FILE"
fi

echo -e "${GREEN}Bash profile setup complete.${NC}"
