# Install latest Debian Stable or get latest Live DVD from [here](https://cdimage.debian.org/cdimage/weekly-live-builds/amd64/iso-hybrid/)

## If you run a Thinkpad with a fingerprint scanner check `Thinkpad-Fingerprint-Scanner-Linux-HowTO.md`

# IMPORTANT!!! - Add a root password after installation of the OS in order to have `sudo` cofigured out-of-the-box after installation instead of adding your current user to `sudo` group
# Use `apt-mark $OPERATION` to mark as auto, hold, install package updates, etc.
# Use `apt-cache policy PKG_NAME` to see available versions
# Add `i386` architecture: `sudo dpkg --add-architecture i386`
# Add user to `flatpak`, `libvirt`, `kvm`, `sudo` and `wheel` groups, then run `newgrp` to update them
# Update `/etc/apt/sources.list` like this:
```
deb http://deb.debian.org/debian testing main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian testing main contrib non-free non-free-firmware

deb http://deb.debian.org/debian testing-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian testing-updates main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security/ testing-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security/ testing-security main contrib non-free non-free-firmware
```
# Install `aptitude`, `apt-listbugs`, `apt-listchanges`
# Remove `raspi-firmware` if not running Raspberry (`sudo apt purge raspi-firmware`)
# Install security tools `firewalld` (if not present), `chkrootkit`, `rkhunter`
# Install `systemd-zram-generator` and `zram-tools`
# Install `flatpak`, `libspa-0.2-bluetooth`, `sbc-tools`, `freeaptx-utils`, `bluetooth`, `galternatives`, `vlc`, `synaptic`, `wayland-protocols`, `pipewire`, `htop`, `btop`, `vim`, `openjdk-*-jre`, `libsdl2-dev`, `libcurl4-gnutls-dev`, `libopenal-dev`, `firewall-config`, `stress`, `s-tui`, `soundkonverter`, `audacity`, `usbutils`, `smartmontools`, `nvme-cli` and `qt6-wayland`
# Install `Thumbnail Grid` task switcher for KDE.
# Install `clinfo` to display system info.
# Install `acpi` to check battery status (on laptops)
# Install `upower` to check battery status (on laptops) and enable `upower` service
# Install `ttf-mscorefonts-installer` to add Microsoft fonts
# Install `KSystemLog` to view logs
# Install `nvtop` if you have a NVIDIA GPU
# Check `Gaming-Linux-HowTO.md` for gaming
# Check `KDE-Settings.md` for some settings if you use KDE
# Check `Gaming-Software.md`
# IMPORTANT!!! - Upgrade system with `sudo apt full-upgrade`
# IMPORTANT!!! - Upgrading the system from testing branch should be done one release at a time. Example - current testing branch is pointing to `trixie` (Debian 13), if let's say you were running testing branch from `buster` at that time -> what you should do is this: upgrade `buster` to `bullseye` and then point `bullseye` to `bookworm`, and then point `bookworm` to `testing` (which is actually `trixie` at the time of writing the tutorial). More info here -> [https://www.debian.org/releases/](https://www.debian.org/releases/). Check current codename with `lsb_release -a`, sample output will be: `Codename: trixie`
# Install firmware
# If a newer kernel is missing, but you need it (for example a newer GPU) - compile your own following the guide `Debian-Compile-Kernel-HowTO.md`
# Install `linux-headers-$YOUR_ARCH cmake make gcc g++ flex bison clang gcc-multilib g++-multilib autoconf automake build-essential` for development purposes
* Check `Linux-Firmware-For-Hardware.md`
# Remove `orca` to prevent sound issues: `sudo apt remove orca && sudo apt purge orca && sudo apt autoremove`
# Check `Sound-Fixes-Linux.md` as well.
# If you want a newer kernel without waiting for backports check `Debian-Compile-Kernel-HowTO.md` (and [https://kernel-team.pages.debian.net/kernel-handbook/](https://kernel-team.pages.debian.net/kernel-handbook/))
# NOTE: If you use VMware Workstation on Debian - run `sudo systemctl enable --now vmware` and restart your PC in order for the network/USB passthrough to work
# Check `Disable-USB-Autosuspend-Linux.md`
# Check `flatpaks-to-install.txt` if you need something as flatpak
# Check `Mediatek-WiFi-Debian.md` for instructions on how to setup firmware (if you have problems)
# Check `Apps-In-Distrobox.md`
# For using `OpenVPN` configuration check `OpenVPN-Configuration-Linux.md`
# If using APC UPS - check `Linux-UPS-APC-HowTO.md`
# Install `fooyin` for listening to music (use flatpak)
# Check `NTSYNC-HowTO.md`
# If you want to use gamescope - check `gamescope-installer` folder and `Gamescope-Notes.md` in `random-important-stuff`
# Check `Linux-Gaming-Notes.md` in `random-important-stuff` for useful tips mostly for old games (to limit CPU cores for example)