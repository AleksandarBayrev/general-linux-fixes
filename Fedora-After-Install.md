# After installation of Fedora

## Add Flathub repository

## Remove zram-generator (if using a separate swap partition)
* Run `sudo dnf remove zram-generator-defaults zram-generator`

## Disable SELinux

## Check `Swap-File-Creation.md`

## Setup sysctl swappiness
* Create `10-swappiness.conf` with contents `vm.swappiness=10` in `/etc/sysctl.d`

## Remove abrt
* Run `sudo dnf remove abrt*`

## Install firmware
* Check `Linux-Firmware-For-Hardware.md`

## Install firewall-config
* Run `sudo dnf install firewall-config`

## Install codecs
* Run `sudo dnf install ffmpeg-free libavcodec-freeworld`

## Base tools
* Install groups `Multimedia` (not needed if you use Flatpak apps for Multimedia [Firefox, VLC, etc...]), `Development Tools` via `sudo dnf group install YOUR_GROUP`
* Install `rpmconf`, `dnf-plugin-system-upgrade` and `remove-retired-packages`

## Flatpaks
* `Flatseal`, `Firefox`, `Postman`, `OBS Studio`, `Viber`, `Handbrake`, `ProtonUp-Qt`, `MediaInfo`, `PCSX2`, `Duckstation`, `GIMP`, `Kdenlive`, `Inkscape`, `KDiff3`, `OpenMW`, `PPSSPP`, `qBittorrent`, `Remmina`, `VLC`, `Lutris`, `Apache JMeter`, `Vencord`, `Avidemux`, `Bottles`, `RPCS3`, `Filezilla`, `Audacity`, `LibreOffice`, `DBeaver`
* Check app-order-linux.png from `random-important-stuff` repo.

## How to update
* Run `sudo dnf upgrade --refresh`

## How to upgrade
* Install `system-upgrade` using the command `sudo dnf install dnf-plugin-system-upgrade`
* Use the command like this `sudo dnf system-upgrade download --releasever=YOUR_VERSION` (eg. `sudo dnf system-upgrade download --releasever=37`)
* After the update has been downloaded - `sudo dnf system-upgrade reboot` and wait for the operation to complete.

## After upgrade
* Run `sudo remove-retired-packages YOUR_PREVIOUS_VERSION` to remove old packages not needed after the update. 
* Run `sudo rpmconf -a` to update RPM configurations after upgrade.
 
## After kernel upgrade
* It is recommended after running `dnf update` to run `sudo akmods-shutdown` to rebuild kernel modules and then reboot (mainly NVIDIA users are affected).

## Running in VMware
* Issue noticed on Fedora 37 - sound is choppy, to resolve it: `sudo dnf install pulseaudio --allowerasing`

## For NVIDIA Users
* Install `envycontrol` to switch between graphics cards.
* Check `NVIDIA-Fixes-Linux.md`

## For KDE
* Disable indexing in `File Search` if you experience stutter after installing apps.

## For Multimedia (FFmpeg/Mesa) from RPMFusion check this - [https://rpmfusion.org/Howto/Multimedia](https://rpmfusion.org/Howto/Multimedia)

## For Lutris - `flatpak install org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08`

## If you have system-wide hangs without internet - `sudo dnf reinstall linux-firmware`

## Install Mesa from RPMFusion - `sudo dnf install mesa-*-freeworld.* --allowerasing`

## For Discord - install `Vencord Desktop` from github - [https://github.com/Vencord/Vesktop/](https://github.com/Vencord/Vesktop/)

## Check `fedora-dnf-history.log` for some tips about installing/removing initially.

## Check `Fix-Linux-Sleep.md`

## Check `Flatpak-Apps.md`, `fedora-flatpaks.txt` and `fedora-packages.txt` for apps that I might have missed.

## Check `QEMU-KVM.md` to see how to setup QEMU/KVM.