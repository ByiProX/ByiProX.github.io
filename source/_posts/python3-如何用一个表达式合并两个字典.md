---
title: python3 如何用一个表达式合并两个字典
date: 2018-03-03 01:00:28
tags:
  - Python3
categories:
  - Python3 进阶
  - Python3 数据结构
---

有两个Python字典,写一个表达式来返回两个字典的合并。`update()`方法返回的是空值而不是返回合并后的对象.
```python    
>>> x = {'a':1, 'b': 2}
>>> y = {'b':10, 'c': 11}
>>> z = x.update(y)
>>> print z
None
>>> x
{'a': 1, 'b': 10, 'c': 11}
```
如何才能让值保存在z而不是x?
<!-- more -->

对于python2可以用下面的方法:
```python    
z = dict(x.items() + y.items())
```
最后就是你想要的最终结果保存在字典z中,而键`b`的值会被第二个字典的值覆盖.
```python
>>> x = {'a':1, 'b': 2}
>>> y = {'b':10, 'c': 11}
>>> z = dict(x.items() + y.items())
>>> z
{'a': 1, 'c': 11, 'b': 10}
```
对于Python3：
```python
>>> z = dict(list(x.items()) + list(y.items()))
>>> z
{'a': 1, 'c': 11, 'b': 10}
```

还可以这样:
```python
z = x.copy()
z.update(y)
```
