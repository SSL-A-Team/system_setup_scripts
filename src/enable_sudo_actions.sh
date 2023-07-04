#!/usr/bin/bash

# Prompts user to enter sudo password so future commands don't have to prompt for it

echo "Please enter sudo password to enable sudo actions:"
sudo echo "sudo permissions enabled."
retval=$?
if [ $retval -ne 0 ]; then
  echo -e "${RED}Unable to secure sudo permissions. Aborting.${NC}"
  exit 1
fi