1. Read a file by line:
``` bash
while read line; do
  echo "$line"
done < file.txt
```
2. SSH in loop (use **-n** or **< /dev/null**):
``` bash
while read -r line; do
        ssh root@"$I" podman rmi --all < /dev/null
        ssh -n root@"$I" rm -r ~/custom_image/*
done < "list.tmp"
```
