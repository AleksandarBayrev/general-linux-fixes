# Add this to kernel parameters `/etc/default/grub` - `amd_pstate=guided` (or `amd_pstate=passive`)
# Reboot PC
# Check `set-cpu-freq.sh` script, configure it, copy it to `/bin` (or `/usr/local/bin` for openSUSE MicroOS) and create a startup service in `/etc/systemd/system`
````ini
[Unit]
Description=Set-CPU-Freq

[Service]
ExecStart=/bin/set-cpu-freq.sh # for openSUSE MicroOS it's /usr/local/bin/set-cpu-freq.sh

[Install]
WantedBy=multi-user.target
````
