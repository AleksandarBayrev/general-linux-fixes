# If you are running a headless server or want more control, the standard tool for APC devices is apcupsd (APC UPS Daemon). It is lightweight, reliable, and specifically designed for APC hardware.

## Here is the quick setup guide (assuming a Debian/Ubuntu-based system, but the config is similar for CentOS/RedHat):
1. Install the software

Open your terminal and run:
```sh
sudo apt update
sudo apt install apcupsd
```

2. Edit the configuration

You need to tell the software you are using a USB cable. Open the config file:

```sh
sudo nano /etc/apcupsd/apcupsd.conf
```

Find these specific lines and change them to match the values below. (Use Ctrl+W to search in Nano):

```text
UPSCABLE usb
UPSTYPE usb
DEVICE
# (Note: For USB, leave DEVICE blank! Do not point it to /dev/tty...)
```

Ensure BATTERYLEVEL and MINUTES are set to your preference (defaults are usually safe).

3. Enable and Start the Service

Save the file (Ctrl+O, Enter) and exit (Ctrl+X). Then restart the service:

```sh
sudo systemctl restart apcupsd
```

4. Verify it is talking to the UPS

Run this command to see the live status:
```sh
apcaccess
```

# Success: You should see a large block of text showing STATUS: ONLINE, your battery charge percentage, time left, and model number.