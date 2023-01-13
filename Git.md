``` bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```
## Команды
1. **git commit** - сохранение изменений файлов.
2. **git commit --amend** - внести изменения в коммит.
3. **git branch newImage** - создание ветки (ссылки на определенный коммит).
4. **git checkout [branch_name]** - переключение на другую ветку.
5. **git -b checkout [branch_name]** - создание и переключение на новую ветку.
6. **git merge [branch_name]** - слияние ветки branch_name с текущей.
7. **git rebase [branch_name]** - сдвигаем коммиты текущей ветки на вершину указанной ветки.
8. **git checkout [commit_name]** - отделяем HEAD от ветки и указываем на конкретный коммит.
9. **git log** - посмотреть историю коммитов.
10. **git checkout main^** - переключиться на первого родителя ветки main.
11. **git checkout main^^** - переключиться на прародителя ветки main.
12. **git checkout HEAD^** - переключиться на первого родителя текущей ветки.
13. **git checkout HEAD~4** - переключиться на 4 родителя назад от HEAD.
14. **git branch -f main HEAD~3** - прикрепить ветку напрямую к коммиту - переместит ветку main на 3 родителя назад.
15. **git reset HEAD~1** - отменяет изменения, перенесет ветку на предыдущий коммит (на локальных ветках).
16. **git revert HEAD** - отменяет изменения, добавляя новый коммит, отменяющий предыдущий( на удаленных ветках). После делаем push.
17. **git cherry-pick \<Commit1\> \<Commit2\> \<...\>** - копировать несколько коммитов на место, где сейчас находишься (HEAD).
18. **git rebase -i HEAD~4** - сдвигаем HEAD назад и интерактивно выбираем какие коммиты добавить в ветку.
19. **git tag v1 c1** - создаем тег с именем v1 и ссылащимся на коммит c1.
20. **git describe** - находит ближайший тег в истории от текущего положения или, если указать, от указанного коммита.  
Вывод команды: \<tag\>_\<numCommits\>_g\<hash\>. Где tag – это ближайший тег в истории изменений, numCommits – это на сколько далеко мы от этого тега, а hash – это хеш коммита, который описывается.
## Gitlab
#### 413 Request Entity Too Large
When attaching a file to a comment or reply in GitLab displays a 413 Request Entity Too Large error, the max attachment size is probably larger than the web server’s allowed value.  
To increase the max attachment size to 200 MB in a Omnibus GitLab install, you may need to add the line below to /etc/gitlab/gitlab.rb before increasing the max attachment size:  
nginx['client_max_body_size'] = "200m"
