# Fix Ubuntu 22.04 (and probably later versions) sound problems
* Disable module `module-suspend-on-idle` in /etc/pulse/default.pa (comment out the line `load-module module-suspend-on-idle`)
* Install newer kernel via [ubuntu-mainline-kernel.sh](https://github.com/pimlie/ubuntu-mainline-kernel.sh) script