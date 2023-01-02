# Prerequisites
* Install `docker` and `distrobox` (Fedora example: `sudo dnf install docker distrobox`)

# Commands
* `distrobox create --name $YOUR_BOX_NAME$ --image $YOUR_IMAGE$` to create a container.
* `distrobox enter $YOUR_NAME$` to enter the container.
* Use `distrobox-export` inside the container to export an application to the host.