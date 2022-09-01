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
``` python
name = " test string "
print(name.title()) # Сделать первую букву заглавной
print(name.strip()) # Удаляет пробелы по краям (есть также rstrip, lstrip)
print(name.upper()) # Сделать все буквы заглавные
print(name.lower()) # Сделать все буквы в нижнем регистре
```
##### F-строки
``` python
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
##### Строковые
``` python
bicycles = ['trek', 'cannondale', 'redline', 'specialized']
print(bicycles[0])
print(bicycles[-1].title())
bicycles.append('moto') # Вставка в конец списка
bicycles.insert(0,'moto') # Вставка со смещением элементов
del bicycles[0] # Удаление элемента из списка
popped_bicycle = bicycles.pop() # Удаляет элемент из списка и присваивает его значение переменной
bicycles.remove('trek') # Удаление по значению
bicycles.sort() # Сортирует по алфавиту с начала
bicycles.sort(reverse=True) # Сортировка по алфавиту в обратном порядке
print(sorted(bicycles)) # Отображение сортированного списка без его изменения
bicycles.reverse() # Перезапись списка в обратном порядке
len(bicycles) # Длина списка
for bicecycle in bicycles: # Цикл по списку
```
##### Нумерованные
``` python
for value in range(1, 5): 
  print(value) # Напечатает от 1 до 4
numbers = list(range(1, 6)) # Напечатает от 1 до 5
numbers = list(range(1, 6, 2)) # Напечатает 1, 3, 5
min(numbers) # Минимальное число
max(numbers) # Максимальное число
sum(numbers) # Сумма
squares = [value**2 for value in range(1, 11)] # Задание списка с действием
```
##### Операции со списками
``` python
print(numbers[1:3]) # Вырезать часть списка с индекса 1 до индекса 2 (3 невключительно)
print(numbers[:4]) # Вырезать часть списка с начала до индекса 3 (4 невключительно)
print(numbers[2:]) # Вырезать часть списка с индекса 2 до конца
print(numbers[-1:]) # Вырезать последние 2 элемента списка
for number in numbers[:3]: # Цикл по вырезанному списку
newlist = numbers[:] # Копирование списка
```
## Кортежи - неизменяемый список
``` python
k= (1, 2, 3)
k= (1,) # Кортеж из одного элемента
```
## If
``` python
if conditional_test_1:  
    do_something_1
elif conditional_test_2:
else:
    do_something_3
```
``` python
# If совместно со списками
for requested_topping in requested_toppings:
    if requested_topping == 'green peppers':
# Проверка на пустоту списка
if requested_toppings:
    some_actions
else
    print("List is empty!")
```
