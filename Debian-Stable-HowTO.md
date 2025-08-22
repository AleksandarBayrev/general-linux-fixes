# Install latest Debian Stable

## If you run a Thinkpad with a fingerprint scanner check `Thinkpad-Fingerprint-Scanner-Linux-HowTO.md`

# IMPORTANT!!! - Add a root password after installation of the OS in order to have `sudo` cofigured out-of-the-box after installation instead of adding your current user to `sudo` group
# Add `i386` architecture: `sudo dpkg --add-architecture i386`
# Add user to `flatpak`, `libvirt`, `kvm`, `sudo` and `wheel` groups, then run `newgrp` to update them
# Install `aptitude`, `apt-listbugs`, `apt-listchanges`
# Remove `raspi-firmware` if not running Raspberry (`sudo apt purge raspi-firmware`)
# To update the system - `sudo apt update && sudo apt update -t codename-backports && sudo apt dist-upgrade && sudo apt dist-upgrade -t codename-backports` where `codename` is your current Debian version
# Upgrade system process - first update the current system, then change codename in `/etc/apt/sources.list` and then upgrade via `sudo apt dist-upgrade`
# Install security tools `firewalld` (if not present), `chkrootkit`, `rkhunter`
# Install `systemd-zram-generator` and `zram-tools`
# Install `net-tools` for the `netstat` command and other tools
# Install `pkexec` for GUI authorization
# Install `flatpak`, `libspa-0.2-bluetooth`, `sbc-tools`, `freeaptx-utils`, `bluetooth`, `galternatives`, `vlc`, `synaptic`, `wayland-protocols`, `pipewire`, `htop`, `btop`, `vim`, `openjdk-*-jre`, `libsdl2-dev`, `libcurl4-gnutls-dev`, `libopenal-dev`, `firewall-config`, `stress`, `s-tui`, `soundkonverter`, `rar`, `unrar`, `usbutils`, `smartmontools`, `nvme-cli` and `qt6-wayland`
# Install `bash-completion` for bash autocomplete
# Install `nvtop` if you have a NVIDIA GPU
# Flatpaks: check `flatpaks-to-install.txt`
# Install `Thumbnail Grid` task switcher for KDE.
# Install `clinfo` to show display system info.
# Install `acpi` to check battery status (on laptops)
# Install `upower` to check battery status (on laptops) and enable `upower` service
# Install `ttf-mscorefonts-installer` to add Microsoft fonts
# Install `KSystemLog` to view logs
# Check `Gaming-Linux-HowTO.md` for gaming
# Check `KDE-Settings.md` for some settings if you use KDE
# To enable automatic time sync install `systemd-timesyncd`
# To upgrade from one release to another - edit `/etc/apt/sources.list` and change codenames, don't skip versions because the system will break. Use `sudo apt full-upgrade` after changing release codename
# If using other software such as NVIDIA drivers directly from NVIDIA's development repo - update this as well: `/etc/apt/sources.list.d/cuda-<distro>-x86_x64.list`. Rename it to next version and update the contents where `<distro>` is for example `debian12`
```
deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/<distro>/x86_64/
```
# Example `/etc/apt/sources.list` for Debian Bookworm (version 12)
```
# See https://wiki.debian.org/SourcesList for more information.
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware

# Backports allow you to install newer versions of software made available for this release
deb http://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware
```
# Install `linux-image-amd64` and `linux-headers-amd64` from `bookworm-backports` or `whatever release you are on-backports` for updated kernel
# Or if a newer kernel is missing, but you need it (for example a newer GPU) - use [xanmod's kernels](https://xanmod.org/)
# Install `linux-headers-$YOUR_ARCH cmake make gcc g++ flex bison clang gcc-multilib g++-multilib autoconf automake build-essential` for development purposes
# IMPORTANT!!! - replace `bookworm` with the currently released stable version of Debian
# IMPORTANT!!! - for pipewire - Ensure this continues working after a reboot. If not, you may need to "mask" the PulseAudio service by running:
* `systemctl --user mask pulseaudio`
# To check if pipewire is being used: `LANG=C pactl info | grep '^Server Name'`
# Install firmware
* Check `Linux-Firmware-For-Hardware.md`
# Remove `orca` to prevent sound issues: `sudo apt remove orca && sudo apt purge orca && sudo apt autoremove`
# Check `Sound-Fixes-Linux.md` as well.
# If you want a newer kernel without waiting for backports check `Debian-Compile-Kernel-HowTO.pdf` (and [https://kernel-team.pages.debian.net/kernel-handbook/](https://kernel-team.pages.debian.net/kernel-handbook/))
# NOTE: If you use VMware Workstation on Debian - run `sudo systemctl enable --now vmware` and restart your PC in order for the network/USB passthrough to work
# Check `Disable-USB-Autosuspend-Linux.md`