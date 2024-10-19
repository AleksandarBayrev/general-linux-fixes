# AMD GPUs Linux Control Panel
* Install `corectrl` on your distribution of choice. [Gitlab Link](https://gitlab.com/corectrl/corectrl)
* Add it to `Autostart` in KDE (or whathever the utility is for other DEs)

# How to disable password prompt - [https://gitlab.com/corectrl/corectrl/-/wikis/Setup](https://gitlab.com/corectrl/corectrl/-/wikis/Setup)

# To enable AMD Freesync - add `amdgpu.freesync_video=1` parameter to GRUB_CMDLINE_LINUX and run `sudo grub2-mkconfig -o /boot/grub2/grub.cfg`