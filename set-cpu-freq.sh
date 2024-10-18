#!/bin/bash
sudo cpupower frequency-set -d 2.5GHz -u 2.5GHz -g powersave # or performance

# If using amd_pstate=passive use this script (comment out the line above and uncomment this)
# If you use a speed higher than base clock (in range of turbo boost, let's say base clock is 2.5GHz and turbo boost is up to 5.2GHz, but you want 4.0GHz - do not uncomment the line below)
# echo 0 | sudo tee /sys/devices/system/cpu/cpufreq/boost 