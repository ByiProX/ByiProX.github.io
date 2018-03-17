---
title: Python3 基于链表技术实现栈
date: 2018-03-17 15:40:12
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

## 定义一个表结点类

```python
class LNode:
    def __init__(self, elem, next_=None):
        self.elem = elem
        self.next = next_
```
方法的第二个参数用名字`next_`，是为了避免与Python`标准函数next`重名

<!-- more -->

## 栈的链接表实现
由于所有栈的操作都在线性表的一端进行，采用链接表技术，自然应该用表头一端作为栈顶，表尾作为栈底，是操作实现方便，效率也高。按照这种安排，容易定义出一个链接栈类。
```python
class LStack:
    def __init__(self):
        self._top = None

    def is_empty(self):
        return self._top is None

    def top(self):
        if self._top is None:
            raise StackUnderflow('in LStack.top()')
        return self._top.elem

    def push(self, elem):
        self._top = LNode(elem, self._top)

    def pop(self):
        if self._top is None:
            raise StackUnderflow('in LStack.pop()')
        p = self._top
        self._top = p.next
        return p.elem



```

## 参考

1. 《数据结构与算法Python语言描述》 --- 裘宗燕
