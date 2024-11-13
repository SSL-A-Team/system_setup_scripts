#!/usr/bin/bash

# Installs SSL league vision server software.

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $SCRIPT_DIR/color_utils.sh
source $SCRIPT_DIR/error_trap_utils.sh

echo -e "\n\n${BLUE}Installing SSL vision server.${NC}"

if [ -d ssl-vision ]; then
    rm -rf ssl-vision
fi
git clone https://github.com/RoboCup-SSL/ssl-vision.git

pushd ssl-vision
./InstallPackagesUbuntu.sh
cmake -B build -DUSE_SPINNAKER=true
make
popd

# TODO install desktop shortcut?

echo -e "${GREEN}SSL vision server installation complete.${NC}"
