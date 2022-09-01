## Общее
##### Множественное присвоение
x, y, z = 0, 0, 0
## Типы данных, переменные
### Strings
"This is a string."  
'This is also a string.'  
'I told my friend, "Python is my favorite language!"'  
"The language 'Python' is named after Monty Python, not the snake."  
"One of Python's strengths is its diverse and supportive community."  
##### Методы
``` bash
name = " test string "
print(name.title()) # Сделать первую букву заглавной
print(name.strip()) # Удаляет пробелы по краям (есть также rstrip, lstrip)
print(name.upper()) # Сделать все буквы заглавные
print(name.lower()) # Сделать все буквы в нижнем регистре
```
##### F-строки
``` bash
first_name = "ada"
last_name = "lovelace"

full_name = f"{first_name} {last_name}" # Для Python 3.6 и выше
full_name = "{} {}".format(first_name, last_name) # Для Python 3.5 и ниже

message = f"Hello, {full_name.title()}!"
print(message)
```
### Numbers
##### Integers
2 + 3  
2 - 3  
2 * 3  
2 / 3  
2 ** 3  
Длинные числа можно записывать: 14_000_000  
##### Floats
0.1 + 0.1  
!!! При делении результат всегда типа Float.  

## Списки
``` bash
bicycles = ['trek', 'cannondale', 'redline', 'specialized']
print(bicycles[0])
print(bicycles[-1].title())
bicycles.append('moto') # Вставка в конец списка
bicycles.insert(0,'moto') # Вставка со смещением элементов
del bicycles[0] # Удаление элемента из списка
popped_bicycle = bicycles.pop() # Удаляет элемент из списка и присваивает его значение переменной
```
