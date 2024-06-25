## Структура
main.yml в каждой директории:  
```bash
role_name/
  meta/
  tasks/
```
Запускаются таски из tasks/main.yml.  
## Ansible-Galaxy
ansible-galaxy install NAME - скачивается готовая роль  
ansible-galaxy install -r NAME - скачивается готовая роль с зависимыми ролями  
ansible-galaxy list -  отображает список установленных ролей  
ansible-galaxy remove [role] - удаляет все установленные роли   
ansible-galaxy init - создается шаблон для создания роли  
