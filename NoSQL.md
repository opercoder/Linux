https://db-engines.com/en/ranking - рейтинг баз данных (в фильтре, например, выбирать key-values stores).  
### REDIS
Для хранения 5 типов данных:  
1. Строки.
2. Списки.
3. Хеши.
4. Множества.
5. Упорядоченные множества.
Можно формировать ключи в виде следующей структуры: **<тип объекта:идентификатор_объекта:атрибут>**:  
CARTOON:1:NAME "Lion King"  
CARTOON:1:YEAR "2003"  
``` REDIS
SELECT 1 # Переключение на БД (0 - по умолчанию)
SET <ключ> <значение> # Установить значение для ключа
GET <ключ> # Посмотреть значение с указанием ключа
KEYS * # Получить список всех ключей

# Значения - строки
STRLEN <ключ> # Подсчет длины значения
GETRANGE <key> <begin> <end> # Возвращает подстроку
APPEND <key> <value> # Добавляет значение к концу существующей строки, при необходимости создает ключ, возвращает длину

# Значения - числа
INCR <key> # Увеличить значение на 1
INCRBY <key> <step> # Увеличить значение на заданный шаг
DECR <key> # Уменьшить значение на 1
DECRBY <key> <step> # Уменьшить значение на заданный шаг

# Значения - хеши
HSET <key> <field> <value> # Задание значения поля
HGET <key> <field> # Получение значения поля
HMSET <key> <field> <value> <field> <value> ... # Множественное задание значений полей
HVALS <key> # Получение всех значений хеш-полей
HKEYS <key> # Получение всех имен хеш-полей
HDEL <key> <field> # Удаляет указанное хеш-поле

# Значения - списки
RPUSH <key> <value> # Добавляет новое значение в список
LLEN <key> # Получает длину списка
RPOP <key> # Возвращает последнее добавленное значение и удаляет его из списка

# Значения - множества
SADD <key> <value> # Добавляет к множеству новые значения
SCARD <key> # Определяет мощность множества
SMEMBERS <key> # Выбирает все элементы множества
SINTER <key1> <key2> # Выполняет пересечение множеств
SINTERSTORE <key1> <key2> <key3> # Выполняет пересение множеств <key2>, <key3> и сохраняет результат в <key1>
SDIFF <key1> <key2> # Вычитание множеств
SDIFFSTORE <key1> <key2> <key3> # Вычитание с сохранением
SUNION <key1> <key2> # Объединение
SUNIONSTORE <key1> <key2> <key3> # Объединение с сохранением

# Значения - упорядоченные множества
ZADD <key> <rank-value> <rank-value> ... # Формирует ранжированное множество
ZCOUNT <key> <rank-from> <rank-to> # Количество элементов с рангом в указанном диапазоне
ZRANK <key> <value> # Порядковый номер заданного значения в ранжированном списке

# Команды определяющие время существования ключа
TTL <key> # Выводит оставшееся время существования ключа
PERSIST <key> # Снимает ограничение существования ключа
EXPIRE <key> <number> # Задает ограничение существования ключа в секундах
EXPIREAT <key> <number> # Задает ограничение существования ключа в секундах от 01.01.1970
SETEX <key> <number> <value> # Задает строковое значение и устанавливает время жизни ключа

# Команды публикаций сообщений и подписки на каналы
SUBSCRIBE <channel1> <channel2> ...
PSUBSCRIBE <pattern>
PUBLISH <channel> <message>
UNSUBSCRIBE <channel1> <channel2> ...
PUNSUBSCRIBE <pattern>

# Команды сортировки
SORT <key> [BY pattern][LIMIT offset count][GET pattern][ASC|DESC][ALPHA][STORE destination]
```
### MongoDB
``` Mongo
# Команды управления
show dbs # Отображает список доступных баз
use <name> # Устанавливает активную базу
db # Отображает имя текущей базы
db.stats() # Демонстрирует статистику текуще базы
show collections # Отображает коллекции текущей базы
db.<collection_name>.insert(document) # Вставляет новый документ в коллекцию

# Выборка данных
db.<collection_name>.find([data_filter[, projection]]) # filter -  условия для выборки, projection - поля для поиска
db.<name>.find().pretty() # Вывод в привычном JSON
db.student.find({age:19},{name:1}) # Вывод имен студентов 19 лет
db.student.find({age:19},{name:1,_id:0}) # Плюс не отображать id
db.student.find({age:19},{name:1,_id:false}) # или так

# Операции сравнения
# $gt, $lt, $gte, $lte, $ne, $eq
db.student.find({age:{$lt:20}})

# Логические операции
# $and, $or, $not
db.student.find({$or:[{name:"Simon"},{name:"Anna"}]})

# Сортировка результатов запроса
db.<collection_name>.find([data_filter[, projection]]).sort({options})
db.student.find().sort({name:-1}) # -1 - в обратном порядке, 1 - прямом
db.student.find().sort({name:-1}).limit(3) # Отобразить только 3 результата
db.student.find().sort({name:-1}).skip(1).limit(3) # Пропустить 1 документ

# Агрегирование
db.student.count()

# Обновление полей
db.<collection_name>.update({name:Anna, age:29},{$set:{age:30}},{multi:true})
# Удаление полей
db.<collection_name>.update({name:Anna},{$unset:{age:30, surname:"JOSEF"}},{multi:true})

# Индексы
db.student.createIndex({"name":1}, {"inique":true})
db.student.indexes.find()
db.student.dropIndex({"name":1})
```
### CASSANDRA
