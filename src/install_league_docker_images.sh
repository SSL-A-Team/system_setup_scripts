#!/usr/bin/bash

# Installs SSL league software via docker.

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $SCRIPT_DIR/color_utils.sh
source $SCRIPT_DIR/error_trap_utils.sh

echo -e "\n\n${BLUE}Installing league docker images.${NC}"

#
# Install docker
#
# Have to use docker.io distribution to be compatible with our rosdep dependency
sudo apt-get install -y docker.io

#
# Pull league docker images
#
sudo docker pull robocupssl/ssl-game-controller
sudo docker pull robocupssl/ssl-status-board
sudo docker pull robocupssl/ssl-remote-control
sudo docker pull robocupssl/ssl-vision-client
sudo docker pull robocupssl/grsim

#
# Add user to docker group for sudo-less commands
#
# Note: only takes effect after logging out and back in
getent group docker || sudo groupadd docker
sudo usermod -aG docker $USER

echo -e "${GREEN}League docker image installation complete.${NC}"
