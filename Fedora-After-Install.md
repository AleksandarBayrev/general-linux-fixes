# Installation
* Download minimal ISO and install `Fedora KDE Plasma Workspace`.
* Set password for your user and root user (mandatory if you want to troubleshoot the system in case of a failure without chroot).
* Remove checkboxes for everything in the `Additional software` tab, select then only `RPM Development Tools` and `System Tools`.

# After installation of Fedora

## If you run a Thinkpad with a fingerprint scanner check `Thinkpad-Fingerprint-Scanner-Linux-HowTO.md`

## Install `fedora-repos-archive` package to use with `dnf rollback` if needed

## Clone `update-fedora` repo [https://github.com/AleksandarBayrev/update-fedora](https://github.com/AleksandarBayrev/update-fedora) and run `make install`, use the script  to update the system

## Add Flathub repository

## Add user to `flatpak`, `libvirt`, `kvm` and `wheel` groups, then run `newgrp` to update them

## Remove zram-generator (if using a separate swap partition)
* Run `sudo dnf remove zram-generator-defaults zram-generator`

## Disable SELinux - edit `/etc/selinux/config` file, find line `SELINUX=` and set it to `disabled` => `SELINUX=disabled` (or use `grubby --update-kernel ALL --args selinux=0`)

## Check `Swap-File-Creation.md`

## Setup sysctl swappiness
* Create `10-swappiness.conf` with contents `vm.swappiness=10` in `/etc/sysctl.d`

## Remove abrt
* Run `sudo dnf remove abrt*`

## Install firmware
* Check `Linux-Firmware-For-Hardware.md`

## Install firewall-config
* Run `sudo dnf install firewall-config`

## Install codecs (*OPTIONAL* if you use flatpaks it is not required)
* Run `sudo dnf swap ffmpeg-free ffmpeg --allow-erasing`

## Install `sysfsutils` to check for VRR for example:
* Run `sudo dnf install sysfsutils`

## Install `KDE Connect` and enable it in `Firewall` to be able to connect your phone.

## Base tools
* Install groups `Multimedia` (not needed if you use Flatpak apps for Multimedia [Firefox, VLC, etc...]), `Development Tools`, `Administration Tools`, `Container Management`, `Desktop accessibility`, `Development Tools`, `RPM Development Tools`, `KDE (K Desktop Environment) (minimal)`, `Fonts`, `Hardware Support`, `System Tools` via `sudo dnf group install YOUR_GROUP`
* Install `rpmconf`, `dnf-plugin-system-upgrade` and `remove-retired-packages`
* Install `lact` (Flatpak is preferred) (or `corectrl`) (for AMD GPU users), `nvtop` (for GPU monitoring), check `AMD-GPUs-Linux-Control-Panel.md` for additional configuration

## Flatpaks
* Check `flatpaks-to-install.txt`
* Check app-order-linux.png from `random-important-stuff` repo.

## How to update
* Run `sudo dnf upgrade --refresh && sudo akmods` (call `sudo akmods` only if you use some sort of akmods (NVIDIA drivers, VirtualBox))
* Or run `update-fedora` bash script (copy it to `/usr/sbin`). It does everything automatically.

## How to upgrade
* Install `system-upgrade` using the command `sudo dnf install dnf-plugin-system-upgrade`
* Use the command like this `sudo dnf system-upgrade download --releasever=YOUR_VERSION` (eg. `sudo dnf system-upgrade download --releasever=37`)
* After the update has been downloaded - `sudo dnf system-upgrade reboot` and wait for the operation to complete.

## After upgrade
* Run `sudo remove-retired-packages YOUR_PREVIOUS_VERSION` to remove old packages not needed after the update. 
* Run `sudo rpmconf -a` to update RPM configurations after upgrade.
 
## After kernel upgrade
* It is recommended after running `dnf update` to run `sudo akmods` to rebuild kernel modules and then reboot (mainly NVIDIA users are affected) (update-fedora script automatically does this).

## After updating NVIDIA driver version
* If you are using for example `Steam` flatpak, please run `flatpak update` after you have rebuilded kernel modules and restarted the system, to install the new flatpak drivers for NVIDIA.

## Running in VMware
* Issue noticed on Fedora 37 - sound is choppy, to resolve it: `sudo dnf install pulseaudio --allowerasing`

## For NVIDIA Users
* Install `envycontrol` to switch between graphics cards.
* Check `NVIDIA-Fixes-Linux.md`

## Check `KDE-Settings.md` if you use KDE for some settings

## For Multimedia (FFmpeg/Mesa) from RPMFusion check this - [https://rpmfusion.org/Howto/Multimedia](https://rpmfusion.org/Howto/Multimedia)

## For Lutris - `flatpak install org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08 (or the latest one available)`

## If you have system-wide hangs without internet - `sudo dnf reinstall linux-firmware`

## *OPTIONAL* (if you don't use flatpaks): Install Mesa from RPMFusion - `sudo dnf swap mesa-*-drivers mesa-*-drivers-freeworld.* --allowerasing`

## For Discord - install normal `Discord` (`com.discordapp.Discord` from Flathub)

## Check `fedora-dnf-history.log` for some tips about installing/removing initially.

## Check `Fix-Linux-Sleep.md` (should not be relevant with newer kernels)

## Customize power profiles

<img src="./kde-power-profiles.png" />

## Check `Flatpak-Apps.md`, `fedora-flatpaks.txt` and `fedora-packages.txt` for apps that I might have missed.

## Check `QEMU-KVM.md` to see how to setup QEMU/KVM.

## IMPORTANT!!! - Install `Steam` via `distrobox` - check `Steam-Distrobox.md` on how to setup the container.

## Install `glmark2` and `s-tui` to perform GPU/CPU stress tests.

## IMPORTANT!!! - Check `FSTAB-Important.md` when you need to change disks or have disk problems.

## IMPORTANT!!! - Check `MEGA.NZ-Tutorial.md` in `random-important-stuff` repo.