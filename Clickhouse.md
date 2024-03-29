# ClickHouse -  
столбцовая система управления базами данных (СУБД) для онлайн обработки аналитических запросов (OLAP).  
Значения из разных столбцов хранятся отдельно, а данные одного столбца - вместе.  
### Ключевые особенности OLAP сценария работы
1. подавляющее большинство запросов - на чтение;
1. данные обновляются достаточно большими пачками (> 1000 строк), а не по одной строке, или не обновляются вообще;
1. данные добавляются в БД, но не изменяются;
1.при чтении, вынимается достаточно большое количество строк из БД, но только небольшое подмножество столбцов;
1. таблицы являются «широкими», то есть, содержат большое количество столбцов;
1. запросы идут сравнительно редко (обычно не более сотни в секунду на сервер);
1. при выполнении простых запросов, допустимы задержки в районе 50 мс;
1. значения в столбцах достаточно мелкие - числа и небольшие строки (пример - 60 байт на URL);
1. требуется высокая пропускная способность при обработке одного запроса (до миллиардов строк в секунду на один сервер);
1. транзакции отсутствуют;
1. низкие требования к консистентности данных;
1. в запросе одна большая таблица, все таблицы кроме одной маленькие;
1. результат выполнения запроса существенно меньше исходных данных - то есть, данные фильтруются или агрегируются; результат выполнения помещается в оперативку на одном сервере.
