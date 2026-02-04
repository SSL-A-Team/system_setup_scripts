
# 3 Feb 2026 - Slitch

Install vim `apt install vim`
Install code via software center?
Install ifconfig `apt install net-tools`
Install discord via software center

Install git because ubuntu default pkgs are silly

Update Network configs to support PoE cameras:
    - Ubuntu network mgr -> IPv4 -> [x] Use this connection only for resources on its network

 
## Optional - Sam is a special snowflake and wants Caps<->Esc swapped

Install gnome-tweaks `sudo apt install gnome-tweaks`

- Gnome Tweaks->Additional Options->Make Caps Lock an Additional escape

Update VSCode vim to respect ubuntu remap:
- set `"keyboard.dispatch": "keyCode"`

## Back to getting scripts installed

Set up existing ssl github account, rcssl.ateam@gmail.com
    - Create new ssh key, etc

Clone system setup scripts
    `cd ~/ssh-field-computer && git clone git@github.com:SSL-A-Team/system_setup_scripts.git`

Start by just running vision computer setup script:
    `./vision_computer_setup.sh`
