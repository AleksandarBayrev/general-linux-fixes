# Instead of publishing self-contained apps to a server, follow `DOTNET-Development-Setup.md` to install .NET
# Install `NVM`
# Install `PM2` (`npm i -g pm2`)
# Start the .NET app from `PM2`
# If problems arise - edit pm2 autostart (`systemctl edit pm2-root --full`) and append these lines
```sh
Environment=DOTNET_ROOT=/root/.dotnet
Environment=DOTNET_ROOT_X64=/root/.dotnet
```
# Run `systemctl daemon-reload`
# Run `systemctl restart pm2-root`
# Run `pm2 restart YOUR_SERVICE --update-env`
# Run `pm2 save`