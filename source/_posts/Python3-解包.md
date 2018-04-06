---
title: Python3 解包
date: 2018-04-06 23:31:01
tags:
  - Python3
categories:
  - Python3 进阶
---

Python中的解包可以这样理解：一个可迭代对象是一个整体，想把可迭代对象中每个元素当成一个个个体剥离出来，这个过程就是解包。下面将举例说明。


**可迭代对象每个元素赋值给一个变量**
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

```
<!-- more -->
