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

## Fedora-After-Install.md
* Contains steps that you should use as a guideline after a new or updated installation of Fedora.

## Linux stress tests
* Install glmark2 and s-tui to perform GPU/CPU stress tests.

## Switch-Java-Versions-Fedora.md
* Describes how to switch between different Java versions on Fedora (can be applicable to other distributions).

## distrobox-manual.md
* Describes how to install and use distrobox.

## nouveau-problem-fixes.md
* If you have problems after replacing nouveau with Proprietary NVIDIA drivers read this.

## Flatpak-Nvidia-Settings.md
* Contains information how to pass NVIDIA GPU to flatpak installed apps (on NVIDIA Prime laptops).

## VMWare-Configuraton-Windows.md
* Gives configuration steps on how to setup Windows 11 on Linux with VMWare.

## ABRT-Config.md
* Gives configuration steps to disable non-reportable errors appearing in the reporting tool.

## AMD-GPUs-Linux-Control-Panel.md
* Gives AMD GUI utility to control the GPUs/CPUs.

## rocky-linux-autoupdate-no-downtime.pdf
* Describes how to enable Rocky Linux auto update and no downtime.

## Nested Virtualization - Hyper-V 2019 in qemu-kvm – _techblog.pdf
* KVM settings for Windows guest VM.

## How-To-Boot-Android-x86-Or-BlissOS-When-Stuck-On-Console-In-VM.pdf
* Describes how to boot Android x86/BlissOS or other Android based x86 OS in a VM.

## OpenSUSE-Tumbleweed-After-Install.md
* Describes how to setup OpenSUSE Tumbleweed and how to setup .NET/Node on it.

## Swap-Configuration.md
* Describes how to setup swap on Linux.