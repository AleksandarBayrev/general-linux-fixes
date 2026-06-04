# If using `Google Chrome` for example via `distrobox` install `pipewire` to have sound in it
# If you want to use Fedora - setup the container like this:
* First create the home: `mkdir -p ~/.distrobox-homes/gaming`
* Then run `distrobox create --name gaming --image registry.fedoraproject.org/fedora-toolbox:YOUR_VERSION --volume /var/MOUNT_POINT_DRIVE:/NAME_OF_DRIVE:rw`, example: `distrobox create --name gaming --image registry.fedoraproject.org/fedora-toolbox:44 --volume /var/mnt/OtherStuff:/OtherStuff:rw`
# IMPORTANT!!! - when selecting installation path make sure it matches the /NAME_OF_DRIVE you passed through (the UI will show it), example: `/OtherStuff/SteamLibrary`, `/OtherStuff/Heroic`, etc.
# If using Fedora immutable distros and you run Steam/Lutris from a Fedora based container, upgrading the system without recreating a container happens like this:
* Let's say you run Fedora 43, to upgrade to 44 run: `sudo dnf --releasever=44 distro-sync` and then `sudo rpmconf -a`
* Then run `steam` and `lutris` from the command line first to see if there are some missing commands. Mandatory packages to install before that: `lsb_release` `xrandr` `pulseaudio-utils` `pipewire` `pciutils`
* For Steam after setting up everything - if you have previous runners (Proton Experimental, Steam Linux Runtime, etc.) - run file verification on all of them to avoid problems.