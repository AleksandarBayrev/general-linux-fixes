# NVIDIA Fixes Linux

## Fixing sleep/hibernation (use fixes only if you have problems, newer drivers could be better OOTB and this will not be needed)

* 1. Copy `nvidia-resume.service`, `nvidia-suspend.service`, `nvidia-hibernate.service` to `/etc/systemd/system
* 2. Copy `nvidia-sleep.sh` to `/usr/bin`
* 3. Add new file `nvidia-power-management.conf` to `/etc/modprobe.d` with the following content:
```
options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/tmp/nvidia
```
* 4. Enable services and restart your PC

## Fixing KWin crashes (use fix only if you have problems, newer drivers could be better OOTB and this will not be needed)
* Stop compositor on startup via Compositing -> `Enable on startup` should be unchecked

## Fixing black screen when alt+tab on Xorg/Wayland
* Add this to `/etc/environment`

```ini
KWIN_TRIPLE_BUFFER=1
KWIN_USE_BUFFER_AGE=0
```

## To use wayland add to `/etc/default/grub` in the command line parameters `rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset=1 initcall_blacklist=simpledrm_platform_driver_init`