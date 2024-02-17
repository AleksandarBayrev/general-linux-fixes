# Install latest Debian Stable
# IMPORTANT!!! - Add a root password after installation of the OS in order to have `sudo` cofigured out-of-the-box after installation instead of adding your current user to `sudo` group
# Install `aptitude`, `apt-listbugs`, `apt-listchanges`
# Remove `raspi-firmware` if not running Raspberry (`sudo apt purge raspi-firmware`)
# To update the system - `sudo apt update && sudo apt update -t codename-backports && sudo apt dist-upgrade && sudo apt dist-upgrade -t codename-backports` where `codename` is your current Debian version
# Upgrade system process - first update the current system, then change codename in `/etc/apt/sources.list` and then upgrade via `sudo apt full-upgrade`
# Install security tools `firewalld` (if not present), `chkrootkit`, `rkhunter`
# Install `systemd-zram-generator` and `zram-tools`
# Install `net-tools` for the `netstat` command and other tools
# Install `pkexec` for GUI authorization
# Install `flatpak`, `libspa-0.2-bluetooth`, `sbc-tools`, `freeaptx-utils`, `bluetooth`, `galternatives`, `vlc`, `synaptic`, `wayland-protocols`, `pipewire`, `htop`, `btop`, `vim`, `openjdk-*-jre`, `libsdl2-dev`, `libcurl4-gnutls-dev`, `libopenal-dev`, `firewall-config`, `stress`, `s-tui`, `soundkonverter`, `rar`, `unrar`, `usbutils`, `smartmontools`, `nvme-cli` and `qt6-wayland`
# Install `bash-completion` for bash autocomplete
# Install `nvtop` if you have a NVIDIA GPU
# Flatpaks: `duckstation`, `PCSX2`, `RPCS3`, `Postman`, `Bottles`, `GIMP`, `VLC`, `LibreOffice`, `FlatSeal`, `OBS Studio`, `Handbrake`, `qBittorrent`, `Audacity`, `Kdenlive`, `KDiff3`, `Filezilla`, `Telegram`
# Install `Thumbnail Grid` task switcher for KDE.
# Install `clinfo` to show display system info.
# Install `acpi` to check battery status (on laptops)
# Install `upower` to check battery status (on laptops) and enable `upower` service
# Install `ttf-mscorefonts-installer` to add Microsoft fonts
# To enable automatic time sync install `systemd-timesyncd`
# To upgrade from one release to another - edit `/etc/apt/sources.list` and change codenames, don't skip versions because the system will break. Use `sudo apt full-upgrade` after changing release codename
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
# Install `make gcc g++ flex bison clang` for development purposes
# IMPORTANT!!! - replace `bookworm` with the currently released stable version of Debian
# IMPORTANT!!! - for pipewire - Ensure this continues working after a reboot. If not, you may need to "mask" the PulseAudio service by running:
* `systemctl --user mask pulseaudio`
# To check if pipewire is being used: `LANG=C pactl info | grep '^Server Name'`
# Install firmware
* Check `Linux-Firmware-For-Hardware.md`