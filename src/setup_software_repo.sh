#!/usr/bin/bash

# Clone and configure our firmware repo

source color_utils.sh
source error_trap_utils.sh

echo -e "\n\n${BLUE}Setting up software repo.${NC}"

#
# Install ROS
#
# Based on https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install -y curl
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
sudo apt install -y ros-humble-desktop

#
# Clone repository
#
mkdir -p ateam_ws/src
pushd ateam_ws/src
git clone --recursive git@github.com:SSL-A-Team/software.git
popd

#
# Install repo dependencies
#
source /opt/ros/humble/setup.bash
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
colcon build
colcon test
colcon test-result --verbose
popd

echo -e "${GREEN}Software repo setup complete.${NC}"
