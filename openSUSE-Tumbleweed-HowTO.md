# Install openSUSE Tumbleweed with the DE of your choice.
# Check `Fedora-After-Install.md` for some other stuff that you may require.
# Check `AMD-GPUs-Linux-Control-Panel.md` for controlling your AMD GPU.
# Use flatpaks for everything possible, otherwise use distrobox (only as a last resort install system-wide)
# Add user to `flatpak`, `libvirt`, `kvm` and `wheel` groups, then run `newgrp` to update them
# Note for VMWare - run `sudo vmware-modconfig --install-all` after earch kernel update (or find a way to add a zypper hook) (DEPRECATED, check QEMU/KVM step)
# opensuse-tumbleweed-installed-packages.txt contains the system packages installed as of 17.07.2023 on my desktop system
# Note for NVIDIA - install `nvidia-drivers-G06` `nvidia-gl-G06` and copy `nvidia_icd.json` to `/usr/share/vulkan/icd.d`
# It is recommended to install `dkms` and `NVIDIA` driver from the `NVIDIA` website, follow this guide - [https://en.opensuse.org/SDB:NVIDIA_the_hard_way](https://en.opensuse.org/SDB:NVIDIA_the_hard_way)
# IMPORTANT!!! - if you installed the `NVIDIA` driver from the `NVIDIA` website, please update it manually from the terminal, with the `run` file downloaded from there.
# Install `Ark`, `Spectacle`, `Gwenview`
# Install `Timeshift` and `cron` to make system backups (check `TimeShift-HowTO.md` for more information).
# Install `xdg-desktop-portal-gnome`, `flatpak-xdg-utils`
# Check `opensuse-tumbleweed-patterns.txt` to see what you can install.
# IMPORTANT!!! - To check zypper history log - use `sudo cat /var/log/zypp/history` to check transactions (install/remove/update)
# IMPORTANT!!! - Before running `sudo zypper dup` use `Timeshift` to make a snapshot of your current system, if something breaks you can rollback easily.
# IMPORTANT!!! - Use QEMU/KVM for virtualization
# IMPORTANT!!! - DO NOT ADD PACKMAN REPO, USE FLATPAKS WHENEVER POSSIBLE.
# IMPORTANT!!! - Use `distrobox` to install `Visual Studio Code`