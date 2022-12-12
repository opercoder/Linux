``` bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```
## Команды
1. **git commit** - сохранение изменений файлов.
1. **git branch newImage** - создание ветки (ссылки на определенный коммит).
1. **git checkout [branch_name]** - переключение на другую ветку.
1. **git -b checkout [branch_name]** - создание и переключение на новую ветку.
1. **git merge [branch_name]** - слияние ветки branch_name с текущей.
1. **git rebase [branch_name]** - сдвигаем коммиты текущей ветки на вершину указанной ветки.
1. **git checkout [commit_name]** - отделяем HEAD от ветки и указываем на конкретный коммит.
2. **git log** - .
3. **git checkout main^** - переключиться на первого родителя ветки main.
4. **git checkout main^^** - переключиться на прародителя ветки main.
5. **git checkout HEAD^** - переключиться на первого родителя текущей ветки.
6. **git checkout HEAD~4** - переключиться на 4 родителя назад от HEAD.
7. **git branch -f main HEAD~3** - прикрепить ветку напрямую к коммиту - переместит ветку main на 3 родителя назад.
8.                                .
