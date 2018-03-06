---
title: Python3 闭包
date: 2018-03-06 14:04:56
tags:
  - Python3
categories:
  - Python3 进阶
  - Python3 闭包
---
闭包是指延伸了作用域的函数，其中包含函数定义体中引用、但是不在定义体中定义的非全局变量。
闭包(closure)是函数式编程的重要的语法结构。闭包也是一种组织代码的结构，它同样提高了代码的可重复使用性。

当一个内嵌函数引用其外部作用域的变量,我们就会得到一个闭包. 总结一下,创建一个闭包必须满足以下几点:

  1. 必须有一个内嵌函数
  2. 内嵌函数必须引用外部函数中的变量
  3. 外部函数的返回值必须是内嵌函数

闭包是一种函数，它会保留定义函数时存在的自由变量的绑定，这样调用函数时虽然定义作用域不可用了，但仍能使用那些绑定。
<!-- more -->

闭包的概念难以掌握，最好通过示例理解。

假如有个名为avg的函数，他的作用是计算不断增加的系列值得平均数。起初，avg是这样使用的：
```Python
>>> avg(10)
10.0
>>> avg(11)
10.5
>>> avg(12)
11.0

```
初学者可能会用类来实现，如示例1
```python
# 示例1
class Averager(object):
    """docstring for Average."""
    def __init__(self):
        self.series = []

    def __call__(self, new_value):
        self.series.append(new_value)
        total = sum(self.series)
        return total/len(self.series)

```
Average的实例是可调用对象：
```python
>>> avg = Averager()
>>> avg(10)
10.0
>>> avg(11)
10.5
>>> avg(12)
11.0
```

下面使用函数式实现，如示例2：
```python
# 示例2
def make_averager():
    series = []

    def averager(new_value):
        series.append(new_value)
        total = sum(series)
        return total/len(series)

    return averager

```
调用make_averager时，返回一个averager函数对象。每次调用averager时，他会把参数添加到系列值中，然后计算当前平均值，如下所示：
```python
>>> avg = make_averager()
>>> avg(10)
10.0
>>> avg(11)
10.5
>>> avg(12)
11.0
```

注意，以上两个示例有共通之处：调用Averager()或make_averager()得到一个可调用对象avg，他会更新历史值，然后计算当前均值。示例1中，avg是Averager的实例；实例2中是内部函数averager。不管怎样，我们都只需要调用avg(n),把n放入系列值中，然后重新计算均值。

Averager()类的实例avg在哪里存储历史值很明显：self.series实例属性；但是第二个示例中的avg函数在哪里寻找series呢？

注意，series是make_averager函数的局部变量，因为那个函数的定义体中初始化了series：series = []。可是，调用avg(10)时，make_averager函数已经返回了，而他的本地作用域也一去不复返了。

在averager函数中，series是自由变量。这是一个技术术语，指未在本地作用域中绑定的变量，如图：

![闭包](http://upload-images.jianshu.io/upload_images/2952111-039ebc44d7803bbd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**averager的闭包延伸到那个函数的作用域之外，包含自由变量series的绑定**

我们可以审查返回的averager对象，发现Python在`__code__`属性（表示编译后的函数定义体）中保存局部变量和自由变量的名称，如下所示

```Python
# 审查make_averager创建的函数
>>> avg.__code__.co_varnames
('new_value', 'total')
>>> avg.__code__.co_freevars
('series',)
```

series绑定在返回的avg函数的`__closure__`属性中。`avg.__closure__`中各个元素对应于`avg.__code__.co_freevars`中的一个名称。这些元素是cell对象，有个`cell_content`属性，保存着真正的值。这些属性的值如示例所示：
```python
>>> avg.__code__.co_freevars
('series',)
>>> avg.__closure__
(<cell at 0x108b89828: list object at 0x108ae96c8>,)
>>> avg.__closure__[0].cell_contents
[10,11,12]
```
综上，闭包是一种函数，它会保留定义函数时存在的自由变量的绑定，这样调用函数时虽然定义作用域不可用了，但仍能使用那些绑定。

注意，只有嵌套在其他函数中的函数才可能需要处理不在全局作用域中的外部变量。
