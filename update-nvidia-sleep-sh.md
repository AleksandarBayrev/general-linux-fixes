# How to fix sleep issues with NVIDIA hybrid graphics
* Edit /usr/bin/nvidia-sleep.sh (or call whereis nvidia-sleep.sh to determine the exact location)
* Add exit 0 after #!/bin/bash so the file will look like this:
```bash
#!/bin/bash

exit 0

if [ ! -f /proc/driver/nvidia/suspend ]; then
    exit 0
fi

RUN_DIR="/var/run/nvidia-sleep"
XORG_VT_FILE="${RUN_DIR}"/Xorg.vt_number

PATH="/bin:/usr/bin"

case "$1" in
    suspend|hibernate)
    ...
```