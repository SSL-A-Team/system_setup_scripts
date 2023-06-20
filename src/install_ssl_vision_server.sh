#!/usr/bin/bash

# Installs SSL league vision server software.

source color_utils.sh
source error_trap_utils.sh

echo -e "\n\n${BLUE}Installing SSL vision server.${NC}"

git clone https://github.com/RoboCup-SSL/ssl-vision.git

pushd ssl-vision
./InstallPackagesUbuntu.sh
cmake -B build #-DUSE_?=true TODO which backend are we using?
make
popd

# TODO install desktop shortcut?

echo -e "${GREEN}SSL vision server installation complete.${NC}"
