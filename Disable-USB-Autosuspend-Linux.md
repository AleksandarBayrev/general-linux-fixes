# Open `/etc/default/grub`
# Find `GRUB_CMDLINE_LINUX_DEFAULT` and append to it `usbcore.autosuspend=-1`
## Example row
```ini
GRUB_CMDLINE_LINUX_DEFAULT="quiet usbcore.autosuspend=-1"
```
# Run `sudo update-grub` and restart your PC
# To check if the setting is active run `cat /sys/module/usbcore/parameters/autosuspend`