# First of all - create a bash script somewhere with the following content
```bash
#!/bin/bash
for i in $(podman ps -a | grep -v 'CONTAINER ID' | awk '{print $1}')
do
	podman stop $i
done
```

# Then create a service for systemd with the following content
```ini
[Unit]
Description=Stops all Podman containers
DefaultDependencies=no
Before=shutdown.target

[Service]
Type=oneshot
ExecStart=/path/to/your/bash/script.sh
TimeoutStartSec=0

[Install]
WantedBy=shutdown.target
```