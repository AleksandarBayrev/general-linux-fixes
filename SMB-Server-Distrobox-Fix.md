# If running a Samba server inside a container do this:
* Edit smb.service file and add this to it:
```ini
ExecStartPre=/usr/bin/mkdir -p /run/samba
```
* Run `sudo systemctl daemon-reload` and `sudo systemctl restart smb`