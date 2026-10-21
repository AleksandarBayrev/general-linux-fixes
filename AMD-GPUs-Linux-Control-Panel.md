# AMD GPUs Linux Control Panel
* Install `corectrl` on your distribution of choice. [Gitlab Link](https://gitlab.com/corectrl/corectrl)
* OR install `LACT` on your distribution of choice (Flatpak is preferred). [Github Link](https://github.com/ilya-zlobintsev/LACT)
* Add it to `Autostart` (for `LACT` it is not mandatory) in KDE (or whathever the utility is for other DEs)
* Add `amdgpu.ppfeaturemask=0xffffffff` to your bootloader config and rebuild it if necessary (or create a file `/etc/modprobe.d/99-amdgpu-overdrive.conf` with content: `options amdgpu ppfeaturemask=0xFFFFFFFF` and run `sudo update-initramfs -u`).

## NOTE: If using an immutable distro from Fedora - update the amdgpu params like this: `rpm-ostree kargs --append="amdgpu.ppfeaturemask=0xFFFFFFFF"` or use `rpm-ostree kargs --editor` to type the flag manually, example: `rhgb quiet root=UUID=4387bc1a-c980-4e81-8fea-1030429c0665 vconsole.keymap=bg_pho-utf8 rw amdgpu.ppfeaturemask=0xFFFFFFFF`

## NOTE: If for some reason LACT breaks - edit `/etc/systemd/system/lactd.service`: set `ExecStart` to `ExecStart=/var/lib/flatpak/app/io.github.ilya_zlobintsev.LACT/x86_64/stable/active/files/bin/lact daemon`

# How to disable password prompt - [https://gitlab.com/corectrl/corectrl/-/wikis/Setup](https://gitlab.com/corectrl/corectrl/-/wikis/Setup)

# To see all kernel parameters check [https://docs.kernel.org/gpu/amdgpu/module-parameters.html](https://docs.kernel.org/gpu/amdgpu/module-parameters.html)

# To enable AMD Freesync - add `amdgpu.freesync_video=1` parameter to your bootloader and refresh your configuration.

# To reduce stuttering - add `amdgpu.vm_update_mode=3` parameter to your bootloader and refresh your configuration (use only if you have issues)

# To enable AMD HDMI FRL - call first `printf 'amdgpu.dcfeaturemask=0x%x\n' "$(( $(cat /sys/module/amdgpu/parameters/dcfeaturemask) | 0x400 ))"`, this will print out the value for the kernel argument, then add `amdgpu.dcfeaturemask=the output of the command above`