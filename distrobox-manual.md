# Prerequisites
* Install `docker`/`podman` and `distrobox` (Fedora example: `sudo dnf install docker distrobox` `sudo dnf install podman distrobox`)

# Commands
* `distrobox create --name $YOUR_BOX_NAME$ --image $YOUR_IMAGE$` to create a container.
* `distrobox enter $YOUR_NAME$` to enter the container.
* Use `distrobox-export` inside the container to export an application to the host.

# For containers that you are using you need to install DE CLI tools such as `kde-cli-tools`