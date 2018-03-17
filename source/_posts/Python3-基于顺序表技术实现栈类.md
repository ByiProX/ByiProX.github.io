---
title: Python3 基于顺序表技术实现栈类
date: 2018-03-17 14:40:55
tags:
  - Python3
  - Algorithm
  - Data Structures
categories:
  - Data Structures
---
## 定义异常类
实现栈结构之前，先考虑为操作失败的处理定义一个异常类。在这里通过继承已有的异常类定义自己的异常类。由于栈操作(如空栈弹出)时不满足需要可以看做参数值错误，采用下面的定义
```Python
class StackUnderflow(ValueError):  # 栈下溢，空栈访问
    pass
```
上面把异常`StackUnderflow`定义为`ValueError`子类，只简单定义了一个类名，类体部分只有一个`pass`语句，未定义任何新属性，因为不准备提供`ValueError`之外的新功能，只是想与其他`ValueError`异常有所区分，程序出错时能产生不同的错误信息。必要时可以定义专门的异常处理操作。自定义异常与python内置异常类似，同样通过`except`进行捕捉和处理，但只能通过`raise`语句引发。

<!-- more -->
## 栈类定义
把list当做栈使用时，完全可以满足应用需要。但是，这样建立的对象实际上还是list，提供了list类型的所有操作。特别是提供了一大批栈结构原本不应该支持的操作，威胁栈的使用安全性(例如，栈要求未经弹出的元素应该存在，但表运行任意删除)。另外，这样的“栈”不是一个独立的类型，因此没有独立类型的所有重要性质。

为了概念更清晰，实现更安全，操作名也更容易理解，，可以考虑使用顺序表定义一个栈类，使之成为一个独立的类型，把Python的list隐藏在类内部，作为其实现基础。

```python
"""
基于顺序表实现栈类
用list对象 _elems存储栈中的元素
所有的栈操作都映射到list操作
"""
class SStack(object):
    def __init__(self):
        self._elems = []

    def is_empty(self):
        return self._elems == []

    def top(self):
        if self._elems == []:
            raise StackUnderflow('in SStack.top()')
        return self._elems[-1]

    def push(self, elem):
        self._elems.append(elem)

    def pop(self):
        if self._elems == []:
            raise StackUnderflow('in SStack.pop()')
        return self._elems.pop()
```

## 参考

1. 《数据结构与算法Python语言描述》 --- 裘宗燕
