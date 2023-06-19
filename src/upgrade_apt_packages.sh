#!/usr/bin/bash

source color_utils.sh
source error_trap_utils.sh

echo -e "\n\n${BLUE}Updating all apt packages.${NC}"

sudo apt update
sudo apt upgrade

echo -e "${GREEN}Apt upgarde complete.${NC}"