# Steps:
* Use `distrobox` to create a container that will hold the required packages to compile the kernel (`make bindeb-pkg` will throw them as an error) (it is recommended to install either the latest Debian, or the one that you are currently running)
* Run in the container: `sudo apt install zstd`
* Clone the version you want to compile (example 6.16.11)
* Copy the existing config to the folder (Example: `cp -v /boot/config-6.12.48+deb13-amd64 .config`)
* `make olddefconfig`
* If you want to run `make menuconfig` to setup additional stuff run `cp -v .config .config_bak` to preserve the original configuration. Pressing slash (/) on the keyboard opens up a search where you can look for modules that you want to include. (Suggested modules - add ntsync (press M to compile it as a module and then use modprobe or create a config /etc/modprobe.d/ to load it)). For other additional settings check how they should be compiled
* Before running the command below run `diff .config .config_bak` to see the changes you've made from the original config
* If you are okay with them - create debs: `make bindeb-pkg -jNUM_THREADS LOCALVERSION=yourversion-architecture` (example: `make bindeb-pkg -j20 LOCALVERSION=+deb13-custom-amd64` to match) (`NUM_THREADS` recommended to be atleast max threads - 2) (if the command fails check what packages are missing and install them)
* Run `sudo apt install -y ./*.deb` on the built packages and reboot your PC (example: `sudo apt install -y ./linux-headers-6.16.11+deb13-custom_6.16.11-13_amd64.deb ./linux-image-6.16.11+deb13-custom_6.16.11-13_amd64.deb ./linux-libc-dev_6.16.11-13_amd64.deb`)
## NOTE: If the `make bindeb-pkg -jNUM_THREADS LOCALVERSION=yourversion-architecture` fails - run it without the `-jNUM_THREADS` parameter to see the error (`make bindeb-pkg LOCALVERSION=yourversion-architecture`, example: `make bindeb-pkg LOCALVERSION=+deb13-custom-amd64`)

## NOTE: If for some reason LACT breaks - edit `/etc/systemd/system/lactd.service`: set `ExecStart` to `ExecStart=/var/lib/flatpak/app/io.github.ilya_zlobintsev.LACT/x86_64/stable/active/files/bin/lact daemon` (if you run flatpak (recommended!))