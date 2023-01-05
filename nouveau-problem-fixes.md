# If you receive kernel errors for nouveau create blacklist-nouveau.conf in /etc/modprobe.d
* Contents:

```
blacklist nouveau
options nouveau modeset=0
```
