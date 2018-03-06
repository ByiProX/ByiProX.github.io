---
title: Python3 nonlocal声明
date: 2018-03-06 14:58:07
tags:
  - Python3
categories:
  - Python3 进阶
  - Python3 闭包
---
前一节讲闭包时用到以下代码：
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
以上实现make_averager函数的方法效率不高。在如下示例中,我们把所有值存储在历史数列中，然后在每次调用averager时使用sum求和。更好的实现方式是，只存储目前的总和以及元素个数，然后使用这两个值计算平均数。以下是实现方式，这种实现方式存在缺陷，只是为了引出`nonlocal声明`。
<!-- more -->
```python
def make_averager():
    count = 0
    total = 0
    def averager(new_value):
        count += 1
        total += new_value
        return total/count

    return averager

```

尝试使用以上定义的函数，得到如下结果：
```python
>>> avg = make_averager()
>>> avg(10)
---------------------------------------------------------------------------
UnboundLocalError                         Traceback (most recent call last)
<ipython-input-42-ace390caaa2e> in <module>()
----> 1 avg(10)

<ipython-input-38-371a27b41829> in averager(new_value)
      3     total = 0
      4     def averager(new_value):
----> 5         count += 1
      6         total += new_value
      7         return total/count

UnboundLocalError: local variable 'count' referenced before assignment
```

问题是，当count是数字或任何不可变类型时，`count += 1`语句的作用其实与`count = count + 1`一样，因此我们在averager的定义体中为count赋值了，这样会把count变量变为局部变量，而不是自由变量。total变量也会受到这样的影响。

示例2 中没有遇到这样的问题是因为我们没有给series赋值，我们只是调用`series.append`，并把它传给sum和len。也就是说，我们利用了列表是可变的对象这一事实。

但是对数字和字符串、元组等不可变类型来说，只能读取，不能更新。如果尝试重新绑定，例如count += 1,其实会隐式的创建局部变量count。`这样count就不是自由变量了，也就不会保存在闭包中`。

为了解决这个问题，python3引入了`nonlocal声明`。他的作用是把变量标记为自由变量，即使在函数中变量赋予新值，也会变成自由变量。如果为nonlocal声明的变量赋予新值，闭包中保存的绑定会更新。正确版的make_averager的正确实现如下：
```python
def make_averager():
    count = 0
    total = 0
    def averager(new_value):
        nonlocal count, total
        count += 1
        total += new_value
        return total/count

    return averager

```
这样一来，上面的错误就没有了。
