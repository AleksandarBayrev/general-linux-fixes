# Steps:
* Use `distrobox` to create a container that will hold the required packages to compile the kernel (`make bindeb-pkg` will throw them as an error) (it is recommended to install either the latest Debian, or the one that you are currently running)
* Clone the version you want to compile (example 6.16.11)
* Copy the existing config to the folder (cp -v /boot/config-6.12.48+deb13-amd64)
* `make olddefconfig`
* Create debs: `make bindeb-pkg -jNUM_THREADS LOCALVERSION=yourversion` (example: `make bindeb-pkg -j20 LOCALVERSION=+deb13-custom` to match) (`NUM_THREADS` recommended to be atleast max threads - 2) (if the command fails check what packages are missing and install them)
* Run `sudo apt install -y ./*.deb` on the built packages and reboot your PC