#!/usr/bin/bash

# This installs useful programs we tend to use often. Anything more complicated
# than a few apt or snap packages should have its own script. Simpler things
# can live here.

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $SCRIPT_DIR/color_utils.sh
source $SCRIPT_DIR/error_trap_utils.sh

echo -e "\n\n${BLUE}Installing SSL vision server.${NC}"

sudo apt install -y terminator

sudo snap install code --classic

echo -e "${GREEN}SSL vision server installation complete.${NC}"
