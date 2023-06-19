# A-Team System Setup Scripts
Scripts for automating computer setup for shared computers used by the A-Team RoboCup Small Size League team.

Entrypoint scripts are in the repo top level directory. Helper scripts live in the src directory.

These tools are intended to be run on blank Ubuntu installations. No guarrantees are made about what will happen if you run the script after it has already been run on a system.

These tools are not necessarily the easiest way to set up a developer machine. Assumptions are made about where resources will be placed for repeatable environments. Our individual repos likely have more direct and flexible developer setup instructions and tools.

## How to setup the Coach Computer
Run these commands:
```bash
git clone git@github.com:SSL-A-Team/system_setup_scripts.git
./coach_computer_setup.sh
```

## How to setup the Vision Server Computer
Run these commands:
```bash
git clone git@github.com:SSL-A-Team/system_setup_scripts.git
./vision_computer_setup.sh
```
