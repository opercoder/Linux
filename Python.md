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
## Условный оператор If
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
## Словари
``` python
alien_0 = {} # Пустой словарь
alien_0 = {'color': 'green', 'points': 5} 
print(alien_0['color'])  
print(alien_0['points'])
del alien_0['points']
point_value = alien_0.get('points', 'No point value assigned.') # Вернет значение ключа points или значение по умолчанию. Главное не будет ошибки!
point_value = alien_0.get('points') # Вернет значение ключа points или значение None.
# Цикл по элементам словаря  
for key, value in user_0.items():
    print(f"\nKey: {key}")
    print(f"Value: {value}")
# Цикл по ключам в отсортированном порядке
for name in sorted(favorite_languages.keys()):
    print(f"{name.title()}, thank you for taking the poll.")
# Цикл по значениям
for language in favorite_languages.values():
    print(language.title())
# Цикл по значениям в словаре без повторений
for language in set(favorite_languages.values()):
    print(language.title())
```
## Ввод данных
``` python
prompt = "If you tell us who you are, we can personalize the messages you see."
prompt += "\nWhat is your first name? "
name = input(prompt)
age = input("How old are you? ") # По умолчанию age типа string
age = int(age) # Преобразование типов
age >= 18
```
## Цикл While
``` python
current_number = 1
while current_number <= 5:
    print(current_number)
    current_number += 1
# Флаг
active = True
while active:
    message = input(prompt)
    if message == 'quit':
        active = False
    else:
        print(message)
# Break
while True:
    city = input(prompt)
    if city == 'quit':
        break
    else:
        print(f"I'd love to go to {city.title()}!")
# Continue
current_number = 0
while current_number < 10:
    current_number += 1
    if current_number % 2 == 0:
        continue
    print(current_number)
# Удаление всех вхождений значения в списке
while 'cat' in pets:
    pets.remove('cat')
```
## Функции
``` python
def describe_pet(pet_name, animal_type='dog', animal_age=''): # dog - значение по умолчанию, 
    """Display information about a pet.""" # Docstring для описания функции
    print(f"\nI have a {animal_type}.")
    print(f"My {animal_type}'s name is {pet_name.title()}.")
    full_name = f"{animal_type} {pet_name}"
    return full_name.title()
    
describe_pet(pet_name='harry')
describe_pet('harry','hamster')
describe_pet('whilee')
name = describe_pet(animal_type='hamster', pet_name='harry')
# Передача в функцию копию списка, чтобы не модифицировать исходный
function_name(list_name[:])
# Передача в функцию переменного количества аргументов
def make_pizza(*toppings):
    """Print the list of toppings that have been requested."""
    print(toppings)
make_pizza('pepperoni')
make_pizza('mushrooms', 'green peppers', 'extra cheese')
# Передача в функцию переменного количества аргументов вида ключ, значение
def build_profile(first, last, **user_info):
    """Build a dictionary containing everything we know about a user."""
    user_info['first_name'] = first
    user_info['last_name'] = last
    return user_info
user_profile = build_profile('albert', 'einstein',location='princeton',field='physics')
print(user_profile)
```
## Импорт
``` python
import pizza # Импорт файла pizza.py
from module_name import function_0, function_1, function_2 # Импорт отдельных функций
from module_name import function_name as fn # Альяс для функции
import pizza as p # Альяс для модуля
from module_name import * # Импорт всех функций модуля
```
## Классы
``` python
class Dog:
    """A simple attempt to model a dog."""
    def __init__(self, name, age):
        """Initialize name and age attributes."""
        self.name = name
        self.age = 0 # значение по умолчанию
    def sit(self):
        """Simulate a dog sitting in response to a command."""
        print(f"{self.name} is now sitting.")
    def roll_over(self):
        """Simulate rolling over in response to a command."""
        print(f"{self.name} rolled over!")
# Наследование класса
class ElectricCar(Car):
    """Represent aspects of a car, specific to electric vehicles."""
    def __init__(self, make, model, year):
        """Initialize attributes of the parent class."""
        super().__init__(make, model, year) # super - специальная функция для вызова метода из родительского класса
```
## Чтение из файла
``` python
file_path = '/home/ehmatthes/other_files/text_files/filename.txt'
with open('file_path') as file_object: # with закрывает файл после его использования
    contents = file_object.read()
print(contents)
# Чтение построчно
with open(filename) as file_object:
    for line in file_object:
        print(line.rstrip())
# Создать список строк из файла
filename = 'pi_digits.txt'
with open(filename) as file_object:
    lines = file_object.readlines()
for line in lines:
    print(line.rstrip())
```
