# If using `Google Chrome` for example via `distrobox` install `pipewire` to have sound in it
# If you want to use Fedora - setup the container like this:
`distrobox create --name gaming --image fedora:44 --volume MOUNT_POINT_DRIVE:MOUNT_POINT_DRIVE`, example: `distrobox create --name gaming --image fedora:44 --volume /var/mnt/OtherStuff:/var/mnt/OtherStuff`
# If using Fedora immutable distros and you run Steam/Lutris from a Fedora based container, upgrading the system without recreating a container happens like this:
* Let's say you run Fedora 43, to upgrade to 44 run: `sudo dnf --releasever=44 distro-sync` and then `sudo rpmconf -a`
* Then run `steam` and `lutris` from the command line first to see if there are some missing commands. Mandatory packages to install before that: `lsb_release` `xrandr` `pulseaudio-utils` `pipewire` `pciutils`