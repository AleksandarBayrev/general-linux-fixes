# Add this to kernel parameters `/etc/default/grub` - `amd_pstate=guided`
# Reboot PC
# Execute the following commands
````bash
#!/bin/bash
echo 2501000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
echo 2501000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
````
