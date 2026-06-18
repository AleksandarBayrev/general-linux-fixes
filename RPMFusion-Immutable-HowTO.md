# If you use Fedora Immutable distros, installation of RPM Fusion is a bit specific

## Procedure
* To install the versioned Free and Nonfree RPM Fusion repos:
```bash
$ rpm-ostree install \
     https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
     https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    $ systemctl reboot
```

* Reboot, this step now is mandatory - you must replace the versioned RPM Fusion repos that were previously installed with the unversioned repos in order not to break system upgrades:
```bash
$ rpm-ostree update \
     --uninstall rpmfusion-free-release \
     --uninstall rpmfusion-nonfree-release \
     --install rpmfusion-free-release \
     --install rpmfusion-nonfree-release
$ systemctl reboot
```

* Reboot again and you're ready to use it.

# For NVIDIA GPUs install the default packages: `akmod-nvidia` and `xorg-x11-drv-nvidia-cuda`, or if you want to lock driver versions, examplefor 580 series driver: `akmod-nvidia-580xx xorg-x11-drv-nvidia-580xx-cuda`