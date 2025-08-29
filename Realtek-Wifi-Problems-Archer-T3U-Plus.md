# If your WiFi adapter disconnects randomly you can create a `/etc/modprobe.d/99-rtw88_8822bu-blacklist.cof` file with the following content
```ini
blacklist rtw88_8822bu
```
# Run `sudo update-initramfs -u` and restart
