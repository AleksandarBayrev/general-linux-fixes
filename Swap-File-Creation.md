## If using immutable distro - create the file at this location: `/var/swapfile` and do the steps above:
```bash
sudo btrfs filesystem mkswapfile --size 32G /var/swapfile # example for 32GB
sync
chmod 600 /var/swapfile
mkswap /var/swapfile
swapon /var/swapfile
```

* `/etc/fstab`
```text
/var/swapfile none swap sw 0 0
```

## Otherwise create swapfile instead of swap partition (easier to manage/resize/delete)
```bash
sudo dd if=/dev/zero of=/swapfile bs=1M count=16k # example for 16 GB
sync
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
```
## Add it to `/etc/fstab`
```text
/swapfile none swap sw 0 0
```