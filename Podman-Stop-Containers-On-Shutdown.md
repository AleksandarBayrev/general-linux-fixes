# First of all - create a bash script somewhere with the following content
```bash
#!/bin/bash
function getContainers() {
        echo $(podman ps | grep -v 'CONTAINER ID' | awk '{print $1}');
}
containers=$(podman ps | grep -v 'CONTAINER ID' | awk '{print $1}')
length=${#containers}
echo $length

while [ "$length" -gt "0" ]
do
        for i in $containers
        do
                podman stop $i
        done
        containers=$(podman ps | grep -v 'CONTAINER ID' | awk '{print $1}')
        length=${#containers}
done
```

# Then create a service for systemd with the following content
```ini
[Unit]
Description=Stops all Podman containers
DefaultDependencies=no
Before=shutdown.target

[Service]
Type=exec
ExecStart=/path/to/your/bash/script.sh
TimeoutStartSec=0

[Install]
WantedBy=shutdown.target
```