#!/usr/bin/bash

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $SCRIPT_DIR/color_utils.sh
source $SCRIPT_DIR/error_trap_utils.sh

echo -e "\n\n${BLUE}Updating all apt packages.${NC}"

sudo apt update
sudo apt upgrade -y

echo -e "${GREEN}Apt upgarde complete.${NC}"