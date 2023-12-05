#!/bin/bash
echo 2501000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
echo 3501000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
echo 1 | sudo tee /sys/devices/system/cpu/cpufreq/boost
