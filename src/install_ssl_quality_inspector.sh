#!/usr/bin/bash

# Installs SSL league software via docker.

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $SCRIPT_DIR/color_utils.sh
source $SCRIPT_DIR/error_trap_utils.sh

echo -e "\n\n${BLUE}Installing SSL quality inspector.${NC}"

#
# Install go
#
sudo apt install -y golang-go

#
# Clone
#
if [ -d ssl-quality-inspector ]; then
    rm -rf ssl-quality-inspector
fi
git clone https://github.com/RoboCup-SSL/ssl-quality-inspector.git

#
# Build
#
pushd ssl-quality-inspector
make install
popd

echo -e "${GREEN}SSL quality inspector installation complete.${NC}"
