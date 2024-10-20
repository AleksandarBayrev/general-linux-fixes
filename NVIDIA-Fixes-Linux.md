# NVIDIA Fixes Linux

## To use Wayland create a file `/etc/modprobe.d/nvidia.conf` with the following contents
```ini
options nvidia_drm modeset=1
options nvidia_drm fbdev=1
options nvidia NVreg_EnableGpuFirmware=0
```

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

## Fixing black screen when alt+tab on Xorg/Wayland (use if you have this issue only)
* Add this to `/etc/environment` or `$HOME/.profile`

```ini
KWIN_TRIPLE_BUFFER=1
KWIN_USE_BUFFER_AGE=0
```

## To fix flickering (heavy ones) add to `/etc/environment` or `$HOME/.profile`
```bash
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
```

## When a laptop does not have a way to disable integrated GPU (no MUX switch)
* Clone `envycontrol` from GIT, run `sudo ./envycontrol.py --switch nvidia --dm sddm`
* Add to `/etc/environment`
```ini
KWIN_DRM_DEVICES=/dev/dri/card1:/dev/dri/card0
DRI_PRIME=pci-0000_01_00_0
VK_LAYER_NV_optimus=NVIDIA_only
GLX_VENDOR_LIBRARY_NAME=nvidia
```