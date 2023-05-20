# Install latest Debian Stable or get latest Live DVD from [here](https://cdimage.debian.org/cdimage/weekly-live-builds/amd64/iso-hybrid/)
# Update `/etc/apt/sources.list` like this:
```
deb http://deb.debian.org/debian testing main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian testing main contrib non-free non-free-firmware

deb http://deb.debian.org/debian testing-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian testing-updates main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security/ testing-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security/ testing-security main contrib non-free non-free-firmware
```
# Install `nala`
# Remove `raspi-firmware` if not running Raspberry (`sudo nala purge raspi-firmware`)
# Upgrade system via `sudo nala upgrade`
# Install `systemd-zram-generator` and `zram-tools`
# Install `libspa-0.2-bluetooth`, `sbc-tools`, `freeaptx-utils`, `bluetooth`, `galternatives`, `vlc`, `synaptic`, `wayland-protocols`, `pipewire`, `htop`, `vim`, `openjdk-*-jre` and `qt6-wayland`
# Install `Thumbnail Grid` task switcher for KDE.
