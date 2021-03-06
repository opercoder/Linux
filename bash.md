## Команды, аргументы, встроенные функции и ключевые слова
Команды, которые вы можете запустить, определяют либо файлы, либо встроенные функции, либо ключевые слова.  
1. **Файлы (file)** — это исполняемые приложения, которые становятся результатом компиляции и теперь состоят из машинных команд. Примером подобного приложения
служит программа ls. Другой тип файла — это скрипт. Это текстовый файл, который может прочесть
человек. Скрипт пишется на одном из языков, поддерживаемых вашей системой,
с помощью интерпретатора (программы) для этого языка. Примерами языков для
написания скриптов могут служить bash, Python и Perl.  
``` bash 
$ type -t ls
file
compgen -c #Показать список команд (файлов)
```
2. **Встроенные функции (builtin)** — это часть оболочки. Они выглядят как исполняемые
файлы, но в файловой системе нет файла, который загружается для исполнения
того, что делают встроенные функции. Вместо этого работа выполняется внутри
оболочки. Примером встроенной функции служит команда pwd. Применение таких
функций позволит добиться результатов быстрее и с большей продуктивностью.
Как пользователь, вы можете определять наиболее часто используемые функции
оболочки как встроенные команды.  
``` bash
$ type -t pwd
builtin
compgen -b #Показать список встроенных функций
```
3. **Ключевые слова (keyword)** — выглядят как команды, но на самом деле
являются частью языка оболочки, например if. Это слово часто используется
в качестве первого слова в командной строке, но это не команда. Это ключевое 
слово. Оно связано с синтаксисом, который может быть сложнее, чем обычный
формат командной строки: команда -опции аргументы.  
``` bash 
$ type -t if
keyword
compgen -k #Показать список ключевых слов 
```
## Стандартные ввод/вывод/ошибка
На жаргоне специалистов по операционным системам запущенная программа называется процессом. Каждый процесс в среде Unix/Linux/POSIX (и, следовательно,
в Windows) обладает тремя различными файловыми дескрипторами.  
Дескрипторам присвоены следующие названия: стандартный ввод (сокращенно **stdin**), стандартный вывод (**stdout**) и стандартная ошибка (**stderr**).  
При перенаправлении данных, выводимых программой, нужно различать stdout и stderr, и мы создаем
это различие с помощью номеров файловых дескрипторов. Stdin — это файловый дескриптор 0, stdout — файловый дескриптор 1, а stderr — файловый дескриптор 2.  
``` bash
somecommand < data.in > results.out 2> err.msgs # Направлять вывод в файлы, а ввод брать из файла
somecommand < data.in > results.out 2>&1        # Объединить stdout и stderr
somecommand < data.in &> results.out            # Объединить stdout и stderr
somecommand < data.in > /dev/null               # Отсеять стандартный вывод stdout
somecommand < data.in | tee results.out         # Выводить результат на экран и писать в файл
somecommand < data.in &>> results.out           # Добавить stdout и stderr в файл, не перезаписывая его
```
## Выполнение команд в фоновом режиме
Команды могут выполняться в течение довольно длительного времени. Чтобы запустить любую команду или сценарий в фоновом режиме, используйте оператор &.  
Скрипт будет выполняться дальше, но вы сможете продолжать использовать оболочку, давая другие команды и/или выполняя другие сценарии.  
``` bash
ping 10.0.0.1 > ping.log &
ping 10.0.0.1 &> ping.log &
```
Для получения списка задач, которые выполняются в фоновом режиме можно использовать команду jobs:
``` bash
$ jobs
[1]+ Running      ping 10.0.0.1 > ping.log &
```
Чтобы снова вывести задачу в приоритет:
``` bash
$ fg 1
ping 10.0.0.1 > ping.log
```
Для приостановки процесса можно нажать **Ctrl+Z**. Для продолжения работы в фоновом режиме введите **bg**.  
## От командной строки до скрипта
Скрипт оболочки — это просто файл, содержащий команды, которые вы можете последовательно ввести в командную строку. Если ввести одну команду или более в файл, получится скрипт оболочки. Если вы, например, назовете этот файл myscript,
его можно будет запустить, введя команду bash myscript. Кроме того, можете наделить его полномочиями на выполнение
(например, chmod 755 myscript), а затем, чтобы управлять сценарием, вызывать его напрямую: ./myscript. Следующая строка,
сообщающая операционной системе, какой язык скриптов мы используем, часто становится первой строкой скрипта:  
``` bash
#!/bin/bash -  
```
Конечно, в этой строке предполагается, что bash находится в каталоге /bin.
Если вам потребуется сделать скрипт более мобильным, можно воспользоваться следующим подходом:  
``` bash
#!/usr/bin/env bash  
```
Здесь, чтобы найти местонахождение bash, используется команда env. Этот способ
считается стандартным методом решения проблемы мобильности. Однако в данном
случае предполагается, что команду env можно найти в каталоге /usr/bin.
## Вывод
Как и любой другой язык программирования, bash имеет возможность выводить
информацию на экран. Вывод можно успешно выполнить с помощью команды echo:
``` bash
$ echo "Hello World"
Hello World
```
Вы также можете использовать встроенную команду printf, которая позволяет
добавить дополнительное форматирование:
``` bash
$ printf "Hello World\n"
Hello World
```
## Переменные
Переменные bash начинаются с буквенного символа или символа подчеркивания,
за которым следуют алфавитно-цифровые символы. Они являются строковыми,
если не указано иное. Чтобы присвоить значение переменной, вы пишете что-то
вроде этого:
``` bash
MYVAR=textforavalue
```
Чтобы извлечь значение этой переменной (например, вывести на экран с помощью
команды _echo_), вы задаете $ перед именем переменной:
``` bash
echo $MYVAR
```
Если вы хотите присвоить переменной последовательность слов, то есть сохранить
все пробелы, то заключите значение в кавычки:  
``` bash
MYVAR='here is a longer set of words'
OTHRV="either double or single quotes will work"
```
Использование двойных кавычек позволит выполнять другие замены внутри
строки. Например:
``` bash
firstvar=beginning
secondvr="this is just the $firstvar"
echo $secondvr
```
**ВАЖНО:** при использовании двойных кавычек (") любые замены, начинающиеся с $,
все равно выполняются, а если значение находится внутри одинарных кавычек ('), никаких замен не будет.  
Вы также можете сохранить вывод, полученный командой оболочки, с помощью
символов **$( )**, как показано ниже:
``` bash
CMDOUT=$(pwd)
```
Здесь команда pwd выполняется в подоболочке, и вместо того, чтобы печатать
результат в stdout, мы сохраняем вывод команды в переменной CMDOUT. Вы также
можете передать вместе несколько команд внутри $( ).  
#### Позиционные параметры. 
Обычно при использовании инструментов командной строки для передачи данных в команды применяются аргументы или параметры.
Каждый параметр отделяется пробелом и доступен внутри bash с помощью специального набора идентификаторов. В скрипте bash доступ к первому параметру, переданному в скрипт, можно получить с помощью **$1**, ко второму — с **$2** и т. д.  
**$0** — это специальный параметр, который содержит имя скрипта, а  
**$#** возвращает общее количество параметров.
## Ввод
Пользовательский ввод можно получить с помощью команды **read**.
Следующий скрипт читает пользовательский ввод в переменную MYVAR и затем выводит его на экран:
``` bash
read MYVAR
echo "$MYVAR"
```
## Условия
Многие условия начинаются с ключевого слова if. Любая команда или программа, вызываемая в bash,может выполнить вывод, но она также всегда возвращает значение, определяющее успешное или неудачное выполнение.  
В оболочке это значение можно найти в переменной **$?** сразу после запуска команды.  
Возвращаемое значение **0** считается **success** или **true**; любое ненулевое значение считается **error** или **false**.
``` bash
if cmd
then
 some cmds
else
 other cmds
fi
```
**ВАЖНО:** Использование 0 для true и ненулевого значения для false кардинально отличает bash от многих языков программирования (C++, Java, Python и др.). Но для bash это имеет смысл, потому что при неудачном выполнении программы нужно вернуть код ошибки (чтобы объяснить, как она вышла из строя), тогда как при успешном завершении кода ошибки не будет, то есть мы получим 0. Это отражает тот факт, что многие вызовы операционной системы возвращают 0, если все прошло успешно, или –1 (или другое ненулевое значение), если случилась 
ошибка. Исключение - двойнык скобки (( )) в if, тогда 0 = false.  
Например, следующий скрипт пытается изменить каталоги в /tmp.
Если эта команда выполнена успешно (возвращает 0), тело инструкции if будет выполнено.
``` bash
if cd /tmp
then
 echo "here is what is in /tmp:"
 ls -l
fi
```
Bash таким же образом может обрабатывать конвейер команд:
``` bash
if ls | grep pdf
then
 echo "found one or more pdf files here"
else
 echo "no pdf files found"
fi
```
В случае конвейера при проверке на успех/неудачу именно **последняя** команда
определяет, будет ли выбрана true-ветвь. Вот пример, где этот факт имеет значение:  
**ls | grep pdf | wc**  
В более типичной форме команды if, используемой для сравнения, применяется
составная команда \[\[, встроенная команда оболочки \[ или тест. 
Чтобы проверить, существует ли файл в файловой системе, выполните следующую команду:
``` bash
if [[ -e $FILENAME ]]
then
 echo $FILENAME exists
fi
```
Виды проверок:  
**-d** Проверка, существует ли каталог  
**-e** Проверка, существует ли файл  
**-r** Проверка, существует ли файл и доступен ли он для чтения  
**-w** Проверка, существует ли файл и доступен ли он для записи  
**-x** Проверка, существует ли файл и является ли он исполняемым
Для проверки того, что переменная $VAL меньше переменной $MIN, введите следующее:
``` bash
if [[ $VAL -lt $MIN ]]
then
 echo "value is too small"
fi
```
Числовые сравнения:  
**-eq** Тест на равенство между числами  
**-gt** Проверка, больше ли одно число, чем другое  
**-lt** Проверка, меньше ли одно число, чем другое  
**ВАЖНО:** Будьте осторожны с использованием символа <. Рассмотрим следующий код:
**if [[ $VAL < $OTHR ]]** использует лексическое (алфавитное) упорядочение. 
Если вы хотите выполнить численное сравнение со знаком «меньше», используйте конструкцию с двойными скобками **(( ))**. Предполагается, что все переменные являются числовыми, поэтому они так и будут оцениваться. Пустые или неустановленные переменные оцениваются как 0. Внутри скобок вам не нужен оператор $ для получения значения, за исключением позиционных параметров, таких как $1 и $2.
``` bash
if (( VAL < 12 ))
then
 echo "value $VAL is too small"
fi
```
В двойных скобках воспроизводится числовая (C/Java/Python) логика повышенного 
уровня. Любое ненулевое значение считается истинным, и только ноль — обратное 
значение всем остальным операторам if в bash — ложным.  
**if (( $? )) ; then echo "previous command failed" ; fi**  
Команды обычно разделяются новой строкой, но можно разделять их точкой с запятой. Если вы пишете **cd $DIR ; ls** bash сначала выполнит команду cd, а затем команду ls.  
Две команды также могут быть разделены символами **&&** или **||**.  
Если вы напишете **cd $DIR && ls**, команда ls будет выполняться **только в случае успешного выполнения команды cd**.  
Аналогично, если вы введете **cd $DIR || echo cd failed**, сообщение будет напечатано **только в случае сбоя команды cd**.  
Вы можете использовать синтаксис \[\[ для выполнения различных тестов, даже без задания в явном виде if:  
**[[ -d $DIR ]] && ls "$DIR"**
При использовании символов && или || вам нужно сгруппировать несколько операторов, если в ветви then вы хотите выполнить более одного действия:
``` bash
[[ -d $DIR ]] || { echo "error: no such directory: $DIR" ; exit ; }
```
## Циклы
