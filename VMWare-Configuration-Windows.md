# How to configure Windows 11 VM with 3D acceleration on Windows
* `Disable Memory Page Trimming (very important for performance)`
* Enable `3D Acceleration` and give desired VRAM
* Run `bcdedit /set hypervisorlaunchtype off` in command prompt to speed up the VM.
* Disable `Core Isolation`
* Remove `Hyper-V` and `Windows Sandbox` or other related features.