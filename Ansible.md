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

#### Объединение строк
Чтобы Ansible воспринимал строки как единую строку, в YAML можно воспользоваться знаком «больше»(>).
Парсер YAML в этом случае заменит разрывы строк пробелами. Например:  
``` bash
nаmе: еnаble configuration
file: >
dest=/etc/nginx/sites-enabled/default
src=/etc/nginx/sites-available/default
state=link
```
### Пример
``` bash
- nаmе: Configure webserver with nginx
  hosts: webservers // Список хостов
  bесоmе: Тгuе      // Стать root     
  tasks:            // Список задач
    - nаme: install nginx
      apt: name=nginx update_cache=yes
    - nаmе: сору nginx config file
      сору: src=files/nginx.conf dest=/etc/nginx/sites-available/default
    - nаmе: еnаblе configuration
      file: >
        dest=/etc/nginx/sites-enaЫed/default
        src=/etc/nginx/sites-availaЫe/default
        state=link
    - nаmе: сору index.htмl
      template: src=templates/index.html.j2 dest=/usr/share/nginx/html/index.html
        mоdе=0644
    - nаmе: restart nginx
      service: name=nginx state=restarted
```
