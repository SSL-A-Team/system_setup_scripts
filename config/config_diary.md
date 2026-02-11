
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

# 10 Feb 2026 - Slitch

Continue pushing by just trying to get vision processor set up

Start again by just running setup script:
    `./vision_computer_setup.sh`

Predictably, failed on spinnaker install. Move on to getting spinnaker installed!

Started by pulling down tars from link provided by Teledyne:  https://teledyne.app.box.com/s/af3f8bpcovs8p76hatokv5vrzbn8aich
    - Currently stashing locally and manually installing.
    - [ ] TODO: Stash most up to date version available on private repo for submoduling/integration into setup scripts?
    - Interactive CURSES installer, so need to provide information via args or directly edit install scripts
    
Ran installer, rebooted, attempting to re-run vision computer setup

While that was building, setup network interfaces
- Assigned 6C:B3:11:03:3B:15 to 192.168.5.20/24
- Assigned 6C:B3:11:03:3B:14 to 192.168.4.20/24

Server installation completed!

Running vision-processor's setup script failed to auto install `nvidia-opencl-icd` due to version uncertainty, throwing the following
```
murdock@murdock-MS-7C56:~/vision-processor$ ./setup.sh 
 »  NVIDIA graphics card selected
 »  Debian based distribution
 »  Installing dependencies and OpenCL drivers
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Package nvidia-opencl-icd is a virtual package provided by:
  libnvidia-compute-590-server 590.48.01-0ubuntu0.24.04.1
  libnvidia-compute-590 590.48.01-0ubuntu0.24.04.1
  libnvidia-compute-580-server 580.126.09-0ubuntu0.24.04.1
  libnvidia-compute-580 580.126.09-0ubuntu0.24.04.1
  libnvidia-compute-570-server 570.211.01-0ubuntu0.24.04.1
  libnvidia-compute-570 570.211.01-0ubuntu0.24.04.1
  libnvidia-compute-565-server 565.57.01-0ubuntu0.24.04.3
  libnvidia-compute-535-server 535.288.01-0ubuntu0.24.04.2
  libnvidia-compute-535 535.288.01-0ubuntu0.24.04.1
  libnvidia-compute-470-server 470.256.02-0ubuntu0.24.04.1
  libnvidia-compute-470 470.256.02-0ubuntu0.24.04.1
You should explicitly select one to install.

E: Package 'nvidia-opencl-icd' has no installation candidate
```

Manually installing what appears to be the latest with `sudo apt install libnvidia-compute-590`

Nope, no dice. Apparently need to explicitly specify install in apt invocation, so trying to update line 39 of `vision-processor/setup.sh` script to reflect the following:
``` setup.sh:
if [[ $(< $dir/class) == 0x030000 ]]; then
    vendor=$(< $dir/vendor)
    if [[ $vendor == 0x10de ]]; then
        echo -e "\e[92m »  NVIDIA graphics card selected\e[39m"
        opencl_arch='opencl-nvidia nvidia-utils'
        # opencl_debian=nvidia-opencl-icd
        opencl_debian=libnvidia-compute-590
    elif [[ $vendor == 0x1002 ]]; then
...
```

Yup, that looks like it unstuck it. It appears to have built? Appears to have installed to a systemd service.

Time to dig in!

How do we get the system to identify cameras?

Easy thing worked! Looked for a spinnaker camera enumeration utility, found it installed in `/opt/spinnaker/bin/GigEConfig`. Running that program seemed like it found the cameras I was looking for:
```/opt/spinnaker/bin/GigEConfig output:

murdock@murdock-MS-7C56:/opt/spinnaker/bin$ ./GigEConfig 

*** FLIR GigE Config Utility ***

---> Listing all discoverable cameras...

*** GEV Interface 0 ***
No devices detected.

*** GEV Interface 1 ***
No devices detected.

*** GEV Interface 2 ***
** Device 0 **
DeviceSerialNumber : 22529038
DeviceModelName : Blackfly BFLY-PGE-13E4C
DeviceVendorName : Point Grey Research
GevDeviceIPAddress : 192.168.4.21
GevDeviceSubnetMask : 255.255.0.0
GevDeviceGateway : 0.0.0.0
GevDeviceMACAddress : 00:B0:9D:57:C4:0E
GevPersistentIPAddress : 192.168.4.21
GevPersistentSubnetMask : 255.255.0.0
GevPersistentDefaultGateway : 0.0.0.0

*** GEV Interface 3 ***
** Device 0 **
DeviceSerialNumber : 22529042
DeviceModelName : Blackfly BFLY-PGE-13E4C
DeviceVendorName : Point Grey Research
GevDeviceIPAddress : 192.168.5.21
GevDeviceSubnetMask : 255.255.0.0
GevDeviceGateway : 192.168.0.64
GevDeviceMACAddress : 00:B0:9D:57:C4:12
GevPersistentIPAddress : 192.168.5.21
GevPersistentSubnetMask : 255.255.0.0
GevPersistentDefaultGateway : 192.168.0.64

*** GEV Interface 4 ***
No devices detected.

```

Seems to confirm that network interfaces were correctly set up, and cameras are reachable. Is there another utility that I can use to grab some test images?

Yet again, easy thing works. Running `/opt/spinnaker/bin/spinview` brings up a nice GUI that confirms cameras are all working.

Time to poke at an updated config?

Immediately complains about no opencl platforms! Let's dig in. Where does it make that check and how does it do so?

Okay, so `nvidia-utils` never got installed, because nvidia-opencl-icd is a virtual package that contains more than just libnvidia. Makes sense. What else does it provide? Turns out it's pretty much just libnvidia-compute-XXX, but XXX has to match the local driver version. The local driver version can be found via:

`cat /proc/driver/nvidia/version`

Removing the XXX=590 version I mistakenly tried to install and installing the actual correct one (XXX=535) yields a vision processor that correctly finds the right device. Time to try it with the right config!

`pwd=~/vision-processor
./build/vision_processor --CONFIG
`

Ran into issue where running vision processor crashed camera, requiring unplug/replug. Time to debug a bit

For some reason, some way `vision_processor` is trying to control the camera is problematic:

`
murdock@murdock-MS-7C56:~/vision-processor$ ./build/vision_processor ~/ssl-field-computer/system_setup_scripts/config/one-camera-config.yml 
[OpenCL] Using device: NVIDIA CUDA » NVIDIA GeForce GTX 950
[Spinnaker] Opened Blackfly BFLY-PGE-13E4C - 22529038
[Spinnaker] Could not set parameter: Error Trace: Dec  3 2025 - 19:29:51, GenApi/EnumNodeT.cpp ln 111, SetValue: Message = GenICam::AccessException= Failed to write enumeration value. Enum entry is not writable : AccessException thrown in node 'PixelFormat' while calling 'PixelFormat.SetIntValue()' (file 'Enumeration.cpp', line 149) Error code = -2006
[Spinnaker] Could not set parameter: Error Trace: Dec  3 2025 - 19:29:51, GenApi/EnumNodeT.cpp ln 111, SetValue: Message = GenICam::AccessException= Feature not present (reference not valid) : AccessException thrown (file 'IEnumerationT.h', line 316) Error code = -2006
[Spinnaker] Could not set parameter: Error Trace: Dec  3 2025 - 19:29:51, GenApi/EnumNodeT.cpp ln 111, SetValue: Message = GenICam::AccessException= Feature not present (reference not valid) : AccessException thrown (file 'IEnumerationT.h', line 316) Error code = -2006
[Spinnaker] Could not set parameter: Error Trace: Dec  3 2025 - 19:29:51, GenApi/BooleanNode.cpp ln 76, SetValue: Message = Invalid handle of type BooleanNode. Error code = -1006
[Spinnaker] Could not set parameter: Error Trace: Dec  3 2025 - 19:29:51, GenApi/EnumNodeT.cpp ln 111, SetValue: Message = GenICam::AccessException= Feature not present (reference not valid) : AccessException thrown (file 'IEnumerationT.h', line 316) Error code = -2006
[RtpStreamer] Using codec: NVIDIA NVENC H.264 encoder
[main] Saved sample image
^CStopping vision_processor
`

Running this appears to set the camera in a state where it won't present images event to `spinview`, but an unplug/replug will reset it sufficiently.

Okay, this is a bit confusing, but I was able to verify that the spinnaker-facing "ID" in the yaml config files selects between 22529038 and 22529042. At exactly this moment, running the vision processor still borks the cameras it touches, but unplugs/replugs do still rescue them.