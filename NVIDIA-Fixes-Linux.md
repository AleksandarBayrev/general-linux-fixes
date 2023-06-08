# NVIDIA Fixes Linux

## Fixing sleep/hibernation

* 1. Copy `nvidia-resume.service`, `nvidia-suspend.service`, `nvidia-hibernate.service` to `/etc/systemd/system
* 2. Copy `nvidia-sleep.sh` to `/usr/bin`
* 3. Add new file `nvidia-power-management.conf` to `/etc/modprobe.d` with the following content:
```
options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/tmp/nvidia
```
* 4. Enable services and restart your PC

## Fixing KWin crashes
* Stop compositor on startup via Compositing -> `Enable on startup` should be unchecked
