# Prerequisites
* Install `docker`/`podman` and `distrobox` (Fedora example: `sudo dnf install docker distrobox` `sudo dnf install podman distrobox`)

# Commands
* `distrobox create --name $YOUR_BOX_NAME$ --image $YOUR_IMAGE$` to create a container.
* `distrobox enter $YOUR_NAME$` to enter the container.
* Use `distrobox-export` inside the container to export an application to the host.
* If you want to use an init system pass `--init` to the parameters (with version 1.5.0+ you can use also the `--additional-packages "systemd libpam-systemd"` to specify what init system you need).

# For containers that you are using you need to install DE CLI tools such as `kde-cli-tools`

# IMPORTANT - If you run a system with NVIDIA GPU - add `--nvidia` parameter when creating a container. Example: `distrobox create --name $YOUR_BOX_NAME$ --image $YOUR_IMAGE$ --nvidia`

# If you don't have sound from your exported container apps - install `pipewire`