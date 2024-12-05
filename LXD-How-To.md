# How to use LXD
## Installation
* Use `snap` to install it: `sudo snap install lxd`
* Run `lxd init`
* In `firewalld` create a new zone `lxd`
* Select only `lxdbr0` into `lxd` zone in `firewalld`
* Add `dhcp`, `dhcpv6`, `dns` into `lxd` zone
## How to set static IP for container
* First add an override: `lxc config device override YOUR_CONTAINER eth0`
* Then unset the active IP: `lxc config device unset YOUR_CONTAINER eth0 ipv4.address`
* Add a new IP: `lxc config device set YOUR_CONTAINER eth0 ipv4.address YOUR_NEW_IP`
* There is a predefined firewalld xml file in `firewalld-config-backup` GIT repo
## How to expose ports from containers
* Add port forward in `firewalld` from host to guest - for example your host IP is 1.2.3.4, and your guest is 1.1.1.1, service port is 9090, you need to expose the port on guest (whatever you want) and forward it to 1.1.1.1:9090