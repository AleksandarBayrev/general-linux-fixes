# Install `Arch Linux` in a distrobox container
# Install `Steam`, `Lutris` in the container and export them via `distrobox-export --app appname` and `distrobox-export --bin /location/to/binary -ep ~/.local/bin`
# Download AppImages for `Heroic Games Launcher`, `Duckstation`, `PCSX2`
# Run AppImages directly from the container like this:
```bash
/usr/bin/distrobox-enter -n CONTAINER_NAME -- /path/to/executable OPTIONAL_ARGS
```
example for `Steam`:
```bash
/usr/bin/distrobox-enter -n archws -- /usr/bin/steam %U
```
where `archws` is the name of the container 
# Use `Flatpak` for `Bottles`