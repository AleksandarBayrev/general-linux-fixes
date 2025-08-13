# Remove `speech-dispatcher` to remove HDMI crackling
# Add `use_ucm=0 tsched=0` to `load-module module-udev-detect` in `/etc/pulse/default.pa` to fix crackling sound.
# Comment out `load-module module-suspend-on-idle`, end result: `#load-module module-suspend-on-idle`
# Create `snd-hda-intel.conf` in `/etc/modprobe.d` with the following content:
````ini
options snd_hda_intel snoop=0
options snd_hda_intel power_save=0
````
# And run `sudo update-initramfs -u`