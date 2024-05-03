#!/bin/bash
sudo cpupower frequency-set -d 2.5GHz -u 2.5GHz -g performance

# If using amd_pstate=passive use this script (comment out the line above and uncomment this)
# echo 0 | sudo tee /sys/devices/system/cpu/cpufreq/boost 