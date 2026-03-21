# To disable hibernation for the system create a file in `/etc/systemd/sleep.cond.d` (create the directory if missing) with the following contents
```ini
[Sleep]
#AllowSuspend=yes
AllowHibernation=No
AllowHybridSleep=No
AllowSuspendThenHibernate=No
#SuspendMode=
#SuspendState=mem standby freeze
#HibernateMode=platform shutdown
#HibernateState=disk
#HybridSleepMode=suspend platform shutdown
#HybridSleepState=disk
#HibernateDelaySec=
#SuspendEstimationSec=60min
```
# If you have strange crashes you can try to uncomment the rest of the options, otherwise use the 
# Afterwards run `sudo systemctl restart systemd-logind.service` or restart the PC to have the hibernation off
# If there are problems with ACPI related stuff (Wi-Fi not turning on after wakeup) install `acpi` and `acpid` and enable `acpi.service` (`sudo systemctl enable --now acpid.service`)