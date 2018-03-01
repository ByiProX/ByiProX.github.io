---
title: Python中的单下划线和双下划线
date: 2018-03-01 18:01:50
tags:
  - Python3
categories:
  - Python3 进阶
  - Python
---

### 单下划线

#### 在解释器中
在交互解释器中，`_`符号还是指交互解释器中最后一次执行语句的返回结果。这种用法最初出现在CPython解释器中，其他解释器后来也都跟进了。

#### 作为名称使用
这个跟上面有点类似。`_`用作被丢弃的名称。按照惯例，这样做可以让阅读你代码的人知道，这是个不会被使用的特定名称。举个例子，你可能无所谓一个循环计数的值：
```Python
n = 42
for _ in range(n):
    do_something()
```
#### i18n
`_`还可以被用作函数名。这种情况，单下划线经常被用作国际化和本地化字符串翻译查询的函数名。举个例子，在 [Django documentation for translation](https://docs.djangoproject.com/en/dev/topics/i18n/translation/) 中你可能会看到：

```python
from django.utils.translation import ugettext as _
from django.http import HttpResponse

def my_view(request):
    output = _("Welcome to my site.")
    return HttpResponse(output)
```
**注意**：第二种和第三种用法会引起冲突，所以在任意代码块中，如果使用了_作i18n翻译查询函数，就应该避免再用作被丢弃的变量名。

#### 单下划线前缀的名称


首先是单下划线开头，这个被常用于模块中，在一个模块中以单下划线开头的变量和函数被默认当作内部函数,用来指定私有变量。如果使用 `from a_module import *` 导入时，这部分变量和函数不会被导入。**不过值得注意的是**，如果使用 `import a_module` 这样导入模块，仍然可以用 `a_module._some_var` 这样的形式访问到这样的对象。

另外单下划线开头还有一种一般不会用到的情况在于使用一个 C 编写的扩展库有时会用下划线开头命名，然后使用一个去掉下划线的 Python 模块进行包装。如 struct 这个模块实际上是 C 模块 `_struct` 的一个 Python 包装。

#### 单下划线后缀的名称
在 Python 的官方推荐的代码样式中，还有一种单下划线结尾的样式，这在解析时并没有特别的含义，但通常用于和 Python 关键词区分开来，比如如果我们需要一个变量叫做 class，但 class 是 Python 的关键词，就可以以单下划线结尾写作 class_。



### 双下划线

双下划线开头的命名形式在 Python 的类成员中使用表示名字改编 (Name Mangling)，即如果有一 `Test 类`里有一成员 `__x`，那么 dir(Test) 时会看到 `_Test__x` 而非 `__x`。这是为了避免该成员的名称与子类中的名称冲突。**但要注意这要求该名称末尾最多有一个下划线** [python document](https://docs.python.org/3.4/tutorial/classes.html#tut-private).

双下划线开头双下划线结尾的是一些 Python 的“魔术”对象，如类成员的 `__init__`、`__del__`、`__add__`、`__getitem__` 等，以及全局的 `__file__`、`__name__` 等。 Python `官方推荐永远不要`将这样的命名方式应用于自己的变量或函数，而是按照文档说明来使用。

### 举个栗子


```python
>>> class MyClass():
...     def __init__(self):
...             self.__superprivate = "Hello"
...             self._semiprivate = ", world!"
...
>>> mc = MyClass()
>>> print mc.__superprivate
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: myClass instance has no attribute '__superprivate'
>>> print mc._semiprivate
, world!
>>> print mc.__dict__
{'_MyClass__superprivate': 'Hello', '_semiprivate': ', world!'}
```

`__foo__`:一种约定,Python内部的名字,用来区别其他用户自定义的命名,以防冲突，就是例如`__init__()`,`__del__()`,`__call__()`这些特殊方法

`_foo`:一种约定,用来指定变量私有.程序员用来指定私有变量的一种方式.不能用from module import * 导入，其他方面和公有一样访问；

`__foo`:这个有真正的意义:解析器用`_classname__foo`来代替这个名字,以区别和其他类相同的命名,它无法直接像公有成员一样随便访问,但是可以通过对象名 `_类名__xxx` 这样的方式可以访问.

### 参考
详情见:
1. http://stackoverflow.com/questions/1301346/the-meaning-of-a-single-and-a-double-underscore-before-an-object-name-in-python

2. http://www.zhihu.com/question/19754941

3. https://segmentfault.com/a/1190000002611411

4. https://docs.python.org/3.4/tutorial/classes.html#tut-private
