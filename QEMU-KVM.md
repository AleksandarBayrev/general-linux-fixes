# QEMU/KVM Tips
* Install `qemu-full` `libvirt` `virt-manager` `dnsmasq` `swtpm` for optimal compatibility.
# After installation run `sudo systemctl enable --now libvirtd`

# For Fedora install `Virtualization` group

# Note - if you want to use bridge networking do this
* Set your device name (get it from the terminal via `ip addr` for example)
<img src="howto-bridge.png" />

# If there is such error appearing while trying ot pass through an USB device:
<img src="usb-passthrough-kvm-error.png">

* Do this: `sudo usermod -aG libvirt,qemu,kvm $YOUR_USER` and reboot
* Add two USB Redirectos per VM if you want to add a device
* Set Display to `Spice` if you want to do passthrough of USB devices

# To limit network bandwidth - open the NIC's XML configuration and append something like this
```xml
<bandwidth>
    <inbound average="6000" peak="6000" burst="6000"/>
    <outbound average="6000" peak="6000" burst="6000"/>
</bandwidth>
```