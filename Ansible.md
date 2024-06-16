## Установка
### On a MAC
``` console
$ sudo easy_install pip
$ sudo pip install ansible
or
$ brew install ansible
```
### On a Linux
If you have *python-pip* and *python-devel* (python-dev on Debian/Ubuntu) installed:  
```$ sudo pip install ansible ```
### CentOS 7
``` bash
$ yum install epel-release
$ yum -y install ansible
```
### Debian/Ubuntu:
``` console
$ sudo apt-get install python-software-properties
$ sudo apt-add-repository -y ppa:ansible/ansible
$ sudo apt-get update
$ sudo apt-get install -y ansible
```

## Простые комманды, синтаксис
#### Выполнение удаленно модуля
``` ansible hosts -m ping -u [username] ```
#### Выполнение удаленно команды bash
```ansible hosts -a "free -m" -u [username] ```
#### Информация о системе (-f число одновременно выполняемых процессов)
```ansible hosts -m setup -f 1```

#### Playbook.yml
``` bash
- hosts: all
  become: yes
  tasks:
  - name: Ensure NTP is installed.
    dnf: name=chrony state=present
  - name: Ensure NTP is running.
    service: name=chronyd state=started enabled=yes
```
```ansible-playbook Playbook.yml```
or without file:  
```ansible all -b -m yum -a "name=ntp state=present"```

#### Запуск только на определенном хосте
``` console
$ ansible all -b -a "service ntpd restart" --limit "*.4" (* - wildcard)
$ ansible all -b -a "service ntpd restart" --limit ~".*\.4" (tilde - regular expression)
```

### Add and delete user
``` console
$ ansible centos7 -b -m user -a "name=testik createhome=yes"
$ ansible centos7 -b -m user -a "name=testik state=absent remove=yes"
```
