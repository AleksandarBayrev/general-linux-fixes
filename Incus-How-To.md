# How to use Incus
## Installation
* Use your package manager to install it, check the documentation [here](https://linuxcontainers.org/incus/docs/main/installing/)
* Run `sudo incus admin init`
* In `firewalld` create a new zone `incus`
* Select only `incusbr0` into `incus` zone in `firewalld`
* Add `dhcp`, `dhcpv6`, `dns` into `incus` zone
## How to generate certificates
* Generate certificate and key: `openssl req -new -newkey rsa:4096 -x509 -days 36500 -nodes -sha256 -out YOUR_CERT.crt -keyout YOUR_CERT.key` (36500 days validity (~100 years))
* Register the certificate in the server: `incus config trust add-certificate ./YOUR_CERT.crt`
* Generate pkcs12 certificate for web browsers: `openssl pkcs12 -export -out YOUR_CERT.p12 -inkey YOUR_CERT.key -in YOUR_CERT.crt`
* Add it to your browser
## How to set static IP for container
* First add an override: `incus config device override YOUR_CONTAINER eth0`
* Then unset the active IP: `incus config device unset YOUR_CONTAINER eth0 ipv4.address`
* Add a new IP: `incus config device set YOUR_CONTAINER eth0 ipv4.address YOUR_NEW_IP`
* There is a predefined firewalld xml file in `firewalld-config-backup` GIT repo
## How to expose ports from containers
* Add port forward in `firewalld` from host to guest - for example your host IP is 1.2.3.4, and your guest is 1.1.1.1, service port is 9090, you need to expose the port on guest (whatever you want) and forward it to 1.1.1.1:9090
## How to setup SSH in the container
* In `/etc/ssh/sshd_config` set `PermitRootLogin` to yes
* In `/etc/ssh/sshd_config.d/*` check if `PasswordAuthentication` is set to `no`, if so - set it to `yes`