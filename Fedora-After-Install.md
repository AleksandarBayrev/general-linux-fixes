# After installation of Fedora

## Remove zram-generator (if using a separate swap partition)
* Run `sudo dnf remove zram-generator-defaults zram-generator`

## Base tools
* Install groups `Multimedia`, `Development Tools` via `sudo dnf group install YOUR_GROUP`
* Install `rpmconf`, `dnf-plugin-system-upgrade` and `remove-retired-packages`
## How to upgrade
* Install `system-upgrade` using the command `sudo dnf install dnf-plugin-system-upgrade`
* Use the command like this `sudo dnf system-upgrade download --releasever=YOUR_VERSION` (eg. `sudo dnf system-upgrade download --releasever=37`)
* After the update has been downloaded - `sudo dnf system-upgrade reboot` and wait for the operation to complete.
## After upgrade
* Run `sudo remove-retired-packages YOUR_PREVIOUS_VERSION` to remove old packages not needed after the update. 
* Run `sudo rpmconf -a` to update RPM configurations after upgrade.
 
## After kernel upgrade
* It is recommended after running `dnf update` to run `sudo akmods-shutdown` to rebuild kernel modules and then reboot.

## Running in VMware
* Issue noticed on Fedora 37 - sound is choppy, to resolve it: `sudo dnf install pulseaudio --allowerasing`