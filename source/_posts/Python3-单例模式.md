---
title: Python3 单例模式
date: 2018-03-19 13:44:05
tags:
  - Python3
  - 设计模式
categories:
  - Python3 进阶
---
单例模式（Singleton Pattern）是最简单的设计模式之一。这种类型的设计模式属于创建型模式，它提供了一种创建对象的最佳方式。
这种模式涉及到一个单一的类，该类负责创建自己的对象，同时确保只有单个对象被创建。这个类提供了一种访问其唯一的对象的方式，可以直接访问，不需要实例化该类的对象。

**注意：**

  * 1、单例类只能有一个实例。
  * 2、单例类必须自己创建自己的唯一实例。
  * 3、单例类必须给所有其他对象提供这一实例。
<!-- more -->
## 单例模式介绍
**意图：** 保证一个类仅有一个实例，并提供一个访问它的全局访问点。

**主要解决：** 一个全局使用的类频繁地创建与销毁。

**何时使用：** 当您想控制实例数目，节省系统资源的时候。

**如何解决：** 判断系统是否已经有这个单例，如果有则返回，如果没有则创建。

**关键代码：** 构造函数是私有的。

**应用实例：** 1、一个党只能有一个主席。 2、Windows 是多进程多线程的，在操作一个文件的时候，就不可避免地出现多个进程或线程同时操作一个文件的现象，所以所有文件的处理必须通过唯一的实例来进行。 3、一些设备管理器常常设计为单例模式，比如一个电脑有两台打印机，在输出的时候就要处理不能两台打印机打印同一个文件。

**优点：** 1、在内存里只有一个实例，减少了内存的开销，尤其是频繁的创建和销毁实例（比如管理学院首页页面缓存）。 2、避免对资源的多重占用（比如写文件操作）。

**缺点：** 没有接口，不能继承，与单一职责原则冲突，一个类应该只关心内部逻辑，而不关心外面怎么样来实例化。

**使用场景：** 1、要求生产唯一序列号。 2、WEB 中的计数器，不用每次刷新都在数据库里加一次，用单例先缓存起来。 3、创建的一个对象需要消耗的资源过多，比如 I/O 与数据库的连接等。

**注意事项：** getInstance() 方法中需要使用同步锁 synchronized (Singleton.class) 防止多线程同时进入造成 instance 被多次实例化。

## 单例模式的实现
在 Python 中，我们可以用多种方法来实现单例模式：

  * 使用基类 `__new__`
  * 使用模块
  * 使用装饰器（decorator）
  * 使用元类（metaclass）


### 使用基类 `__new__`

`__new__` 是真正创建实例对象的方法，所以重写基类的`__new__`方法，以此来保证创建对象的时候只生成一个实例

```python
class Singleton(object):
    def __new__(cls, *args, **kwargs):
        if not hasattr(cls, '_instance'):
            cls._instance = super(Singleton, cls).__new__(cls, *args, **kwargs)
        return cls._instance  

class MyClass(Singleton):  
    a = 1

```
在上面的代码中，我们将类的实例和一个类变量 `_instance` 关联起来，如果 `cls._instance` 为 None 则创建实例，否则直接返回 `cls._instance`。执行结果如下：
```python
>>> one = MyClass()
>>> two = MyClass()
>>> one == two
True
>>> one is two
True
>>> id(one), id(two)
(4303862608, 4303862608)
```

### 使用元类
元类（参考：[深刻理解Python中的元类](http://blog.jobbole.com/21351/)）是用于创建类对象的类，类对象创建实例对象时一定会调用`__call__`方法，因此在调用`__call__`时候保证始终只创建一个实例即可，`type`是python中的一个元类。

元类（metaclass）可以控制类的创建过程，它主要做三件事：

  * 拦截类的创建
  * 修改类的定义
  * 返回修改后的类

使用元类实现单例模式的代码如下：

```python
class Singleton(type):
    def __call__(cls, *args, **kwargs):
        if not hasattr(cls, '_instance'):
            cls._instance = super(Singleton, cls).__call__(*args, **kwargs)
        return cls._instance

class MyClass(metaclass=Singleton):  
    a = 1

## 执行结果如下
>>> one = MyClass()
>>> two = MyClass()
>>> one == two
True
>>> one is two
True
>>> id(one), id(two)
(4303862608, 4303862608)
```

### 使用装饰器
装饰器（decorator）可以动态地修改一个类或函数的功能。这里，我们也可以使用装饰器来装饰某个类，使其只能生成一个实例，代码如下：

```python
def singleton(cls):
    instances = {}
    def wrapper(*args, **kwargs):
        if cls not in instances:
            instances[cls] = cls(*args, **kwargs)
        return instances[cls]
    return wrapper

@singleton
class Foo(object):
    pass
```

**将装饰器写成类形式**
```python
class single03(object):  
        def __init__(self, cls):  
            self._cls = cls  
            self._instances = None;  
        def __call__(self, *args):  
            if not self._instances:  
                self._instances = self._cls(*args)  
            return self._instances  

@single03  
class A(object):  
    def __init__(self, name):  
        self.name = name
```

在上面，我们定义了一个装饰器 singleton，它返回了一个内部函数 `warpper`，该函数会判断某个类是否在字典 instances 中，如果不存在，则会将 cls 作为 key，`cls(*args, **kw)` 作为 value 存到 instances 中，否则，直接返回 instances[cls]

### 使用模块
Python 的模块就是天然的单例模式，因为模块在第一次导入时，会生成 .pyc 文件，当第二次导入时，就会直接加载 .pyc 文件，而不会再次执行模块代码。因此，我们只需把相关的函数和数据定义在一个模块中，就可以获得一个单例对象了。如果我们真的想要一个单例类，可以考虑这样做：
```python
# mysingleton.py
class My_Singleton(object):
    def foo(self):
        pass

my_singleton = My_Singleton()
```

将上面的代码保存在文件 mysingleton.py 中，然后这样使用:
```python
from mysingleton import my_singleton

my_singleton.foo()
```


## 参考
1. http://python.jobbole.com/87294/
2. http://python.jobbole.com/87791/?utm_source=blog.jobbole.com&utm_medium=relatedPosts
