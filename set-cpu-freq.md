# Add this to kernel parameters `/etc/default/grub` - `amd_pstate=guided`
# Reboot PC
# Check `set-cpu-freq.sh` script, configure it, copy it to `/bin` and create a startup service in `/etc/systemd/system`
````ini
[Unit]
Description=Set-CPU-Freq

[Service]
ExecStart=sudo /bin/set-cpu-freq.sh

[Install]
WantedBy=multi-user.target
````