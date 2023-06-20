#!/usr/bin/bash

# Installs SSL league software via docker.

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $SCRIPT_DIR/color_utils.sh
source $SCRIPT_DIR/error_trap_utils.sh

echo -e "\n\n${BLUE}Installing league docker images.${NC}"

#
# Install docker
#
# Based on https://docs.docker.com/engine/install/ubuntu/
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#
# Pull league docker images
#
docker pull robocupssl/ssl-game-controller
docker pull robocupssl/ssl-status-board
docker pull robocupssl/ssl-remote-control
docker pull robocupssl/ssl-vision-client
docker pull robocupssl/grsim

echo -e "${GREEN}League docker image installation complete.${NC}"
