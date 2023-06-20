#!/usr/bin/bash

# Clone and configure our firmware repo

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $SCRIPT_DIR/color_utils.sh
source $SCRIPT_DIR/error_trap_utils.sh

echo -e "\n\n${BLUE}Setting up firmware repo.${NC}"

#
# Clone repository
#
git clone --recursive git@github.com:SSL-A-Team/firmware.git

#
# Run repo setup script 
#
pushd firmware
source util/linux_setup.sh
popd

echo -e "${GREEN}Firmware repo setup complete.${NC}"
