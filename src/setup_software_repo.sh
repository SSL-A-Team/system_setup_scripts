#!/usr/bin/bash

# Clone and configure our firmware repo

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $SCRIPT_DIR/color_utils.sh
source $SCRIPT_DIR/error_trap_utils.sh

echo -e "\n\n${BLUE}Setting up software repo.${NC}"

#
# Install ROS
#
# Based on https://docs.ros.org/en/jazzy/Installation/Ubuntu-Install-Debians.html
sudo apt install software-properties-common
sudo add-apt-repository -y universe
sudo apt update && sudo apt install -y curl
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
sudo apt install -y ros-dev-tools ros-jazzy-desktop

#
# Clone repository
#
mkdir -p ateam_ws/src
pushd ateam_ws/src
if [ -d software ]; then
    rm -rf software
fi
git clone --recursive git@github.com:SSL-A-Team/software.git
popd

#
# Install repo dependencies
#
source /opt/ros/jazzy/setup.bash
if [ -f /etc/ros/rosdep/sources.list.d/20-default.list ]; then
    sudo rm /etc/ros/rosdep/sources.list.d/20-default.list
fi
sudo rosdep init
rosdep update
rosdep install --from-paths . --ignore-src -y
pushd ateam_ws
./src/software/ateam_ui/install_deps.sh
popd

#
# Build & test repository
#

pushd ateam_ws
ROS_LOCALHOST_ONLY=1
colcon build
colcon test
# Added this skip option because XML linting tests were failing, but only in the context of this script.
# Might be an environment issue in the script.
if ! colcon test-result --verbose; then
    read -p "Software tests failed. Continue anyway? (y/N)" RESPONSE
    if [ "$RESPONSE" != "${RESPONSE#[Yy]}" ]; then
        echo "Ignoring test failures."
    else
        echo "${RED}Stopping due to test failure.${NC}"
        exit 1
    fi
fi
popd

echo -e "${GREEN}Software repo setup complete.${NC}"
