# general-linux-fixes
General Linux fixes

## prime-run/prime-run-novsync
* Copy prime-run and prime-run-novsync to /bin and chmod +x both executables.

## install-vmware-modules.sh
* This script fixes the build of VMware modules on Fedora

## disable-turbo-boost.service
* This service disables turbo boost (please check if /sys/devices/system/cpu/cpufreq/boost is present and then copy the service to /etc/systemd/system and enable it using sudo systemctl enable --now disable-turbo-boost.service

## update-nvidia-sleep-sh.md
* This text file describes how to fix sleep state in hybrid NVIDIA/iGPU setups (AMD/Intel) and it will work for NVIDIA-only related sleep issues

## How to Install KVM_QEMU on Manjaro_Archlinux.pdf
* This file includes a tutorial on how to setup KVM/QEMU on Arch/Manjaro

## zram-generator.conf
* This file configures ZRAM on new Linux distros that do not have swap partition enabled. Copy it to /etc/systemd.

## Fix-For-Mafia-DE.md
* This file describes how to run Mafia DE on Linux.

## KDE crashes randomly with KWin log
* If KDE crashes suddenly and restarts, and the logs contain Nov 27 10:58:25 nitro5-ryzen7 plasmashell[60717]: kf.plasma.quick: Couldn't create KWindowShadow for ToolTipDialog(0x55926af0f470) install plasma-wayland-protocols (on Arch Linux, search for a similar package on other distros)
