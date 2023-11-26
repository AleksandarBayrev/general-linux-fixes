# After installation of Fedora

## Remove zram-generator (if using a separate swap partition)
* Run `sudo dnf remove zram-generator-defaults zram-generator`

## Remove abrt
* Run `sudo dnf remove abrt*`

## Install firewall-config
* Run `sudo dnf install firewall-config`

## Install codecs
* Run `sudo dnf install ffmpeg-free libavcodec-freeworld`

## Base tools
* Install groups `Multimedia`, `Development Tools` via `sudo dnf group install YOUR_GROUP`
* Install `rpmconf`, `dnf-plugin-system-upgrade` and `remove-retired-packages`

## Flatpaks
* `Flatseal`, `Postman`, `OBS Studio`, `Viber`, `Handbrake`, `ProtonUp-Qt`, `MediaInfo`, `PCSX2`, `Duckstation`, `GIMP`, `Kdenlive`, `KDiff3`, `OpenMW`, `PPSSPP`, `qBittorrent`, `Remmina`, `VLC`, `Lutris`, `Apache JMeter`

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

## For KDE
* Disable indexing in `File Search` if you experience stutter after installing apps.

## For Multimedia (FFmpeg/Mesa) from RPMFusion check this - [https://rpmfusion.org/Howto/Multimedia](https://rpmfusion.org/Howto/Multimedia)

## For Lutris - `flatpak install org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08`

## If you have system-wide hangs without internet - `sudo dnf reinstall linux-firmware`

## Install Mesa from RPMFusion - `sudo dnf install mesa-*-freeworld.* --allowerasing`

## For Discord - install `Vencord Desktop` from github - [https://github.com/Vencord/Vesktop/](https://github.com/Vencord/Vesktop/)

## Check `fedora-dnf-history.log` for some tips about installing/removing initially.