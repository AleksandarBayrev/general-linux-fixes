# To prevent sleeping of the system and crashing nightly create a file in `/etc/systemd/sleep.cond.d` (create the directory if missing) with the following contents
```ini
[Sleep]
#AllowSuspend=yes
AllowHibernation=No
AllowSuspendThenHibernate=No
AllowHybridSleep=No
#SuspendMode=
#SuspendState=mem standby freeze
#HibernateMode=platform shutdown
#HibernateState=disk
#HybridSleepMode=suspend platform shutdown
#HybridSleepState=disk
#HibernateDelaySec=
#SuspendEstimationSec=60min
```