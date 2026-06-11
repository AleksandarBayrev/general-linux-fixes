# To disable WiFi powersave do this:
* Create `/etc/NetworkManager/conf.d/disable-wifi-powersave.conf` with the following content:
```ini
[connection]
wifi.powersave = 2
```
* Restart `NetworkManager`: `sudo systemctl restart NetworkManager`
* Check if the setting is applied like this:
```bash
iw dev # lists all WiFi devices, example output

: <<'END_COMMENT'
#phy#0
        Unnamed/non-netdev interface
                wdev 0x2
                addr 90:de:80:b2:52:4d
                type P2P-device
                txpower 3.00 dBm
        Interface wlp2s0f0u10
                ifindex 3
                wdev 0x1
                addr de:fc:ab:71:d0:a6
                ssid Archer AX12 5G
                type managed
                channel 44 (5220 MHz), width: 80 MHz, center1: 5210 MHz
                txpower 3.00 dBm
                multicast TXQ:
                        qsz-byt qsz-pkt flows   drops   marks   overlmt hashcol tx-bytes        tx-packets
                        0       0       0       0       0       0       0       0               0
END_COMMENT

# Then in that case the interface name is wlp2s0f0u10
iwctl dev wlp2s0f0u10 get power_save

: <<'END_COMMENT'
Example output:
aleksandar@ryzen9-ws:~/GIT/general-linux-fixes$ iw dev wlp2s0f0u10 get power_save
Power save: off
END_COMMENT
```