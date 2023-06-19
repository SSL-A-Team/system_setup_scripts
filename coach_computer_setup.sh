#!/usr/bin/bash

# This script sets up everything we expect to have on the coach computer. It is
# intended to run on a machine with a fresh install of Ubuntu. It will install
# all dependencies and clone and build our software repo.

source src/color_utils.sh

# Make sure we're in the user's home directory
cd $HOME

source src/enable_sudo_actions.sh

source src/error_trap_utils.sh

#
# Update base OS packages
#
sudo apt update
sudo apt upgrade

#
# Configuration steps
#
./src/install_league_docker_images.sh
./src/install_ssl_quality_inspector.sh
./src/setup_software_repo.sh
./src/setup_firmware_repo.sh
./src/add_ros_to_bash_profile.sh

echo -e "\n\n${GREEN}System configuration complete!${NC}"
exit 0
