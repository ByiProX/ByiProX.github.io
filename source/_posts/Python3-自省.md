---
title: Python3 自省
date: 2018-03-01 16:19:37
tags:
  - Python3
categories:
  - Python3 进阶
  - Python 自省
---

自省是python彪悍的特性之一.

自省（introspection）是一种自我检查行为。在计算机编程中，自省是指这种能力：检查某些事物以确定它是什么、它知道什么以及它能做什么。自省向程序员提供了极大的灵活性和控制力.

<!-- more -->

自省就是面向对象的语言所写的程序在运行时,所能知道对象的类型.简单一句就是运行时能够获得对象的类型.比如type(),dir(),getattr(),hasattr(),isinstance().

```python
a = [1,2,3]
b = {'a':1,'b':2,'c':3}
c = True
print type(a),type(b),type(c) # <type 'list'> <type 'dict'> <type 'bool'>
print isinstance(a,list)  # True
```


未完待续

参考：
1. http://python.jobbole.com/82110/
2. http://blog.csdn.net/IAlexanderI/article/details/78768378
