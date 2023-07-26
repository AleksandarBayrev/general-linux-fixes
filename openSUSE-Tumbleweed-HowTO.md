# Install openSUSE Tumbleweed with the DE of your choice.
# Install `opi`
# Install codecs via `opi codecs`
# IMPORTANT!!! - Upgrade system with `sudo zypper dup`, if there are conflicts do not use `--allow-vendor-change` because it can break packages, wait for the updates to be pushed upstream
# Note for VMWare - run `sudo vmware-modconfig --install-all` after earch kernel update (or find a way to add a zypper hook)
# opensuse-tumbleweed-installed-packages.txt contains the system packages installed as of 17.07.2023 on my desktop system
# Note for NVIDIA - install `nvidia-drivers-G06` `nvidia-gl-G06` and copy `nvidia_icd.json` to `/usr/share/vulkan/icd.d`
# IMPORTANT!!! - To check zypper history log - use `sudo cat /var/log/zypp/history` to check transactions (install/remove/update)
