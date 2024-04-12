# Install openSUSE Tumbleweed with the DE of your choice.
# Use flatpaks for everything possible, otherwise use distrobox (only as a last resort install system-wide)
# Note for VMWare - run `sudo vmware-modconfig --install-all` after earch kernel update (or find a way to add a zypper hook)
# opensuse-tumbleweed-installed-packages.txt contains the system packages installed as of 17.07.2023 on my desktop system
# Note for NVIDIA - install `nvidia-drivers-G06` `nvidia-gl-G06` and copy `nvidia_icd.json` to `/usr/share/vulkan/icd.d`
# Install `Timeshift` and `cron` to make system backups (check `TimeShift-HowTO.md` for more information).
# IMPORTANT!!! - To check zypper history log - use `sudo cat /var/log/zypp/history` to check transactions (install/remove/update)
# IMPORTANT!!! - Before running `sudo zypper dup` use `Timeshift` to make a snapshot of your current system, if something breaks you can rollback easily.