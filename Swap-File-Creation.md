## Create swapfile instead of swap partition (easier to manage/resize/delete)
```bash
sudo dd if=/dev/zero of=/swapfile bs=1M count=16k # example for 16 GB
sync
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
cp /etc/fstab /etc/fstab.back
echo "/swapfile none swap sw 0 0" >> /etc/fstab 
```