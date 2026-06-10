# To disable WiFi powersave do this:
* Create `/etc/NetworkManager/conf.d/disable-wifi-powersave.conf` with the following content:
```ini
[connection]
wifi.powersave = 2
```
* Restart `NetworkManager`: `sudo systemctl restart NetworkManager`