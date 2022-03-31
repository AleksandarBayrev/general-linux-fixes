#!/bin/bash
sudo CPATH=/usr/src/kernels/$(uname -r)/include/linux vmware-modconfig --console --install-all