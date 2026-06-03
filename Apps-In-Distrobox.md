# If using `Google Chrome` for example via `distrobox` install `pipewire` to have sound in it
# If using Fedora immutable distros and you run Steam/Lutris from a Fedora based container, upgrading the system without recreating a container happens like this:
* Let's say you run Fedora 43, to upgrade to 44 run: `sudo dnf --releasever=44 distro-sync` and then `sudo rpmconf -a`