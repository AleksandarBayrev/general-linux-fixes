# To set a higher priority for a repository add these two lines
```ini
cost=1
priority=1
```

## Example:
```ini
[packages-microsoft-com-prod]
name=packages-microsoft-com-prod
baseurl=https://packages.microsoft.com/centos/8/prod
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
sslverify=1
cost=1
priority=1
```