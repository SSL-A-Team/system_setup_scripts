#!/usr/bin/bash

# This script sets up everything we expect to have on the vision server. It is
# intended to run on a machine with a fresh install of Ubuntu. It will install
# all dependencies and clone and build our software repo.

SRC_SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/src

source $SRC_SCRIPT_DIR/color_utils.sh

# Make sure we're in the user's home directory
cd $HOME

source $SRC_SCRIPT_DIR/enable_sudo_actions.sh

source $SRC_SCRIPT_DIR/error_trap_utils.sh

#
# Configuration steps
#
$SRC_SCRIPT_DIR/upgrade_apt_packages.sh
$SRC_SCRIPT_DIR/install_league_docker_images.sh
$SRC_SCRIPT_DIR/install_ssl_quality_inspector.sh
$SRC_SCRIPT_DIR/install_ssl_vision_server.sh

echo -e "\n\n${GREEN}System configuration complete!${NC}"
exit 0