# Install latest Debian Stable

## If you run a Thinkpad with a fingerprint scanner check `Thinkpad-Fingerprint-Scanner-Linux-HowTO.md`

# IMPORTANT!!! - Add a root password after installation of the OS in order to have `sudo` cofigured out-of-the-box after installation instead of adding your current user to `sudo` group
# Check `mesa-custom-builds` when you need to run a newer Mesa version
# Use `apt-mark $OPERATION` to mark as auto, hold, install package updates, etc.
# Use `apt-cache policy PKG_NAME` to see available versions
# Add `i386` architecture: `sudo dpkg --add-architecture i386`
# Run `sudo apt modernize-sources` and remove `/etc/apt/sources.list` file and whatever else with suffix `~` or `.bak` (`sources.list~`, `sources.list.bak`)
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
# Check `Gaming-Software.md`
# To enable automatic time sync install `systemd-timesyncd`
# IMPORTANT!!! - check with `apt-mark showhold` any hold package versions and unhold them before upgrading!
# To upgrade from one release to another - edit `/etc/apt/sources.list` (or if using the method below `/etc/apt/sources.list.d/debian.sources`) and `/etc/apt/sources.list.d/* (all files)` and change codenames, don't skip versions because the system will break. Use `sudo apt full-upgrade` after changing release codename
# IMPORTANT!!! - if using NVIDIA - do not use backports, install newer kernels manually and verify that the DKMS compiles the proprietary driver successfully!
# If using other software such as NVIDIA drivers directly from NVIDIA's development repo - update this as well: `/etc/apt/sources.list.d/cuda-<distro>-x86_x64.list`. Rename it to next version and update the contents where `<distro>` is for example `debian12`
```
deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/<distro>/x86_64/
```
# Example `/etc/apt/sources.list.d/debian.sources` for Debian Trixie (version 13)
```
# Main packages
Types: deb deb-src
URIs: http://deb.debian.org/debian/
Suites: trixie
Components: main contrib non-free non-free-firmware
Enabled: yes
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

# Security
Types: deb deb-src
URIs: http://security.debian.org/debian-security/
Suites: trixie-security
Components: main contrib non-free non-free-firmware
Enabled: yes
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

# Updates
Types: deb deb-src
URIs: http://deb.debian.org/debian/
Suites: trixie-updates
Components: main contrib non-free non-free-firmware
Enabled: yes
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

# Debian Backports
Types: deb deb-src
URIs: http://deb.debian.org/debian
Suites: trixie-backports
Components: main contrib non-free non-free-firmware
Enabled: yes
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
```

# To add backports add this to `/etc/apt/sources.list.d/debian.sources`:

```text
# Debian Backports
Types: deb deb-src
URIs: http://deb.debian.org/debian
Suites: trixie-backports
Components: main contrib non-free non-free-firmware
Enabled: yes
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
```
* Run `apt update` and then install what you need from backports (I usually do `sudo apt dist-upgrade -t yourversion-backports` and then downgrade the kernel metapackages from backports to stable (always use current codename) (`linux-image-amd64`, `linux-headers-amd64` and `linux-libc-dev`) via `sudo apt install linux-image-amd64/codename-security linux-libc-dev/codename-security linux-headers-amd64/codename-security`, and then install custom kernels (since I use xanmod's kernels) (not anymore, I'm building my own))

# Install `linux-image-amd64` and `linux-headers-amd64` from `bookworm-backports` or `whatever release you are on-backports` for updated kernel
# Or if a newer kernel is missing, but you need it (for example a newer GPU) - compile your own following the guide `Debian-Compile-Kernel-HowTO.md`
# Install `linux-headers-$YOUR_ARCH cmake make gcc g++ flex bison clang gcc-multilib g++-multilib autoconf automake build-essential` for development purposes
# IMPORTANT!!! - replace `bookworm` with the currently released stable version of Debian
# IMPORTANT!!! - for pipewire - Ensure this continues working after a reboot. If not, you may need to "mask" the PulseAudio service by running:
* `systemctl --user mask pulseaudio`
# To check if pipewire is being used: `LANG=C pactl info | grep '^Server Name'`
# Install firmware
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