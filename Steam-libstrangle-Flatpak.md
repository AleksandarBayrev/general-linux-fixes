# Steam libstrangle Flatpak
## First - clone `libstrangle` from [https://gitlab.com/torkel104/libstrangle](https://gitlab.com/torkel104/libstrangle)
## Build and install it (use `distrobox` for easier dependecy management)
## Use `Flatseal` to give access to all `system libraries, executables and static data`
## In the `Environment Variables` section in `Flatseal` find `PATH` and add to it this: `/run/host/usr/local/bin`, example: `PATH=/app/bin:/app/utils/bin:/usr/bin:/run/host/usr/local/bin`
## Add another `Environment Variable`: `LD_PRELOAD=/run/host/usr/local/lib/libstrangle/lib64/libstrangle.so`
## That's it!