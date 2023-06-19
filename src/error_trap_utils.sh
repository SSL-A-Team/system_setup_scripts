#!/usr/bin/bash

source color_utils.sh

handle_error() {
  echo -e "${RED}SYSTEM CONFIGURATION FAILED: line $1, exit code $2${NC}"
  exit 1
}
trap 'handle_error $LINENO $?' ERR
