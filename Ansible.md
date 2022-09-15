## Простые комманды, синтаксис
#### Выполнение удаленно модуля
ansible kube -m ping
#### Выполнение удаленно команды bash
ansible kube -m command -a uptime
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
