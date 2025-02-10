# AMD GPUs Linux Control Panel
* Install `corectrl` on your distribution of choice. [Gitlab Link](https://gitlab.com/corectrl/corectrl)
* OR install `LACT` on your distribution of choice. [Github Link](https://github.com/ilya-zlobintsev/LACT)
* Add it to `Autostart` (for `LACT` it is not mandatory) in KDE (or whathever the utility is for other DEs)

# How to disable password prompt - [https://gitlab.com/corectrl/corectrl/-/wikis/Setup](https://gitlab.com/corectrl/corectrl/-/wikis/Setup)

# To enable AMD Freesync - add `amdgpu.freesync_video=1` parameter to GRUB_CMDLINE_LINUX and run `sudo grub2-mkconfig -o /boot/grub2/grub.cfg` (on newer Linux distros it already works OOB)