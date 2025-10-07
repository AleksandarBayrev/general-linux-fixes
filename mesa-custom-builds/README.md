# To build `mesa` from source do this:
* Check prerequisites [here](https://docs.mesa3d.org/install.html)
* Download the release
* Unarchive the release and open it in a terminal
* Run `meson setup build64 --libdir lib64 --prefix $HOME/path-to-mesa-build-result -Dbuildtype=release` (change --prefix to your folder)
Example if compiling mesa 25.2.4: `meson setup build64 --libdir lib64 --prefix $HOME/mesa-custom/25.2.4 -Dbuildtype=release`
* Run `meson compile -C build64` to compile it
* Run `sudo meson install -C build64` to install it to the prefix
* Create a `mesa-run` bash script with the following content:
```bash
#!/bin/sh

MESA=$HOME/path-to-mesa-build-result \
LD_LIBRARY_PATH=$MESA/lib64:$MESA/lib:$LD_LIBRARY_PATH \
LIBGL_DRIVERS_PATH=$MESA/lib64/dri:$MESA/lib/dri \
VK_ICD_FILENAMES=$MESA/share/vulkan/icd.d/radeon_icd.x86_64.json:$MESA/share/vulkan/icd.d/radeon_icd.x86.json \
LIBVA_DRIVERS_PATH=$MESA/lib64/dri:$MESA/lib/dri \
VDPAU_DRIVER_PATH=$MESA/lib64/vdpau \
OCL_ICD_VENDORS=$MESA/etc/OpenCL/vendors/rusticl.icd \
    exec "$@"
```
* Copy it to `/bin`
* Use `mesa-run your-executable` to point to the newer `mesa`