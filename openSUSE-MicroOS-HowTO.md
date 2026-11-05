# Install openSUSE MicroOS — KDE Plasma + systemd-boot + optional Discover updates

Personal installation and maintenance checklist, based on our MicroOS discussions and the supplied Fedora checklist. Checked against current documentation on **5 November 2026**.

Target setup: **UEFI, systemd-boot, Btrfs with a read-only root, transactional-update for host packages, KDE Plasma, Flatpak, and Distrobox**. Preserve your existing separate ext4 `/home` drive.

The main command examples use **Zypper/transactional-update**. **PackageKit is optional**, for users who want host updates through Discover; see section 13 for that alternative. Flatpak support in Discover works without PackageKit.

This describes your customized **MicroOS + KDE** setup. MicroOS itself is presented as a container/server OS; Kalpa is the separate Plasma desktop project derived from it. Installer choices and support policies differ. In particular, do not apply this custom partitioning checklist to a Kalpa installer that requires its own automatic layout. [MicroOS downloads](https://get.opensuse.org/microos/) · [Kalpa documentation](https://kalpadesktop.org/documentation/)

# !!! IMPORTANT !!! — Read these before installing

- **Select systemd-boot in the installer.** Configure partitioning first, then recheck the bootloader selection before starting installation.
- **Choose your host-update method.** Use “MicroOS via Zypper” for the main instructions. Optionally choose “MicroOS via PackageKit” for Discover host updates, as described in section 13.
- **Keep the installer's transactional Btrfs layout.** Preserve `/.snapshots` and the writable data subvolumes, especially `/var`.
- **Do not format your existing `/home` drive.** Check the partitioning summary, device identifiers, and format flags before confirming installation.
- **Host changes need a reboot.** Finish a transaction, reboot into it, then make the next host change. If intentionally combining changes before reboot, use `--continue` as shown below.
- **Disable unattended host updates if you want manual updates.** Disabling automatic updates in Discover alone does not disable the system's transactional-update timer.
- **systemd-boot uses `sdbootutil` and `/etc/kernel/cmdline` here.** Fedora's `ostree kargs`, `grubby`, and GRUB configuration commands do not apply.
- **Snapshots protect OS state; keep separate backups of personal data, VMs, containers, and the EFI System Partition.**

# IMPORTANT!!! — Check your existing notes

Keep these references from your original checklist nearby. Their distribution-specific commands still need adapting to openSUSE:

- `AMD-GPUs-Linux-Control-Panel.md` and `Hostname-Important-Info.md`.
- `KDE-Settings.md`, `Apps-In-Distrobox.md`, and `flatpaks-to-install.txt`.
- `Linux-Firmware-For-Hardware.md`, `ALSA-Fixes.md`, and `Sound-Fixes-Linux.md`.
- `NetworkManager-Linux-WiFi-Powersave.md` and `Disable-USB-Autosuspend-Linux.md`.
- `Gaming-Linux-HowTO.md`, `Gaming-Software.md`, `NTSYNC-HowTO.md`, and `Gamescope-Notes.md`.
- `Fix-Linux-Sleep.md`, `cpupower-Fixes.md`, and `Thinkpad-Fingerprint-Scanner-Linux-HowTO.md`, where relevant.
- `Linux-UPS-APC-HowTO.md` if using your APC UPS.
- `Swap-Configuration.md` and `Swap-File-Creation.md` for swap settings and swapfile creation.
- `NVIDIA-Fixes-Linux.md` if using an NVIDIA GPU and troubleshooting driver, display, or suspend issues.
- `DOTNET-Development-Setup.md` if setting up .NET development.
- `OpenVPN-Configuration-Linux.md` if importing an OpenVPN configuration.
- `config-fastfetch/README.md` if Fastfetch does not detect your monitors correctly.
- `Linux-Gaming-Notes.md` in `random-important-stuff` for additional gaming tips, including older games.

# 1. Prepare the installer and firmware

Download the current **MicroOS installation ISO** for your architecture from the [official download page](https://get.opensuse.org/microos/). For your desktop and ThinkPads, use x86_64. Verify the provided checksum/signature and write the ISO to a USB stick with an image-writing tool.

In firmware settings:

- Boot the USB in **UEFI mode**; use a GPT partition table on the OS drive.
- Disable legacy/CSM boot for this installation.
- Enable hardware virtualization if you intend to use KVM.
- Keep Secure Boot if the selected image and its signed boot chain support your configuration. Do not disable it merely because you selected systemd-boot.

# 2. Partitioning — preserve the MicroOS defaults

Use a separate OS SSD where practical, as in your existing plan. Keep the guided MicroOS layout and only make changes you need.

| Area | Setup for this guide |
| --- | --- |
| EFI System Partition | FAT32, normally mounted at `/boot/efi`; **4 GiB is your planned allocation**, not a universal minimum |
| `/` | Btrfs, transactional layout, read-only during normal operation |
| `/.snapshots` | Preserve the installer-created snapshot arrangement |
| `/var` | Writable data area excluded from root rollback; allow room for containers and VM disks |
| `/home` | Reuse the existing ext4 drive without formatting |
| `/boot` | Keep the MicroOS proposal; do not copy the separate 8 GiB ext4 `/boot` layout from the Fedora checklist |

systemd-boot stores boot assets on the ESP, or a configured XBOOTLDR partition. Multiple retained kernels and snapshot entries can consume space there. Check ESP free space during maintenance.

If the installer uses a different home path or a `/home` symlink, preserve that arrangement and attach the existing home filesystem at the corresponding target. Avoid duplicate mounts for the same home data.

An unused home subvolume hidden underneath an ext4 mount does not provide snapshots of that ext4 filesystem. Do not remove subvolumes just to simplify the list.

Sources: [transactional filesystem layout](https://kubic.opensuse.org/documentation/transactional-update-guide/tu-setup.html) · [openSUSE boot-entry architecture](https://github.com/openSUSE/sdbootutil/blob/main/ARCHITECTURE.md).

# 3. Select systemd-boot and your update method

At the installer's final summary:

1. Check the partitioning proposal and confirm that `/home` will **not** be formatted.
2. Open bootloader settings and select **Systemd Boot / systemd-boot**.
3. Select **MicroOS via Zypper** for the main command examples, or optionally **MicroOS via PackageKit** for Discover host updates. Use one primary host-update workflow; see section 13.
4. Select KDE Plasma if the installer offers an appropriate desktop selection. Otherwise add it after installation using section 6.
5. Create your user and configure administrator authentication. Record the root password if the installer uses it for administration.

A root password does not by itself grant a user unrestricted sudo access; the sudo policy controls that. Test `sudo -v` after installation.

Do not taboo MicroOS packages on this system. Your separate Tumbleweed branding discussion concerned a different installation goal.

The official MicroOS systemd-boot installation example also changes partitioning before selecting the bootloader: [installation workflow](https://microos.opensuse.org/blog/2024-09-03-quickstart-fde-yast2/).

# 4. First boot — verify the actual installation

Run these **on the host**, outside Distrobox:

```bash
cat /etc/os-release
findmnt -no SOURCE,FSTYPE,OPTIONS /
findmnt -T /var
findmnt -T /home
readlink -f /home
findmnt /boot/efi
sudo snapper -c root list
sudo btrfs subvolume get-default /
sudo bootctl status
sudo bootctl list
grep '^LOADER_TYPE=' /etc/sysconfig/bootloader
sudo -v
```

Check that `/` is Btrfs and has `ro` in its mount options, that your home drive is mounted, and that **the currently used bootloader is systemd-boot**. Merely having systemd installed does not establish this; use `bootctl status`.

If `/` is writable, investigate the selected installation role and layout before treating it as the intended MicroOS setup. Adding `ro` to `fstab` alone does not create a complete transactional installation.

# 5. IMPORTANT!!! — Configure manual host updates

For the manual update workflow you wanted, disable automatic staging:

```bash
sudo systemctl disable --now transactional-update.timer
systemctl status transactional-update.service --no-pager
systemctl list-timers --all
```

Stopping the timer does not stop an update service that is already running. Let an active transaction finish before starting another operation.

Edit the administrator configuration, preserving existing entries:

```bash
sudoedit /etc/transactional-update.conf
```

Set or update these assignments:

```ini
UPDATE_METHOD=dup
REBOOT_METHOD=none
```

This selects distribution upgrades and leaves reboots to you. Also inspect any installed `rebootmgr.service` and its policy if you previously enabled automatic reboots. `REBOOT_METHOD=none` controls transactional-update's reboot requests; it does not control every other application.

In KDE/Discover settings, disable automatic installation if enabled. This also applies if you choose the optional PackageKit setup: you can still check and install updates manually through Discover. The custom Zypper notification checker in section 13 can remain enabled when using that route because it checks availability rather than scheduling unattended upgrades.

Sources: [automatic update timer](https://documentation.suse.com/sle-micro/6.1/html/Micro-transactional-updates/transactional-updates.html) · [transactional-update configuration](https://manpages.opensuse.org/Tumbleweed/transactional-update/transactional-update.conf.5.en.html).

# 6. Install KDE Plasma and the Plasma 6 package families

If Plasma is already installed, skip the base desktop installation and use the package-family step below if needed. If you have a minimal MicroOS system, inspect the available patterns:

```bash
zypper search -t pattern kde
```

Where the official repositories provide `kde_plasma`, stage it:

```bash
sudo transactional-update pkg install -t pattern kde_plasma
```

After that command succeeds, continue the pending snapshot to add the login manager and Discover support:

```bash
sudo transactional-update --continue pkg install \
  sddm discover6 discover6-backend-flatpak
```

## Install `kdeplasma6-*` and `plasma6-*`

After the commands above succeed, include both package families in the pending transaction:

```bash
sudo transactional-update --continue pkg install 'kdeplasma6-*' 'plasma6-*'
```

Keep the wildcard expressions quoted so the shell passes them to Zypper for package matching. This requests all available matching packages, including development or additional components where their names match; review the proposed package list and any dependency choices before accepting.

If KDE is already installed and you have **no pending transaction**, start a new transaction instead:

```bash
sudo transactional-update pkg install 'kdeplasma6-*' 'plasma6-*'
```

Use the command appropriate to your snapshot state, then reboot **after the selected installation commands succeed**:

```bash
sudo systemctl reboot
```

If a package/pattern is unavailable, inspect the configured repositories and current package names instead of adding an unrelated repository to make the command pass.

Reference: [Zypper package selection and wildcard matching](https://github.com/openSUSE/zypper/blob/master/doc/zypper.8.txt).

After booting the installed desktop packages:

```bash
sudo systemctl set-default graphical.target
sudo systemctl enable --now sddm.service
```

## IMPORTANT!!! — The SDDM fix that worked on your installation

If the system boots to a terminal despite `graphical.target`, inspect:

```bash
systemctl get-default
readlink -f /etc/systemd/system/display-manager.service
systemctl status sddm.service --no-pager
journalctl -b -u sddm.service --no-pager
```

When `display-manager.service` points to the legacy display manager and enabling SDDM reports a conflicting link, use your tested fix:

```bash
sudo systemctl enable --now --force sddm.service
```

The `--force` replaces the conflicting service alias. This is a service-selection fix; it does not repair a missing Plasma installation or a GPU-driver problem.

Reference: [Kalpa's documented SDDM workaround](https://kalpadesktop.org/documentation/), also reproduced successfully on your installation.

# 7. IMPORTANT!!! — Time, hostname, and KDE settings

In KDE System Settings, enable **Set Date/Time Automatically** and select **Europe/Sofia**.

```bash
sudo timedatectl set-timezone Europe/Sofia
sudo timedatectl set-ntp true
timedatectl status
```

If no time-sync service is available, install `chrony` transactionally, reboot, then enable it:

```bash
sudo transactional-update pkg install chrony
sudo systemctl reboot
```

After reboot:

```bash
sudo systemctl enable --now chronyd.service
chronyc tracking
```

Use one configured time-sync service. See [openSUSE NTP documentation](https://doc.opensuse.org/documentation/leap/reference/html/book-reference/cha-ntp.html).

Check `Hostname-Important-Info.md` before changing the hostname. To inspect it:

```bash
hostnamectl status
```

Apply your normal preferences from `KDE-Settings.md`. For the window buttons that appeared reversed on your MicroOS installation, open **Window Decorations → Titlebar Buttons** in System Settings and arrange minimize, maximize, and close as you prefer.

# 8. IMPORTANT!!! — Install host tools in a batch

Install tools on the host when they need host services, devices, or kernel integration. Use Flatpak/Distrobox for most other applications.

Example base batch; adjust it to what is missing:

```bash
sudo transactional-update pkg install \
  flatpak podman distrobox \
  btop fastfetch pciutils usbutils \
  smartmontools nvme-cli lm_sensors \
  gnome-disk-utility ksystemlog \
  bash-completion
```

After success, reboot before using newly installed host tools:

```bash
sudo systemctl reboot
```

Check availability before extending the batch:

```bash
zypper search -s nvtop
zypper search -s plasma6-disks
zypper search -s apcupsd
```

Optional additions for your setup:

| Need | Package or approach |
| --- | --- |
| GPU monitoring | `nvtop`; it also supports AMD hardware |
| KDE SMART/disk health integration | `plasma6-disks`, if available in your repositories |
| APC UPS integration | `apcupsd`, configured using your UPS notes |
| Firewall GUI | `firewall-config`, if using firewalld |
| CPU power tools | Search current openSUSE `cpupower` / `kernel-tools` packages for the required executable |
| Virtual machines | Section 16 |
| Development compilers and SDKs | Distrobox, unless needed for a host integration build |

Do not copy Fedora's `fuse-libs`, `edk2-ovmf`, `kernel-modules-extra`, or Debian's `build-essential` package names blindly. Resolve the openSUSE package for the feature you need.

## Remove the Falkon browser

If Falkon was installed with the desktop and you do not want it, remove its host package. With no pending transaction:

```bash
sudo transactional-update pkg remove falkon
```

If you are adding this removal to an already pending transaction, use this command instead:

```bash
sudo transactional-update --continue pkg remove falkon
```

Review the proposed removals, then reboot after the selected command succeeds:

```bash
sudo systemctl reboot
```

# 9. IMPORTANT!!! — The rule for consecutive host changes

Each ordinary transaction starts from the **running snapshot**. A second ordinary transaction before reboot can therefore omit the changes staged by the first.

Use either approach:

**One transaction, then reboot:**

```bash
sudo transactional-update pkg install btop nvtop smartmontools
sudo systemctl reboot
```

**Deliberately extend pending changes:**

```bash
sudo transactional-update pkg install btop
sudo transactional-update --continue pkg install nvtop
sudo systemctl reboot
```

Proceed to the next line only when the preceding transaction succeeds. `--continue` uses the default pending snapshot; inspect state first if another tool has staged changes.

`transactional-update apply` can expose staged files without rebooting, but it does not replace the running kernel or restart all services. Keep reboot activation as your routine, especially after a full upgrade or driver change.

Source: [current transactional-update manual](https://manpages.opensuse.org/Tumbleweed/transactional-update/transactional-update.8.en.html).

# 10. System-wide Flathub and password-free Flatpak management

Use **system-wide Flathub** for this setup. Applications and runtimes are shared through the system installation, normally `/var/lib/flatpak`; each user's application settings and data remain in their home directory.

## Allow the current user to manage system Flatpaks without a password

Run the following from a terminal in **your normal user's active local KDE session**, not from a root shell. It captures your username and creates a Polkit rule for that account. Creating the rule requires administrator authentication once.

```bash
flatpak_user="$(id -un)"
sudo install -d -m 0755 /etc/polkit-1/rules.d
sudo tee /etc/polkit-1/rules.d/00-flatpak-current-user.rules > /dev/null <<EOF
polkit.addRule(function(action, subject) {
    var allowedActions = [
        "org.freedesktop.Flatpak.app-install",
        "org.freedesktop.Flatpak.runtime-install",
        "org.freedesktop.Flatpak.app-update",
        "org.freedesktop.Flatpak.runtime-update",
        "org.freedesktop.Flatpak.app-uninstall",
        "org.freedesktop.Flatpak.runtime-uninstall",
        "org.freedesktop.Flatpak.configure-remote",
        "org.freedesktop.Flatpak.update-remote",
        "org.freedesktop.Flatpak.modify-repo",
        "org.freedesktop.Flatpak.appstream-update",
        "org.freedesktop.Flatpak.metadata-update"
    ];

    if (subject.user === "$flatpak_user" &&
        subject.local && subject.active &&
        allowedActions.indexOf(action.id) !== -1) {
        return polkit.Result.YES;
    }
});
EOF
sudo chown root:root /etc/polkit-1/rules.d/00-flatpak-current-user.rules
sudo chmod 0644 /etc/polkit-1/rules.d/00-flatpak-current-user.rules
unset flatpak_user
```

Polkit reloads rule changes automatically. Reopen Discover after creating the rule. Run subsequent Flatpak commands **without sudo** so they use your user session for authorization.

The rule permits app/runtime installation, updates, removal, and Flatpak repository management for the captured user in an active local session. It grants no additional permissions to other users and does not change sudo or PackageKit authentication. Local bundle installation, downgrades, and unrelated administrative actions retain their existing policies.

If a Flatpak action still asks for a password, inspect rule-loading errors:

```bash
journalctl -b -u polkit.service -n 50 --no-pager
```

To undo this authorization rule later:

```bash
sudo rm /etc/polkit-1/rules.d/00-flatpak-current-user.rules
```

## Add system-wide Flathub

Inspect both scopes, then add the system remote:

```bash
flatpak remotes --show-details
flatpak remote-add --system --if-not-exists flathub \
  https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remotes --system --show-details
```

## Replace an existing user Flathub remote

Skip app migration if this is a fresh installation. Adding the system remote does not move apps already installed for your user.

List existing user app references and their origins:

```bash
flatpak list --user --app --columns=ref,origin
```

For each app from the user Flathub remote, close the app, install the same reference system-wide, verify that installation, then remove its user installation. Replace `APP_REF` with the full reference from the list, preserving its architecture and branch:

```bash
flatpak install --system flathub APP_REF
flatpak info --system APP_REF
flatpak uninstall --user APP_REF
```

Proceed to removal only after installation and verification succeed. Omit `--delete-data` to retain the app's existing user data.

After migrating the user Flathub apps, review and remove unused user runtimes, then delete the user remote:

```bash
flatpak uninstall --user --unused
flatpak remote-delete --user flathub
flatpak remotes --show-details
```

If the user remote has another name, substitute the name shown by `flatpak remotes`. If deletion reports installed references still using it, inspect `flatpak list --user --columns=ref,origin` and resolve those references before retrying. Do not force-delete an in-use remote.

## Install and update system-wide apps

```bash
flatpak install --system flathub org.videolan.VLC
flatpak install --system flathub com.github.wwmm.easyeffects
flatpak update --system
```

Use your `flatpaks-to-install.txt` for the complete application list, including your database tools. Podman Desktop is optional; Distrobox does not require its GUI.

Discover needs `discover6-backend-flatpak` for Flatpak integration. Select the **system-wide Flathub source** when installing through Discover. Log out and back in if newly installed applications do not appear in the launcher.

No `flatpak` group is needed for this rule. Flatpak changes do not require a MicroOS host transaction or host reboot; installing the Flatpak host package itself still follows the transactional procedure in section 8.

Sources: [user versus system installations](https://docs.flathub.org/docs/for-users/user-vs-system-install) · [Flatpak command reference](https://docs.flatpak.org/en/latest/flatpak-command-reference.html) · [Flatpak authorization actions](https://github.com/flatpak/flatpak/blob/main/system-helper/org.freedesktop.Flatpak.policy.in) · [Polkit rules](https://polkit.pages.freedesktop.org/polkit/polkit.8.html) · [Discover packages](https://packagehub.suse.com/packages/discover6/).

# 11. Set up Distrobox

Run these as your normal user. Example using an openSUSE Tumbleweed userspace:

```bash
distrobox create \
  --name tumbleweed-apps \
  --image registry.opensuse.org/opensuse/tumbleweed:latest

distrobox enter tumbleweed-apps
```

**Inside that container**, normal Zypper installation and upgrades are appropriate:

```bash
sudo zypper refresh
sudo zypper dup
sudo zypper install git gcc gcc-c++ make cmake
```

Container userspace is separate from the MicroOS host, while devices, kernel, and desktop integration are shared. Containers do not install a different host kernel.

Use `Apps-In-Distrobox.md` for your custom Mesa and gaming launchers. Host upgrades do not upgrade the packages inside Distrobox automatically.

## Before a large container upgrade

Close applications using the container, leave it, and create a clone:

```bash
distrobox stop tumbleweed-apps
distrobox create --clone tumbleweed-apps --name tumbleweed-apps-before-upgrade
```

A clone preserves the container environment; shared home files and bind-mounted data need their own backup. A MicroOS root rollback does not rewind rootless Podman storage in your home directory.

Sources: [Distrobox create/clone](https://distrobox.it/usage/distrobox-create/) · [integration and backup notes](https://distrobox.it/useful_tips/).

# 12. Check and install host updates

## Preview the distribution upgrade

For an rpm-ostree-style preview on the read-only host, use a disposable transaction:

```bash
sudo transactional-update --no-selfupdate run sh -c '
  zypper refresh && zypper dup --dry-run --details --no-allow-vendor-change
  exit 1
'
```

**The final failure is intentional:** the command discards the preview snapshot. Read the Zypper output to distinguish this expected ending from a repository or dependency failure. This previews package changes; it is not a guaranteed byte-for-byte preview of a future run if repositories change.

The pattern follows the documented nonzero-exit behavior of `transactional-update run`; it is not a dedicated `--preview` option.

## Apply updates

With no other pending transaction:

```bash
sudo transactional-update dup
```

Read the result. After a successful update, reboot:

```bash
sudo systemctl reboot
```

After boot, verify:

```bash
cat /etc/os-release
uname -r
findmnt -no SOURCE,OPTIONS /
sudo snapper -c root list
sudo bootctl list
```

MicroOS is rolling release: the normal upgrade is `dup`; you do not perform Fedora-style release-number rebases.

Update system-wide Flatpaks with `flatpak update --system` and upgrade Distroboxes separately. Section 10 replaces the user Flathub setup with the system-wide remote.

Sources: [transaction command behavior](https://kubic.opensuse.org/documentation/man-pages/transactional-update.8.html) · [rolling-release update configuration](https://manpages.opensuse.org/Tumbleweed/transactional-update/transactional-update.conf.5.en.html).

# 13. OPTIONAL — Host updates through Discover

Skip this section if you prefer host updates entirely through the CLI in section 12. Discover can still manage Flatpaks using `discover6-backend-flatpak`.

For host updates inside Discover, choose **one** of the following options:

| Option | Setup |
| --- | --- |
| PackageKit | MicroOS's transaction-capable PackageKit setup plus Discover's PackageKit backend |
| Custom Zypper backend | Keep Zypper/transactional-update and install the add-on we worked on |

## Option A — PackageKit for Discover updates

For a new installation, select **MicroOS via PackageKit** if offered. This selects the distribution's PackageKit package-management setup. PackageKit is not required for the default Zypper workflow.

Discover also needs **`discover6-backend-packagekit`**. On a MicroOS installation already configured with transaction-capable PackageKit, install it through that package manager if it is missing:

```bash
sudo pkgcli install discover6-backend-packagekit
```

After a successful package installation, reboot before continuing. Then reopen Discover, select **Updates**, refresh the list, install the available system updates, and reboot when required to activate the staged system.

For CLI checks on that PackageKit installation:

```bash
pkgcli refresh
pkgcli list-updates
```

These commands require the `pkgcli` client supplied by current PackageKit releases. Check the installed client's help if using a different release.

**On an existing Zypper-only installation, adding Discover's frontend backend alone does not configure transactional PackageKit updates.** First configure the MicroOS-supported transactional PackageKit stack for the installed release. This optional section does not prescribe an unverified conversion of an existing installation.

The PackageKit route does not require the custom Zypper add-on below. Keep automatic installation disabled in Discover if you want manual updates. Complete a host update and reboot before switching tools or starting another host transaction; the Zypper `--continue` examples do not establish how PackageKit combines pending changes.

Sources: [Discover PackageKit backend](https://apps.kde.org/discover.packagekit/) · [openSUSE Discover packages](https://packagehub.suse.com/packages/discover6/) · [PackageKit CLI](https://www.freedesktop.org/software/PackageKit/pk-using.html) · [transactional package-manager integrations](https://github.com/openSUSE/transactional-update).

## Option B — Custom Zypper backend

This option keeps **Zypper/transactional-update for host updates**. Discover can manage Flatpaks alongside the custom MicroOS Zypper backend we worked on.

The `microos-discover-zypper(1).zip` archive inspected for this guide contains:

- A **MicroOS system update (Zypper)** row representing the distribution upgrade.
- A timer that checks approximately every 30 minutes while running.
- An update action that requests administrator authentication and stages `transactional-update dup` through a systemd helper.
- Pending-snapshot handling and a reboot prompt; the helper does not reboot automatically.

Use the **README included in that archive** for the exact build and helper-installation steps. It uses Discover's private plugin interface, so rebuild against the matching Discover version after a version change. The earlier source/build checks are not proof of a completed live MicroOS upgrade through the UI.

After installation, start Discover with the plugin path described by its README:

```bash
QT_PLUGIN_PATH="$HOME/.local/lib/microos-discover/plugins${QT_PLUGIN_PATH:+:$QT_PLUGIN_PATH}" \
  plasma-discover --mode Update
```

Check or troubleshoot it with:

```bash
systemctl status microos-discover-zypper.timer --no-pager
sudo systemctl start microos-discover-zypper.service
sudo journalctl -u microos-discover-zypper.service -n 50 --no-pager
sudo journalctl -u microos-discover-zypper-apply.service -n 50 --no-pager
```

Reboot into an already pending snapshot before asking it to stage a fresh update. If using this custom backend, use it as your Discover host-update path; the optional PackageKit route above is an alternative. Discover showing Flatpak updates alone does not prove that a MicroOS host-update backend is active.

If the add-on fails, the CLI update procedure in section 12 remains available.

# 14. IMPORTANT!!! — systemd-boot configuration and kernel arguments

## Keep the boot menu accessible

```bash
sudo bootctl status
sudo bootctl list
sudo bootctl set-timeout 5
```

This sets a five-second menu timeout. If the menu is hidden, hold **Space** early during boot. You can also request the menu for the next reboot:

```bash
sudo systemctl reboot --boot-loader-menu=5
```

## Change kernel arguments

First finish any pending transaction and reboot. Then inspect and edit the existing command line:

```bash
cat /proc/cmdline
cat /etc/kernel/cmdline
sudoedit /etc/kernel/cmdline
```

Keep the required root, encryption, resume, and other existing arguments. Add only the parameter you intend to test, on the same command line. If the file is missing, investigate the installed boot configuration before replacing it with a guessed line.

Update the entries for the current snapshot:

```bash
sudo sdbootutil update-all-entries
sudo bootctl list
sudo systemctl reboot
```

After reboot, confirm the result:

```bash
cat /proc/cmdline
```

Use this method for parameters from `AMD-GPUs-Linux-Control-Panel.md`. Reassess old experimental AMD flags before carrying them to a newer kernel. The guide does not assume every parameter you tested previously is still necessary.

Do not manually rewrite generated snapshot entries or run `grub2-mkconfig` for this setup. For a one-boot test, systemd-boot may allow editing with **e** in its menu; availability depends on the boot configuration and security policy.

Sources: [openSUSE kernel-argument workflow](https://microos.opensuse.org/blog/2024-09-03-quickstart-fde-yast2/) · [sdbootutil commands](https://github.com/openSUSE/sdbootutil/blob/main/sdbootutil) · [bootctl](https://manpages.opensuse.org/Tumbleweed/udev/bootctl.1.en.html) · [systemd-boot menu](https://freedesktop.org/software/systemd/man/latest/systemd-boot.html).

# 15. Snapper retention and recovery

## Inspect the actual limits

```bash
sudo snapper -c root get-config
sudo snapper -c root list
sudo btrfs filesystem usage /
df -h /boot/efi
```

Your earlier installation showed:

```ini
NUMBER_LIMIT="2-10"
NUMBER_LIMIT_IMPORTANT="4-10"
```

These are cleanup ranges for ordinary and important snapshots, not a promise of exactly ten snapshots total. Other snapshot classes, minimum ages, protected snapshots, and cleanup timing can change the visible count.

Keep those settings unless you have a reason to change them. To set the same values explicitly:

```bash
sudo snapper -c root set-config \
  'NUMBER_LIMIT=2-10' \
  'NUMBER_LIMIT_IMPORTANT=4-10'
```

Before deleting any snapshot, verify that it is neither the running snapshot nor the default/pending snapshot and that a working recovery entry remains.

## Keep a known-good snapshot

After a successful reboot, note the **actual running snapshot number** from the root mount and Snapper list. To keep that existing snapshot out of automatic cleanup, substitute its real number:

```bash
sudo snapper -c root modify --cleanup-algorithm '' SNAPSHOT_NUMBER
```

This prevents automatic cleanup of that snapshot until you assign a cleanup algorithm again. It is not an independent backup of the disk or ESP. Monitor space if retaining several snapshots.

## Roll back while the system still boots

List snapshots, choose a known-good number, and run:

```bash
sudo snapper -c root list
sudo transactional-update rollback SNAPSHOT_NUMBER
sudo bootctl list
sudo systemctl reboot
```

Replace `SNAPSHOT_NUMBER` with the actual number. After reboot, verify the root mount and application behavior.

## Recover when the new snapshot does not boot

1. Open the **systemd-boot menu** using Space during startup.
2. Select an older known-good **snapshot entry**, where the installation's sdbootutil integration has generated one. An older kernel entry is not necessarily an older root snapshot.
3. After booting successfully into it, run:

```bash
sudo transactional-update rollback
sudo systemctl reboot
```

Without a number, `rollback` makes the currently booted root snapshot the default.

Do not assume systemd-boot provides GRUB's snapshot submenu. Check `bootctl list` and confirm an older snapshot is actually available **before** relying on this recovery route.

## If the default snapshot and selected boot entry disagree

```bash
findmnt -no SOURCE,OPTIONS /
sudo btrfs subvolume get-default /
sudo bootctl status
sudo bootctl list
```

On sdbootutil versions providing the following command, reconcile the boot entry for a verified, intended snapshot:

```bash
sudo sdbootutil set-default-snapshot SNAPSHOT_NUMBER
sudo bootctl list
```

Use this only after checking the snapshot number and the failed transaction's output. It is a boot-entry repair step, not part of every update. Normally the Snapper/sdbootutil integration does this automatically.

If the ESP, bootloader, disk, or encryption setup itself is damaged, use installation/rescue media; a root snapshot alone cannot restore those components.

Sources: [Snapper limits](https://manpages.opensuse.org/Tumbleweed/snapper/snapper-configs.5.en.html) · [snapshot modification](https://manpages.opensuse.org/Tumbleweed/snapper/snapper.8.en.html) · [rollback](https://manpages.opensuse.org/Tumbleweed/transactional-update/transactional-update.8.en.html) · [boot-entry integration](https://github.com/openSUSE/sdbootutil/blob/main/10-sdbootutil.snapper).

# 16. Virtualization — KVM, QEMU, virt-manager, and UEFI guests

Keep the hypervisor, libvirt daemons, and firmware on the **host**. Inspect available virtualization patterns:

```bash
zypper search -t pattern kvm
```

Where available, install the standard host/tool patterns:

```bash
sudo transactional-update pkg install -t pattern kvm_server kvm_tools
```

After success, extend that transaction with the GUI and x86_64 UEFI firmware:

```bash
sudo transactional-update --continue pkg install virt-manager qemu-ovmf-x86_64
sudo systemctl reboot
```

After reboot, check which daemon arrangement the installed packages use:

```bash
systemctl list-unit-files 'libvirtd*' 'virtqemud*' 'virtnetworkd*' 'virtstoraged*'
```

If the installation uses monolithic libvirt, enable its provided service:

```bash
sudo systemctl enable --now libvirtd.service
```

If it uses modular daemons, follow the packaged configuration and enable the corresponding sockets, for example:

```bash
sudo systemctl enable --now virtqemud.socket virtnetworkd.socket virtstoraged.socket
```

Use the arrangement actually installed; do not enable both daemon families as a generic fix. Other supporting sockets may be required by the enabled features.

Validate the host and connection:

```bash
sudo virt-host-validate qemu
sudo virsh -c qemu:///system list --all
```

Open virt-manager and connect to **QEMU/KVM system**. Use Polkit authorization or the distro's configured access policy. Add users to `libvirt`/`kvm` groups only when the relevant group and device/socket policy require it; group names alone do not guarantee access. Log out and back in after group changes.

Host snapshots normally exclude VM disk data under `/var`. Back up VM disks and definitions separately.

Sources: [openSUSE virtualization packages and OVMF](https://doc.opensuse.org/documentation/leap/virtualization/html/book-virtualization/cha-vt-installation.html) · [libvirt daemon layouts](https://libvirt.org/daemons.html).

# 17. Repository management and package lookup

Inspect repositories before an upgrade, especially after a long period without updating:

```bash
zypper lr -d
zypper locks
```

Repository definitions are configuration under `/etc/zypp/repos.d`. Use the exact alias shown by `zypper lr` when disabling or removing a repository:

```bash
sudo zypper mr -d REPOSITORY_ALIAS
```

Or, when you intend to remove its definition:

```bash
sudo zypper rr REPOSITORY_ALIAS
```

Removing a repository does not remove packages previously installed from it. Review installed third-party packages and vendor choices before the next transaction. Keep official repositories appropriate to your MicroOS installation; do not point them at an unrelated release to solve an individual package error.

Package discovery:

```bash
zypper search -s pciutils
zypper info pciutils
zypper search --provides /usr/sbin/lspci
```

If a file lookup returns nothing, the queried path or available repository metadata may be the reason. A missing result does not establish that the package is absent.

For an installed executable:

```bash
command -v lspci
rpm -ql pciutils
rpm -qf /usr/sbin/lspci
```

Use the actual executable path if different. `lspci` is provided by `pciutils`, as in the issue we discussed.

Read-only queries such as `rpm -qa`, `zypper search`, and `zypper info` remain useful. Use transactional-update for host package installation/removal, even though Zypper is installed.

Source: [Zypper command documentation](https://github.com/openSUSE/zypper/blob/master/doc/zypper.8.txt).

# 18. IMPORTANT!!! — `/etc`, updates, and configuration files

`/etc` remains writable on the transactional system. You can edit configuration such as `/etc/fstab`, service overrides, and your boot command line.

Current transactional-update versions use a writable `/etc` subvolume associated with the root snapshot. Older versions used overlays. Do not manually recreate the old overlay layout from an outdated guide.

Avoid changing a configuration file while an update is also changing it. If both the staged snapshot and running system modify the same file, the staged version wins after reboot. Reboot promptly after staging to reduce this overlap.

After a large upgrade, inspect package configuration alternatives such as `.rpmnew` and `.rpmsave` where present. Do not overwrite customized configuration without comparing it.

Rolling back the root can also restore older system configuration. Your separate `/home` and writable `/var` are outside that root rollback.

Sources: [current `/etc` handling](https://manpages.opensuse.org/Tumbleweed/transactional-update/transactional-update.8.en.html) · [transactional writable-data layout](https://kubic.opensuse.org/documentation/transactional-update-guide/tu-setup.html).

# 19. Power cuts during updates — what to do

A transaction prepares a new root snapshot while the running OS remains available. After an interrupted update, boot the existing working entry if necessary, inspect the failed operation, and retry once repository/network/disk problems are resolved.

```bash
sudo journalctl -b -1 --no-pager -n 200
sudo snapper -c root list
sudo btrfs filesystem usage /
df -h /boot/efi
sudo bootctl list
```

The previous-boot journal is available only if it was retained. For an automatic update, also inspect `journalctl -u transactional-update.service`; manually run commands may have their relevant output only in the terminal or other logs.

Atomic root updates reduce the risk of a partially installed OS. They cannot guarantee that the machine will always boot after every power cut: the ESP, firmware boot variables, storage hardware, filesystem metadata, and writable application data have separate failure modes. openSUSE synchronizes boot assets to the ESP as part of completing the update, and the FAT ESP is outside Btrfs snapshot protection.

Keep a rescue USB and verify recovery entries in advance. Your UPS remains useful.

Sources: [transactional update design](https://github.com/openSUSE/transactional-update) · [boot asset synchronization](https://github.com/openSUSE/suse-module-tools/blob/master/README.md).

# 20. Hardware, sound, gaming, and security notes

- **AMD desktop:** start with the distro-provided kernel, firmware, and Mesa. Use your existing custom Mesa/container workflow only when needed. Preserve your tested TV settings for HDMI 2.1/high refresh separately from OS configuration.
- **NVIDIA ThinkPad:** follow current openSUSE instructions matching MicroOS, the GPU, Secure Boot, and the installed kernel. Fedora's RPM Fusion and `akmods` procedure is not the openSUSE procedure.
- **Sound:** apply your PipeWire notes after verifying the default setup. Check `LANG=C pactl info` when `pactl` is installed. Recheck high sample-rate overrides if a game has sound problems; your earlier 192 kHz setting affected some games.
- **Gaming:** use your Flatpak or Distrobox setup and the matching notes for MangoHud, gamescope, custom Mesa, and NTSYNC. Install host kernel components on the host.
- **SELinux:** keep the installed security policy unless troubleshooting establishes a specific issue. Do not copy `selinux=0` from the Fedora checklist as a routine setup step. The [Kalpa diagnostic examples](https://kalpadesktop.org/documentation/) include audit queries for identifying denials.
- **Firmware and power management:** use the hardware-specific notes listed at the top. Do not carry over obsolete tweaks automatically.

# 21. Fedora checklist → MicroOS equivalents

| Fedora item from the sample | MicroOS procedure |
| --- | --- |
| `rpm-ostree upgrade` | `sudo transactional-update dup`, then reboot |
| `rpm-ostree install PACKAGE` | `sudo transactional-update pkg install PACKAGE`, then reboot |
| `rpm-ostree override remove PACKAGE` | `sudo transactional-update pkg remove PACKAGE`; review dependencies, then reboot |
| `rpm-ostree upgrade --preview` | Disposable Zypper dry run in section 12 |
| `ostree kargs --editor` | Edit `/etc/kernel/cmdline`, run `sudo sdbootutil update-all-entries`, reboot |
| Fedora GRUB timeout file | `sudo bootctl set-timeout 5` for this systemd-boot setup |
| OSTree deployment pin | Protect a verified existing snapshot from cleanup; section 15 |
| Fedora release-number rebase | Normal rolling-release `transactional-update dup` |
| Fedora immutable group workaround | Inspect openSUSE's actual group and access policy |
| Fedora/Debian package lists | Resolve openSUSE package names or install inside the appropriate Distrobox |
| `apt-mark showhold` | `zypper locks` |
| Host snapshots | Btrfs/Snapper; home, container data, VMs, and ESP need separate backup coverage |

# 22. Final check after installation

- [ ] systemd-boot is the active bootloader and its menu is accessible.
- [ ] Root is Btrfs and read-only; Snapper can list the root snapshots.
- [ ] The existing ext4 home filesystem is mounted correctly.
- [ ] KDE starts through SDDM; the legacy display-manager alias is fixed if necessary.
- [ ] Time synchronization and Europe/Sofia timezone are configured.
- [ ] Automatic host update staging is disabled for your manual workflow.
- [ ] System-wide Flathub is configured; the former user Flathub remote is removed after any app migration.
- [ ] The current user's Flatpak management works without a password in an active local session.
- [ ] Your selected Flatpaks and Distrobox work.
- [ ] Required monitoring, disk, UPS, and virtualization tools are installed.
- [ ] Optional: Discover host updates use either the transaction-capable PackageKit setup or the custom Zypper backend.
- [ ] A successful transactional update and reboot have been verified.
- [ ] `bootctl list` shows the recovery entries you plan to use.
- [ ] A known-good snapshot is retained and important data has a separate backup.

# Daily command reminder

```bash
# Host upgrade — reboot after success
sudo transactional-update dup

# Host packages — reboot after success
sudo transactional-update pkg install PACKAGE_NAME
sudo transactional-update pkg remove PACKAGE_NAME

# Inspect installed packages and snapshots
rpm -qa
sudo snapper -c root list

# Inspect systemd-boot and disk space
sudo bootctl status
sudo bootctl list
df -h /boot/efi

# Update system-wide Flatpaks
flatpak update --system

# Enter a container; update its packages separately
distrobox enter tumbleweed-apps
```

The install/remove commands above are alternatives. If performing several host operations before reboot, use `--continue` for subsequent transactions as described in section 9.
