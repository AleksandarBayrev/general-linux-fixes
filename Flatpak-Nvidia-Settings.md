# Offloading NVIDIA GPU to flatpak applications
* Install `Flatseal` and for each application add these lines (or prepend to the launch options for example in `Steam` or add as env vars in `Lutris`)

```
__GL_SYNC_TO_VBLANK=0
__NV_PRIME_RENDER_OFFLOAD=1
__GLX_VENDOR_LIBRARY_NAME=nvidia
__VK_LAYER_NV_optimus=NVIDIA_only
VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
```