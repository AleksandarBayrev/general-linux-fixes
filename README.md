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