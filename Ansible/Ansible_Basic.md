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
#### Запуск операций в фоне
```ansible centos7 -b -B 3600 -P 0 -a "yum -y update"```  
```ansible centos7 -b -m async_status -a "jid=123456789.1234"```  
#### Просмотр логов
```ansible centos7 -b -a "tail /var/log/messages"```  
```ansible centos7 -b -m shell -a "tail /var/log/messages | grep ansible | wc -l"```  
#### Редактирование Cron
```ansible centos7 -b -m cron -a "name='daily-cron-all-servers' hour=4 job='/path/to/daily-script.sh'"``` 
```ansible centos7 -b -m cron -a "name='daily-cron-all-servers' state=absent"```
#### Deploy version controlled application
```ansible centos7 -b -m git -a "repo=git://example.com/path/to/repo.git dest=/opt/myapp update=yes version=1.2.4"```

## PLAYBOOKS
``` bash
---
- name: test1
  hosts: zabbix
  become: yes

  tasks:
  - name: install Apache.
    apt:
      name:
      - vim
      - apache2
      state: present
  - name: copy conf files
    copy:
      src: "{{ item.src }}"
      dest: "{{ item.dest }}"
      owner: root
      group: root
      mode: 0644
    with_items:
    - src: 1.conf
      dest: /tmp/1.conf
    - src: 2.conf
      dest: /tmp/2.conf
  - name: Mahe sure Apache is started now and at boot
    service: name=apache state=started enabled=yes
```
#### Limit
```ansible-playbook playbook.yml --limit centos7```  
```ansible-playbook playbook.yml --limit host.xyz```
Показать хосты, для которых применится плейбук, без его запуска:  
```ansible-playbook playbook.yml --list-hosts```  
#### User
```ansible-playbook playbook.yml --user=vasya```  
```ansible-playbook playbook.yml --become --become-user=petya --ask-become-pass```
```ansible-playbook playbook.yml --user=vasya -ask-pass```
### Other options
- --inventory=PATH (-i PATH) - определяет расположение inventory файла (default: /etc/ansible/hosts)
- --verbose (-v) - подробный лог, можно -vvvv
- --extra-vars=VARS (-e VARS) - переменные в формате "key1=value,key2=value"
- --forks=NUM (-f NUM) - число параллельных процессов (по умолчанию 5)
- --connection=TYPE (-c TYPE) - тип соединения, по умолчанию ssh. Можно local для выполнения на локальной машине
- --check - проверка возможности запуска на всех хостах
#### Handlers
``` bash
handlers:
  - name: restart apache
    service: name=apache2 state=restarted
    notify: restart memcached

  - name: restart memcached
    service: name=memcached state=restarted

tasks:
  - name: Rebuild app configuration.
    command: /opt/app/rebuild.sh
    notify:
      - restart apache
      - restart memcached
```
Обработчик запускается ТОЛЬКО после окончания плейбука. Если нужно выполнить в середине, то надо использовать модуль meta: flush_handlers.  
### Переменные окружения
Лучше передавать через опцию register.  
``` bash
- name: Add an env var to the remote user's shell.
  lineinfile: "dest=~/.bash_profile regexp=^ENV_VAR= \
  line=ENV_VAR=value"

- name: Get the value of the env var
  shell: 'source ~/.bash_profile && echo $ENV_VAR'
  register: foo

- name: Printy the value of the env var.
  debug: msg="The var is {{ foo.stdout }}" 
```
Можно добавить в глобальные переменные /etc/environment:  
``` bash
- name: Add a global environment var.
  lineinfile: "dest=/etc/environment regexp=^ENV_VAR= \
  line=ENV_VAR=value"
  become: yes
```
Если переменных много, то лучше использовать файл и модули copy или template.
### Переменные
Можно передавать через:
#### команду или в плейбуке
```ansible-playbook example.yml --extra-vars "foo=bar"```  
``` bash
- hosts: example
  vars:
    foo: bar
  tasks:
    - debug: msg="Variable 'foo' is set to {{ foo }}"
```
#### подключаемый отдельный файл
``` bash
- hosts: example
  vars_files:
    - vars.yml
  tasks:
    - debug: msg="Variable 'foo' is set to {{ foo }}"
```
Например, для apache и разных ОС можно сделать так:  
``` bash
- hosts: example
  vars_files:
    - "apache_default.yml"
    - "apache_{{ ansible_os_family }}.yml"
  tasks:
    - service: name={{ apache }} state=running
```
#### файл inventory переменные в той же строки и отдельным блоком
```bash
[centos]
app1.example.com proxy_state=present
app2.example.com proxy_state=absent

[centos:vars]
aapi_version=3.0.1
```
#### Можно добавлять переменные к хосту или группу, используя host_vars и group_vars
Для этого в директории /etc/ansible/host_vars/app1.example.com или :
``` bash
---
foo: basr
xyz: qwe
```
### Переменная register
Используется для записи stderr или stdout для последующего использования
``` bash
- name: "123"
  command: forever list
  register: forever_list
  changed_when: false

- name: "234"
  command: forever start
  when: "forever_list.stdout.find(node_apps_location + '/app/app.js') == -1"
```
### Обращение к переменным
``` bash
foo_list:
  - one
  - two
  - three
# Обращение к элементу массива
foo[0]
foo|first
```
``` bash
tasks:
  - debug: var=ansible_eth0
# Обращение к элементу массива
{{ ansible_eth0.ipv4.address }}
{{ ansible_eth0['ipv4']['address'] }}
```
### Магические переменные
```bash
{{ hostvars['host1']['var1'] }}
hostvars # переменная содержащая все переменные всех хостов
groups # список всех групп в inventory
inventory_hostname # имя хоста согласно inventory, может отличаться от ansible_hostname
inventory_hostname_short # первая часть от inventory_hostname
play_hosts # все хосты, на которых будет запущен плейбук
```
### Факты Gathering Facts
Факты о хостах собираются в самом начале плейбука (IP, CPU, disk space, OS info, network interface info).  
Получить весь список фактов: ansible zabbix -m setup   
Для отключения сбора информации в плейбуке указать:  
``` bash
- hosts: db
  gather_facts: no
```
Факты можно хранить локально на хостах в файлах: /etc/ansible/facts.d/nameXXX.fact:
``` bash
[users]
admin=vasya,petya
normal=jim
```
Конечно лучше описывать переменные централизованно, но использование фактов на удаленных хостах может быть целесообразно, если они зависят от локальных переменных.  
### Ansible Vault
```bash
- hosts: appserver

  vars_files:
    - vars/api_key.yml

  tasks:
    - name: Connect to service with API key
      command: connect_to_service
      environment:
        SERVICE_API_KEY: "{{ myapp_service_api_key }}"
```
Зашифровать файл: ansible-vault encrypt api_key.yml  
Запустить плейбук с интерактивным запросом пароля: ansible-playbook test.yml --ask-vault-pass  
Для удоства и автоматизации можно сохранять в файл ~/.ansible/vault_pass.txt с правами 600. Запуск так:   
```ansible-playbook test.yml --vault-password-file ~/.ansible/vault_pass.txt```  
## Иерархия переменных
1. --extra-vars в командной строке (всегда выигрывают)  
2. уровень task (для блока таск)  
3. уровень блока (для всех тасков в блоке)  
4. из модуля include_vars и [role]/vars/main.yml
5. set_facts модуль
6. register в таске
7. vars_files, vars_prompt, vars
8. host facts
9. playbook host_vars
10. playbook group_vars
11. inventory: host_vars, group_vars, vars
12. role default ([role]/defaults/main.yml)

## if/then/when
```bash
# software_version="4.3.9"
# is_db_server=true
- name: Do ....
  [task here]
  when: software_version.split('.')[0] == '4'
  when: (is_db_server is defined) and is_db_server
```
```bash
- command: my-app --status
  register: myapp_result
- command: do-something-to-my-app
  when: "'ready' in myapp_result.stdout"
```
```bash
- command: forever list
  register: forever_list
- command: forever start /path/to/app/app.js
  when: "forever_list.stdout.find('/path/to/app/app.js') == -1"
```
```bash
- stat: path=/etc/hosts
  register: hosts_file
- copy: src=path/to/local/file dest=/path/to/remote/file
  when: hosts_file.stat.exists == false
```
### Переопределение вывода failed_when, changed_when
```bash
---
- name: test2
  hosts: zabbix
  become: yes 
  gather_facts: no

  tasks:
  - command: "echo test"
    register: composer
    failed_when: "'tvest' not in composer.stdout" or
    changed_when: "'tvest' not in composer.stdout"
```
### ignore_errors: true - игнорировать любые ошибки
## Делегирование выполнения в независимости от указанной группы хостов
```bash
- name: Add server to monitoring
  command: monitor-server webservers {{ inventory_hostname }}
  delegate_to: "{{ monitoring_master }}"
```
```bash
- name: Remove server from load balancer
  command: remove-from-lb {{ inventory_hostname }}
  delegate_to: 127.0.0.1
```
```bash
- name: Remove server from load balancer
  local_action: remove-from-lb {{ inventory_hostname }}
```
Для выполнения целого плейбука локально нужно его запускать с пароаметром --connection=local и внутри hosyts: 127.0.0.1.   
## Пауза при выполнении с wait_for
```bash
- name: Wait for web server to start
  local_action:
    module: wait_for
    host: "{{ inventory_hostname }}"
    port: "{{ webserver_port }}"
    delay: 10
    timeout: 300
    state: started
```
## Prompts / параметры вводимые пользователем
```bash
- hosts: all

  vars_prompt:
    - name: share_user
      prompt: "What is your network user"

    - name: share_user
      prompt: "What is your network password"
      private: yes
      encrypt/confirm/salt_size..
```
## Import
```bash
tasks:
  - import_tasks: imported-tasks.yml
```
Если же в imported-tasks.yml есть переменная, значение которой должно высчитаться в процессе выполнения плейбука:    
```bash
tasks:
  - include_tasks: imported-tasks.yml
```
Можно импортировать плейбуки: import_playbook: web.yml.  
