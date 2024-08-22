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

## Swap-Configuration.md
* Describes how to setup swap on Linux.

## Arch-After-Install.md
* Describes Arch setup + configurations after installation.

## How do I change the default file manager back to Nautilus
* Describes how to set the default file manager to Nautilus.

## Installing Microsoft Windows 98 in DOSBox-X.pdf
* Describes how to install Windows 98 in DOSBox-X.

## Arch-Before-Install-And-Update-Problems.md
* Describes how to tackle some issues before installation or update related problems.

## OBS-Fix-Wayland.md
* Describes how to enable screen recording on Wayland.

## VLC-Black-Screen-Fix.md
* Describes how to fix black screen and audio working only in VLC.

## Ubuntu-Tips.md
* Describes some Ubuntu tips (may work on other Debian/Ubuntu based distros).

## Fix-Ubuntu-Sound-Problems.md
* Describes how to fix sound problems in Ubuntu 22.04 (and later versions probably).

## default-sources-list-ubuntu-2204.list
* Provides default sources configuration for Bulgaria.

## QEMU-KVM.md
* Provides tips to install QEMU/KVM on Linux.

## Debian-Testing-HowTO.md
* Describes how to start with Debian Testing on a hardware.

## Debian-Stable-HowTO.md
* Describes how to start with Debian Stable on a hardware.

## NVIDIA-Fixes-Linux.md
* Small fixes to allow sleeping to work properly.

## Mangohud-GOverlay.md
* Describes how to use `mangohud` and `goverlay`

## openSUSE-Tumbleweed-HowTO.md
* Describes how to start with openSUSE Tumbleweed on a hardware.

## Sound-Fixes-Linux.md
* Describes how to fix HDMI crackling.

## Samba-Share-HowTO.md
* Describes how to setup Samba shares.

## VMWare-Modules-Tips.md
* Describes how to maintain VMWare in a rolling release distro.

## Podman-Stop-Containers-On-Shutdown.md
* Describes how to fix slow shutdown when using Podman.

## DNF-Tips.md
* Describes some tips for DNF based distros (Fedora, Rocky, RHEL, Alma).

## Fix-Linux-Sleep.md
* Provides some SystemD fixes.

## nvidia-novsync
* Copy the script to `/bin` and use it to disable vsync on NVIDIA, example: `nvidia-novsync glxgears`

## TLP-Enable-Battery-Conservation.md
* Describes how to enable battery conservation on laptops that support it.

## set-cpu-freq.md
* Describes how to limit CPU frequency in Linux.

## app-order.png
* Shows how to order your desktop.

## Which-Distro-To-Use.md
* Describes which Linux distro is appropriate based on your hardware.

## Linux-Firmware-For-Hardware.md
* Describes what firmware you need to install for some hardware.

## Flatpak-Apps.md
* List of Flatpak apps that are useful.

## VMWare-Configuration-Linux.md
* Tips for VMWare Workstation on Linux hosts.

## Swap-File-Creation.md
* Describes how to setup swap file instead of partition (better manageability).

## suse-wallpaper.png
* openSUSE black wallpaper

## ssh-login-tips.png
* Some SSH login tips.

## TimeShift-HowTO.md
* Describes how to do system backups.

## Steam-libstrangle-Flatpak.md
* Describes how to setup `libstrangle` to be accessible by `Steam` from `Flatpak`.

## Steam-Distrobox.md
* Describes how to setup `Steam` in `distrobox`.

## ALSA-Fixes.md
* Provides some fixes for Linux audio.

## Steam-mangohud-Flatpak.md
* Provides info on how to setup `Mangohud`

## Battle-NET-Linux-Fix.md
* Provides fixes for Battle.NET on Linux

## corectrl-profile.ccpro
* Example `CoreCtrl` profile for fans.

## FSTAB-Important.md
* Important note for disk changes.

## How to Properly Install a Windows 11 Virtual Machine on KVM.pdf
* Describes how to configure Windows 11 in QEMU/KVM.