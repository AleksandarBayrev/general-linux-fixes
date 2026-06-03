# Check `ALSA-Fixes.md`
# For pipewire the general method is this:
## For PipeWire (Modern Standard)

### PipeWire is more flexible because it allows for a "list" of allowed sample rates, preventing unnecessary resampling.

### Create a user config directory:
```sh
mkdir -p ~/.config/pipewire/pipewire.conf.d
```

### Create a file `10-rates.conf`
```sh
touch ~/.config/pipewire/pipewire.conf.d/10-rates.conf
```

### Edit the file: Open it with a text editor (like nano or gedit).

```sh
nano ~/.config/pipewire/pipewire.conf.d/10-rates.conf
```

### Modify the clock rates: Find the context.properties section and look for these lines (remove the # to uncomment them):
```ini
context.properties = {
    # The default rate if nothing specific is playing
    default.clock.rate = 48000 # or whatever you want the default to be
    
    # The rates PipeWire is allowed to dynamically switch between
    default.clock.allowed-rates = [ 44100 48000 88200 96000 192000 ] # You can comment this out if you want a static clock rate
}
```
### Save and Restart: Press Ctrl+O, Enter, and Ctrl+X. Then restart PipeWire:

```sh
systemctl --user restart pipewire
```

# !!!(NOT RECOMMENDED)!!! If you use `wireplumber` with version higher than 0.5 it's easier to do it like this:
* Run `wpctl status` and find `Audio` -> `Sources` -> your device
```text
Audio
 |
 ├─ Sources:
 │  *   65. Family 17h/19h/1ah HD Audio Controller Analog Stereo [vol: 0.24]
 │      72. JBL Tune 720BT                      [vol: 1.00]

```
In this case 65 is the ID
* Run `wpctl inspect 65` and find the property `node.name`
```
* node.name = "alsa_input.pci-0000_06_00.6.analog-stereo"
```
and get the value
* Create a directory `~/.config/wireplumber/wireplumber.conf.d/`
* Create a file named for example `99-sound-config.conf` with the following content (replace node.name with yours) and adjust audio.rate and audio.format (check valid audio formats (S16LE S24LE S32LE))
```ini
monitor.alsa.rules = [
  {
    matches = [
      {
        node.name = "alsa_output.pci-0000_06_00.6.analog-stereo"
      }
    ]
    actions = {
      update-props = {
        audio.rate = 44100,
        audio.format = "S16LE"
      }
    }
  }
]
```

# !!!(NOT RECOMMENDED)!!! OR the legacy variant below
# If you want to change the sample rate - create `/etc/pipewire` directory if missing and copy `/usr/share/pipewire/pipewire.conf` to in, edit the `/etc/pipewire/pipewire.conf` and set `default.clock.rate` to whatever you need and restart your PC

# To check current sample rate and bit depth use `pactl list short sinks`

# If you have any problems with the sound do the things below

# Remove `speech-dispatcher` to remove HDMI crackling
# Add `use_ucm=0 tsched=0` to `load-module module-udev-detect` in `/etc/pulse/default.pa` to fix crackling sound.
# Comment out `load-module module-suspend-on-idle`, end result: `#load-module module-suspend-on-idle` only if the steps above don't work for pipewire/wireplumber
# Create `snd-hda-intel.conf` in `/etc/modprobe.d` with the following content (only if the steps above don't work for pipewire/wireplumber):
````ini
options snd_hda_intel snoop=0
options snd_hda_intel power_save=0
options snd_hda_intel power_save_controller=N
````
# And run `sudo update-initramfs -u`
# Potential fix for audio distortion/stutter on older machines - https://wiki.debian.org/PipeWire#choppy_audio_on_systems_with_high_load