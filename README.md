# fedora-fixes
Fedora fixes

## prime-run
* Copy prime-run and prime-run-novsync to /bin and chmod +x both executables.

## install-vmware-modules.sh
* This script fixes the build of VMware modules on Fedora

## disable-turbo-boost.service
* This service disables turbo boost (please check if /sys/devices/system/cpu/cpufreq/boost is present and then copy the service to /etc/systemd/system and enable it using sudo systemctl enable --now disable-turbo-boost.service