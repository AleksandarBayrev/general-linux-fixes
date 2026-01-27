# NTSYNC Supposedly increases overall system performance
# To add it it is recommended to compile a custom kernel, check `Debian-Compile-Kernel-HowTO.md`
* If you want to run `make menuconfig` to setup additional stuff run `cp -v .config .config_bak` to preserve the original configuration. Pressing slash (/) on the keyboard opens up a search where you can look for modules that you want to include. (Suggested modules (it didn't have huge impact with version 6.16.11, could check with newer versions) - add ntsync (press M to compile it as a module and then use modprobe or create a config in `/etc/modules-load.d/` to load it)). For other additional settings check how they should be compiled
# Steps to enable it
### Create a Configuration File

Most modern Linux distributions (Arch, Fedora, Ubuntu, Debian) use systemd, which looks at the /etc/modules-load.d/ directory to determine which drivers to start at boot.

Open your terminal and run the following command to create a new config file:
Bash

sudo nano /etc/modules-load.d/ntsync.conf

### Add the Module Name

In the editor that opens, simply type the name of the module:
```text
ntsync
```

Save and Exit: Press Ctrl + O, Enter, then Ctrl + X.
### Verify the Configuration

* You can check if the module is available and ready to be loaded by running:
```sh
modinfo ntsync
```

If you see details about the module: You’re all set. It will load automatically on your next reboot.

If you see "Module not found": You likely need to install the specific header or dkms package for your kernel (e.g., linux-zen on Arch often includes it, or you may need ntsync-dkms from a COPR or AUR repository).


### Optional: Load it Right Now

If you don't want to restart your computer immediately to start using it, load it manually this one time:
```sh
sudo modprobe ntsync
```

# To check if it's working run `lsof /dev/ntsync` and you should see processes that use the driver.