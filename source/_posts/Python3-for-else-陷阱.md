---
title: Python3 for ... else ...陷阱
date: 2018-03-29 17:49:49
tags:
  - Python3
categories:
  - Python3 进阶
---
假设有如下代码：
```Python
for i in range(10):
    if i == 5:
        print 'found it! i = %s' % i
else:
    print 'not found it ...'

```
我们期望的结果是，当找到5时打印出：
```python
found it! i = 5
```
实际上打印出来的结果为：
```python
found it! i = 5
not found it ...
```
显然这不是我们期望的结果。
<!-- more -->

根据官方文档说法：
>When the items are exhausted (which is immediately when the sequence is empty), the suite in the else clause, if present, is executed, and the loop terminates.

>A break statement executed in the first suite terminates the loop without executing the else clause’s suite. A continue statement executed in the first suite skips the rest of the suite and continues with the next item, or with the else clause if there was no next item.

>https://docs.python.org/2/reference/compound_stmts.html#the-for-statement


大意是说`当迭代的对象迭代完并为空时，位于else的子句将执行`，`而如果在for循环中含有break时则直接终止循环，并不会执行else子句`。

所以正确的写法应该为：
```python
for i in range(10):
    if i == 5:
        print 'found it! i = %s' % i
        break
else:
    print 'not found it ...'
```

当使用pylint检测代码时会提示:
```python
Else clause on loop without a break statement (useless-else-on-loop)
```
所以养成使用pylint检测代码的习惯还是很有必要的，像这种逻辑错误不注意点还是很难发现的。

**同样的原理适用于`while ... else`循环**

**参考**

1. https://www.cnblogs.com/dspace/p/6622799.html
