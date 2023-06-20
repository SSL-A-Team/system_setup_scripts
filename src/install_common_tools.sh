#!/usr/bin/bash

# This installs useful programs we tend to use often. Anything more complicated
# than a few apt or snap packages should have its own script. Simpler things
# can live here.

source color_utils.sh
source error_trap_utils.sh

echo -e "\n\n${BLUE}Installing SSL vision server.${NC}"

sudo apt install -y terminator

sudo snap install code

echo -e "${GREEN}SSL vision server installation complete.${NC}"
