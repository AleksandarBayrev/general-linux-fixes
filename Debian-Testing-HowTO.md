# Install latest Debian Stable or get latest Live DVD from [here](https://cdimage.debian.org/cdimage/weekly-live-builds/amd64/iso-hybrid/)

## If you run a Thinkpad with a fingerprint scanner check `Thinkpad-Fingerprint-Scanner-Linux-HowTO.md`

# IMPORTANT!!! - Add a root password after installation of the OS in order to have `sudo` cofigured out-of-the-box after installation instead of adding your current user to `sudo` group
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
# IMPORTANT!!! - Upgrade system with `sudo apt full-upgrade`
# IMPORTANT!!! - Upgrading the system from testing branch should be done one release at a time. Example - current testing branch is pointing to `trixie` (Debian 13), if let's say you were running testing branch from `buster` at that time -> what you should do is this: upgrade `buster` to `bullseye` and then point `bullseye` to `bookworm`, and then point `bookworm` to `testing` (which is actually `trixie` at the time of writing the tutorial). More info here -> [https://www.debian.org/releases/](https://www.debian.org/releases/). Check current codename with `lsb_release -a`, sample output will be: `Codename: trixie`
# Install firmware
# Install `make gcc g++ flex bison clang` for development purposes
* Check `Linux-Firmware-For-Hardware.md`
# Remove `orca` to prevent sound issues: `sudo apt remove orca && sudo apt purge orca && sudo apt autoremove`
# Check `Sound-Fixes-Linux.md` as well.
# If you want a newer kernel without waiting for backports check `Debian-Compile-Kernel-HowTO.pdf`