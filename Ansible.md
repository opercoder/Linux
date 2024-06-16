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

#### Создание и удаление пользователя
``` console
$ ansible centos7 -b -m user -a "name=testik createhome=yes"
$ ansible centos7 -b -m user -a "name=testik state=absent remove=yes"
```
#### Установка с помощью кроссплатформенного модуля package
ansible centos7 -b -m package -a "name=git state=present"

### Работа с файлами
#### Получение информации о файле
```ansible centos7 -m stat -a "path=/etc/hostname"```
#### Копирование файла на группу хостов
```ansible centos7 -m copy -a "src=/etc/hosts dest=/tmp/hosts"```  
Для копирования директории / не ставится. Для копирования только содержимого в конце ставится / .
Подходит для копирования небольших директорий. Для копирования больших каталогов используйте *synchronize* или *rsync*  модули.  
#### Копирование файлов с хостов
```ansible centos7 -m fetch -a "src=/etc/hosts dest=/tmp"```  
Создает в /tmp папки с именами хостов и там уже сам файл по пути /tmp/HOSTNAME/etc/hosts.  
```ansible centos7 -m fetch -a "src=/etc/hosts dest=/tmp/ flat=yes"```  
Копирует файл сразу в директорию dest без родительских каталогов.  
#### Создание директорий и файлов 
```ansible centos7 -m file -a "dest=/tmp/test mode=644 state=directory"```  
Создает директорию.
```ansible centos7 -m file -a "src=/src/file dest=/dest/symlink state=link"```  
Создает ссылку.
#### Удаление директорий и файлов
```ansible centos7 -m file -a "dest=/tmp/test state=absent"```
### Запуск операций в фоне
