1. For example, you have next situaiton:
``` bash
# df -h
...
/dev/sda5              7,5G         7,5G  0              100% /Volume/log
```
2. You deleted some big file from _/Volume/log_. But _/Volume/log_ size doesn't decrease.
``` bash
# df -h
...
/dev/sda5              7,5G         7,5G  0              100% /Volume/log
```
3. But,
``` bash
# df -ih
...
/dev/sda5              4,4K         485K  0              1%   /Volume/log
```
4. So some process are holding deleted big file. Let's check.
``` bash
# lsof +L1
COMMAND      PID   USER   FD   TYPE DEVICE   SIZE/OFF   NLINK  NODE NAME
process_name 25215 root   12u  REG  8,5      4192863291 835    /Volume/log/big_file (deleted)
```
5. Free memory by command where PID=25215, FileDescriptor(FD)=12:
``` bash
# > /proc/25215/fd/12
```
