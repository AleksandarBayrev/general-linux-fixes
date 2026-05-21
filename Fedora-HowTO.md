# Install latest Fedora

## If you run a Thinkpad with a fingerprint scanner check `Thinkpad-Fingerprint-Scanner-Linux-HowTO.md`

# IMPORTANT!!! - Disable CSM in UEFI/BIOS since it interferes with `ReBAR` (Resizable BAR), it can't be enabled, which has huge performance penalty when OFF
# IMPORTANT!!! - Add a root password after installation of the OS in order to have `sudo` cofigured out-of-the-box after installation instead of adding your current user to `sudo` group
# Disable SELinux - edit `/etc/selinux/config` file, find line `SELINUX=` and set it to `disabled` => `SELINUX=disabled` (or use `grubby --update-kernel ALL --args selinux=0`)
# Delete java (`sudo dnf remove java*`), zram-generator (`sudo dnf remove zram-generator*`), dragon (`sudo dnf remove dragon`), elisa-player (`sudo dnf remove elisa-player`)
# Install `kernel-modules-extra` for additional device support
# Check `ALSA-Fixes.md`
# Check `KDE-Settings.md`
# Install `kernel-tools` package and use `turbostat` command to monitor CPU stats
# Install `rpmconf` to manage configurations after a system upgrade
# Check `mesa-custom-builds` when you need to run a newer Mesa version
# Add user to `flatpak`, `libvirt`, `kvm` groups, then run `newgrp` to update them
# Check `Fix-Linux-Sleep.md` to disable hibernation or try to potentially fix some issues.
# To update the system - `sudo dnf update`
# Upgrade system process:
```bash
sudo dnf system-upgrade downoad --releasever NUMBER_HIGHER_THAN_THE_CURRENT_ONE
sudo dnf system-upgrade reboot
# After the upgrade run
sudo rpmconf -a # to reconfigure new applications
```
# Install security tools `firewalld` (if not present), `chkrootkit`, `rkhunter`
# Install `net-tools` for the `netstat` command and other tools
# Install `pkexec` for GUI authorization
# Install `fastfetch` and check `config-fastfetch/README.md`
# Install `flatpak`, `libspa-0.2-bluetooth`, `sbc-tools`, `freeaptx-utils`, `bluetooth`, `galternatives`, `vlc`, `synaptic`, `wayland-protocols`, `pipewire`, `htop`, `btop`, `vim`, `openjdk-*-jre`, `libsdl2-dev`, `libcurl4-gnutls-dev`, `libopenal-dev`, `firewall-config`, `stress`, `s-tui`, `soundkonverter`, `rar`, `unrar`, `usbutils`, `smartmontools`, `nvme-cli` and `qt6-wayland`
# Install `bash-completion` for bash autocomplete
# Install `nvtop` if you have a NVIDIA GPU
# Flatpaks: check `flatpaks-to-install.txt` (important: check this file every time you reinstall! (DBeaver for example is important when you use SQLite for example))
# Install `Thumbnail Grid` task switcher for KDE (if missing).
# Install `clinfo` to show display system info.
# Install `acpi` to check battery status (on laptops)
# Install `upower` to check battery status (on laptops) and enable `upower` service
# Use [https://github.com/AleksandarBayrev/ttf-fonts-installer/](https://github.com/AleksandarBayrev/ttf-fonts-installer/) to add Microsoft fonts
# Install `KSystemLog` to view logs
# Check `Gaming-Linux-HowTO.md` for gaming
# Check `KDE-Settings.md` for some settings if you use KDE
# Check `Gaming-Software.md`
# Install `rocm-smi` if you want to have GPU temps in `btop`
# To enable automatic time sync install `systemd-timesyncd`
# IMPORTANT!!! - check with `apt-mark showhold` any hold package versions and unhold them before upgrading!
# For AMD GPUs - check `AMD-GPUs-Linux-Control-Panel.md`
# Install `linux-headers-$YOUR_ARCH cmake make gcc g++ flex bison clang gcc-multilib g++-multilib autoconf automake build-essential` for development purposes
# IMPORTANT!!! - for pipewire - Ensure this continues working after a reboot. If not, you may need to "mask" the PulseAudio service by running:
* `systemctl --user mask pulseaudio`
# To check if pipewire is being used: `LANG=C pactl info | grep '^Server Name'`
# Install firmware
* Check `Linux-Firmware-For-Hardware.md`
# Check `Sound-Fixes-Linux.md` as well.
# Check `Disable-USB-Autosuspend-Linux.md`
# Check `Mediatek-WiFi-Debian.md` for instructions on how to setup firmware (if you have problems)
# Check `Apps-In-Distrobox.md`
# For using `OpenVPN` configuration check `OpenVPN-Configuration-Linux.md`
# If using APC UPS - check `Linux-UPS-APC-HowTO.md`
# Install `fooyin` for listening to music (use flatpak)
# Check `NTSYNC-HowTO.md`
# If you want to use gamescope - check `gamescope-installer` folder and `Gamescope-Notes.md` in `random-important-stuff`
# Check `Linux-Gaming-Notes.md` in `random-important-stuff` for useful tips mostly for old games (to limit CPU cores for example)