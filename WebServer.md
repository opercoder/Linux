
## Apache
#### Проброс клиентского ip дальше:
``` bash
# ls -al /etc/apache2/mods-enabled/
...
remoteip.load -> ../mods-available/remoteip.load
...
# cat /etc/apache2/conf-enabled/remoteip.conf 
RemoteIPHeader X-Forwarded-For
RemoteIPInternalProxy 10.2.0.12 172.28.0.0/24
```
