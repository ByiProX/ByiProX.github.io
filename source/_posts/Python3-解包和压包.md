---
title: Python3 解包和压包
date: 2018-04-06 23:31:01
tags:
  - Python3
categories:
  - Python3 进阶
---

Python中的解包可以这样理解：一个可迭代对象是一个整体，想把可迭代对象中每个元素当成一个个个体剥离出来，这个过程就是解包。下面将举例说明。


## **可迭代对象每个元素赋值给一个变量**
```python
# 列表
>>> name, age, date = ['Bob', 20, '2018-1-1']
>>> name
'Bob'
>>> age
20
>>> date
'2018-1-1'

>>> a, b, c = enumerate(['a', 'b', 'c'])
>>> a
(0, 'a')

# 元组
>>> a, b, c = ('a', 'b', 'c')
>>> a
'a'

# 字典
>>> a, b, c = {'a':1, 'b':2, 'c':3}
>>> a
'a'

>>> a, b, c = {'a':1, 'b':2, 'c':3}.items()
>>> a
('a', 1)

>>> a, b, c = {'a':1, 'b':2, 'c':3}.values()
>>> a
1

# 字符串
>>> a, b, c = 'abc'
>>> a
'a'

# 生成器
>>> a, b, c = (x + 1 for x in range(3))
>>> b
2
```
<!-- more -->

## **星号"*"的使用---解包**

比如我们要计算平均分，去除最高分和最低分，除了用切片，还可以用解包的方式获得中间的数值
```python
>>> small, *new, big = sorted([93,12,33,55,99])
>>> new
[33, 55, 93]
```

## **压包与解包**
```python
a = ['a', 'b', 'c']
b = [1, 2, 3]
for i, j in zip(a, b):
    print(i+j)

# 输出
1
3
5
```
分析以上代码：
1. zip函数将a, b压包程一个可迭代对象
2. 对可迭代对象的每一个元素（('a', 1)）进行解包（i, j = ('a', 1)）
3. 接下来可以分别调用i, j变量进行计算

再举一个例子：
```python
l = [
    ('Bob', '1991', '60'),
    ('Bill', '1992', '65'),
    ('Mike', '1993', '70')
]
for name, *args in l:
    print(name, args)

Bob ['1991', '60']
Bill ['1992', '65']
Mike ['1993', '70']
```

## **"_"的用法**
当一些变量不用时，用`_`表示是更好的写法，可以让读代码的人知道这个元素是不要的
```python
>>> p = ('Bob', 20, 50, (11,20,2000))
>>> name, *_, (*_, year) = p
>>> name
'Bob'
>>> year
2000
```

## **多变量同时赋值**
```python
>>> a, b = 1, 2
>>> a = 1, 2
>>> a
(1, 2)
```
下面用法都会报错
```python
*a = 1, 3
a,b,c = 1,2
```
`但是这种写法是可以的`
```python
>>> *a, = 1,2
>>> a
[1,2]
```

## **“*”之可变参数**
函数定义时，我们使用*的可变参数，其实也是压包解包过程
```python
def func(*args):
    print(args)

>>> func(1,2,3,4)
(1, 2, 3, 4)
```
参数用*num表示，num变量就可以当成元组调用了。
其实这个过程相当于*num, = 1,2,5,6


## **“*”之关键字参数**
```python
def func(**kw):
    print(kw)

>>> func(name = 'Bob', age = 10, weight = 60)
{'name' = 'Bob', 'age' = 10, 'weight' = 60}
```

键值对传入**kw，kw就可以表示相应字典。

`**`的用法只在函数定义中使用，`不能这样使用`
```python
a, **b = {'name' = 'Bob', 'age' = 10, 'weight' = 60}
```

## **可变参数与关键字参数的细节问题**
### 函数传入实参时，可变参数`*`之前的参数不能指定参数名
```python
def func(a, *b):
    print(a)
    print(b)

>>> func(a=1, 2,3,4)
File "<ipython-input-17-978eea76866e>", line 1
  func(a=1, 2,3,4)
           ^
SyntaxError: positional argument follows keyword argument
func(1,2,3,4)
1
(2,3,4)
```

### 函数传入实参时，可变参数`*`之后的参数必须指定参数名，否则就会被归到可变参数之中
```python
def func(a, *b, c = None):
    print(a)
    print(b)
    print(c)

>>> func(1,2,3,4)
1
(2,3,4)
None

>>> func(1,2,3,c=4)
1
(2,3)
4
```
如果一个函数想要使用时必须明确指定参数名，可以将所有参数都放在可变参数之后，而可变参数不用管它就可以，也不用命名，如下:
```python
def func(*, a, b):
    print(a)
    print(b)

>>> func(a = 1, b = 2)
1
2
```
可变参数的这两条特性，可以用于将 只需要按照位置赋值的参数 和 需要明确指定参数名的参数区分开来
### 关键字参数都只能作为最后一个参数，前面的参数按照位置赋值还是名称赋值都可以
```python
def func(a, *b, c, **d):
    print(a)
    print(b)
    print(c)
    print(d)

>>> func(1,2,3,c=4,m=5,n=6)
1
(2,3)
4
{'m': 5, 'n':6}
```

### `可变参数与关键词参数共同使用以表示任意参数`
下面是这一点在装饰器当中的使用

```python
def mydecorator(func):
    def wrapper(*args, **kw):
        print('i am using a decorator')
        return func(*args, **kw)
    return wrapper

@mydecorator
def myfun(a, b):
    print(a)
    print(b)

>>> myfun(1, b = 2)
i am using a decorator
1
2
```
wrapper函数使用`*args`, `**kw`作为参数，则被修饰的myfun函数需要的参数无论是什么样的，传入wrapper都不会报错，这保证了装饰器可以修饰各种各样函数的灵活性。毕竟我们一般在函数中传入参数时，要么所有参数名都写，要么前面几个不写，后面的会写，这样使用`*args`, `**kw`完全没有问题。

## 解包作为参数传入函数中
首先定义一个函数
```python
def myfun(a, b):
    print(a + b)
```
列表|元组的解包
```python
>>> n = [1,2]
>>> myfun(*n)
3
```
字典的解包
```python
>>> mydict = {'a':1, 'b':2}
>>> myfun(**mydict)
3
>>> myfun(*mydict)
'ab'
```

一个简单的应用
```python
>>> Bob = {'name': 'Bob', 'age':20}
>>> "{name}'s age is {age}".format(**Bob)
"Bob's age is 20"
```
## 多返回值函数
下面过程也涉及到了解包
```python
def myfun(a, b):
    print a+1, b+1

>>> m,n = myfun(1,2)
>>> m
2
>>> n
3
```
其本身是一个元组
```python
>>> p = myfun(1, 2)
>>> p
(2, 3)
```
