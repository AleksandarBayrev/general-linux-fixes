Here is your updated and optimized step-by-step guide for openSUSE MicroOS with a separate /home drive. This version implements TMPDIR redirection (preventing space/mktemp issues on the default tmpfs /tmp) and bind-mounting /home directly inside the transactional shell so you can execute the .run files straight from your ~/Downloads directory without copying them.

# IMPORTANT !!! - after update and reboot - run flatpak update to update the flatpak drivers
Phase 1: Install Build Dependencies & Sync Kernel

Install DKMS, build tools, and matching kernel and header packages into a new transactional snapshot.

    Install the required packages:
    Bash

    sudo transactional-update pkg install dkms kernel-default kernel-default-devel gcc make

    Enable DKMS service
    sudo systemctl enable dkms.service

    Reboot into the new snapshot so your running kernel (uname -r) matches the newly installed kernel-default-devel headers:
    Bash

    sudo reboot

Phase 2: Configure TMPDIR Redirection & Blacklist Nouveau

Because NVIDIA and CUDA .run installers extract large temporary files, using the default in-memory /tmp (tmpfs) can cause "No space left on device" or extraction errors. We will redirect TMPDIR to a dedicated staging folder on your /home drive.

    Create a temporary extraction directory on your /home drive:
    Bash

    mkdir -p /var/tmp/dkms
    mkdir -p /var/lib/nvidia

    Blacklist the open-source nouveau driver:
    Bash

    echo "blacklist nouveau" | sudo tee /etc/modprobe.d/nvidia-blacklist-nouveau.conf

Phase 3: Install NVIDIA Driver with DKMS

Enter a transactional shell, bind-mount /home so your files are accessible, and run the installer using the redirected TMPDIR.

    Open the transactional shell:
    Bash

    sudo transactional-update shell

    Bind-mount your /home partition inside the shell environment so your download files are accessible:
    Bash

    mount --bind /home /home

    Run the NVIDIA driver .run installer directly from your ~/Downloads folder with TMPDIR redirected, --dkms, and the explicit --kernel-source-path flag (Replace <driver-version> with your actual filename, and add -m=kernel-open if you want the open-source kernel modules for Turing/RTX 20-series and newer), do not click rebuild initramfs, check dracut step below:
    Bash

    TMPDIR=/var/tmp sh /home/$USER/Downloads/NVIDIA-Linux-x86_64-<driver-version>.run --dkms

    Verify DKMS registered the module successfully:
    Bash

    dkms status

    (You should see nvidia/<version>, <kernel-version>, x86_64: installed).

Phase 4: Install the CUDA Toolkit (Inside the Shell) (OPTIONAL)

While still inside the same transactional shell, install the CUDA Toolkit without overwriting your newly installed driver.

    Run the CUDA .run installer using --toolkit and the redirected TMPDIR:
    Bash

    TMPDIR=/home/$USER/nv-tmp sh /home/$USER/Downloads/cuda_<cuda-version>_linux.run \
      --silent \
      --toolkit \
      --installpath=/usr/local/cuda

    Configure system-wide CUDA environment variables so all users and tools find nvcc and CUDA libraries:
    Bash

    cat << 'EOF' > /etc/profile.d/cuda.sh
    export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
    EOF

    Regenerate initramfs so nouveau stays blacklisted on boot and NVIDIA modules load cleanly:
    Bash

    dracut --regenerate-all --force

    Exit the transactional shell (this commits your new snapshot):
    Bash

    exit

Phase 5: Clean Up, Secure Boot (If Applicable), & Reboot

    Clean up the temporary extraction directory on /home:
    Bash

    rm -rf ~/nv-tmp

    Enroll the DKMS MOK key (Only if Secure Boot is enabled):
    Bash

    sudo mokutil --import /var/lib/dkms/mok.pub

    (Enter a one-time password when prompted, then enroll the key in the blue MOK Manager screen during system reboot).

    Reboot into your new MicroOS snapshot:
    Bash

    sudo reboot

    Verify your installation after reboot:
    Bash

    nvidia-smi
    nvcc --version

How to Update When MicroOS Upgrades Your Kernel

When transactional-update installs a new Linux kernel during regular system updates, run these commands after rebooting into the new kernel to rebuild the DKMS module inside a new snapshot:
Bash

sudo transactional-update shell
dkms autoinstall -k $(uname -r)
dracut --regenerate-all --force
exit
sudo reboot

# !!! IMPORTANT !!! - `sudo dkms status` won't show anything if you're running it inside MicroOS, if it's empty in `sudo transactional-update shell` then you have a problem, otherwise it should be fine.