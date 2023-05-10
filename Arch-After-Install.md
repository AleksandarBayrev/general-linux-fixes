# Install AppIndicator if you are running GNOME

# If icons are missing check the .desktop file in /etc/xdg/autostart and remove NotShowIn line

# If you are using NVIDIA Hybrid Laptop - install envycontrol

# If you have problems with sleeping on Arch using envycontrol
* Remove `options nvidia "NVreg_DynamicPowerManagement=0x02"` and `options nvidia NVreg_PreserveVideoMemoryAllocations=1`

# Install `libstrangle` to limit framerate (example: `strangle 60 glxgears`)

# To downgrade packages install `downgrade` from AUR, and to use it - `sudo downgrade MY_PACKAGE`