# If you want to change the sample rate - create `/etc/pipewire` directory if missing and copy `/usr/share/pipewire/pipewire.conf` to in, edit the `/etc/pipewire/pipewire.conf` and set `default.clock.rate` to whatever you need and restart your PC

# To check current sample rate and bit depth use `pactl list short sinks`

# If you have any problems with the sound do the things below

# Remove `speech-dispatcher` to remove HDMI crackling
# Add `use_ucm=0 tsched=0` to `load-module module-udev-detect` in `/etc/pulse/default.pa` to fix crackling sound.
# Comment out `load-module module-suspend-on-idle`, end result: `#load-module module-suspend-on-idle`
# Create `snd-hda-intel.conf` in `/etc/modprobe.d` with the following content:
````ini
options snd_hda_intel snoop=0
options snd_hda_intel power_save=0
options snd_hda_intel power_save_controller=N
````
# And run `sudo update-initramfs -u`
