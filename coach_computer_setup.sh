#!/usr/bin/bash

# This script sets up everything we expect to have on the coach computer. It is
# intended to run on a machine with a fresh install of Ubuntu. It will install
# all dependencies and clone and build our software repo.

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source src/color_utils.sh

# Make sure we're in the user's home directory
cd $HOME

source $SCRIPT_DIR/src/enable_sudo_actions.sh

source $SCRIPT_DIR/src/error_trap_utils.sh

#
# Configuration steps
#
$SCRIPT_DIR/src/upgrade_apt_packages.sh
$SCRIPT_DIR/src/install_common_tools.sh
$SCRIPT_DIR/src/install_league_docker_images.sh
$SCRIPT_DIR/src/install_ssl_quality_inspector.sh
$SCRIPT_DIR/src/setup_software_repo.sh
$SCRIPT_DIR/src/setup_firmware_repo.sh
$SCRIPT_DIR/src/add_ros_to_bash_profile.sh

echo -e "\n\n${GREEN}System configuration complete!${NC}"
exit 0
