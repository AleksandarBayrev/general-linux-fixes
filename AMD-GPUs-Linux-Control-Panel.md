# AMD GPUs Linux Control Panel
* Install `corectrl` on your distribution of choice. [Gitlab Link](https://gitlab.com/corectrl/corectrl)
* OR install `LACT` on your distribution of choice (Flatpak is preferred). [Github Link](https://github.com/ilya-zlobintsev/LACT)
* Add it to `Autostart` (for `LACT` it is not mandatory) in KDE (or whathever the utility is for other DEs)
* Add `amdgpu.ppfeaturemask=0xffffffff` to your bootloader config and rebuild it if necessary (or create a file `/etc/modprobe.d/99-amdgpu-overdrive.conf` with content: `options amdgpu ppfeaturemask=0xFFFFFFFF` and run `sudo update-initramfs -u`).

## NOTE: If for some reason LACT breaks - edit `/etc/systemd/system/lactd.service`: set `ExecStart` to `ExecStart=/var/lib/flatpak/app/io.github.ilya_zlobintsev.LACT/x86_64/stable/active/files/bin/lact daemon`

# How to disable password prompt - [https://gitlab.com/corectrl/corectrl/-/wikis/Setup](https://gitlab.com/corectrl/corectrl/-/wikis/Setup)

# To enable AMD Freesync - add `amdgpu.freesync_video=1` parameter to GRUB_CMDLINE_LINUX and run `sudo grub2-mkconfig -o /boot/grub2/grub.cfg` (on newer Linux distros it already works OOB)