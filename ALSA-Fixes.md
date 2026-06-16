# How to fix auto mute for front panel
* [https://askubuntu.com/questions/131857/alsamixer-howto-disable-auto-mute-mode](https://askubuntu.com/questions/131857/alsamixer-howto-disable-auto-mute-mode)
* or TLDR - run `alsamixer` and disable `Auto Mute` and then run `sudo alsactl store`

<img src="./alsa-fix.png">

# How to fix audio cracking
* Create a directory in `$HOME/.config/wireplumber/wireplumber.conf.d` (create both `wireplumber` and `wireplumber.conf.d` if missing)
* Create a file `01-disable-suspension.conf` with the following content:
```text
monitor.alsa.rules = [
  {
    matches = [
      {
        # This matches all ALSA devices
        node.name = "~alsa_output.*"
      }
    ]
    actions = {
      update-props = {
        session.suspend-timeout-seconds = 0
        session.suspend-on-idle         = false
        node.suspend-on-idle            = false
        node.pause-on-idle              = false
        session.idle-timeout-seconds    = 0
      }
    }
  }
]
```
* Only if the steps above don't work for pipewire/wireplumber do the stuff below
* Then to disable the driver power savings use `lsmod | grep snd` to see what device you have (most of the motherboards are with `snd_hda_intel`)
* Create a file in `/etc/modprobe.d` (example: `/etc/modprobe.d/snd_hda_intel_no_powersave.conf`) with the following content
```text
options snd_hda_intel power_save=0 power_save_controller=N
```
and restart your PC.

# If you want separate sample rate for an output device do this:
* Create a separate file for the device you want to override, e.g. I bought a SMSL SU-1 DAC that supports 768kHz rate, `$HOME/.config/wireplumber/wireplumber.conf.d/01-smsl-sample-rate.conf` with the following content:
```text
monitor.alsa.rules = [
  {
    matches = [
      {
        # This matches SMSL
        node.name = "~alsa_output.usb-SMSL_SMSL_USB_AUDIO-00.*"
      }
    ]
    actions = {
      update-props = {
        audio.rate = 768000
        audio.format = "S32LE"
      }
    }
  }
]
```
* For other device names use pactl list sinks short, example command output:
```text
68      alsa_output.usb-SMSL_SMSL_USB_AUDIO-00.analog-stereo    PipeWire        s32le 2ch 768000Hz      RUNNING
73      alsa_output.pci-0000_0c_00.4.analog-stereo      PipeWire        s32le 2ch 192000Hz      IDLE
```
You can tell which is the device name