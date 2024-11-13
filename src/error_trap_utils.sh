#!/usr/bin/bash

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $SCRIPT_DIR/color_utils.sh

handle_error() {
  echo -e "${RED}COMMAND FAILED: $1:$2, exit code $2${NC}"
  exit 1
}
trap 'handle_error `basename "$0"` $LINENO $?' ERR
