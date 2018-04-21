---
title: Python3 is和==的区别
date: 2018-03-03 12:16:34
tags:
  - Python3
categories:
  - Python3 进阶
---

## Python 对象三要素
要理解Python中is和==的区别，首先要理解Python对象的三个要素:


| 要素        | 说明         |获取方式   |
| :-----:       | :-----:      | :-----:   |
| id      | 身份标识，基本就是内存地址，用来唯一标识一个对象  | id(obj)  |
|type      | 数据类型   | type(obj)  |
|value      | 值   | :-----:   |

<!-- more -->
## is和==区别

| 标识       | 名称         |判断方法   |
| :-----:       | :-----:      | :-----:   |
| is      | 同一性运算符  | id  |
| ==      | 比较运算符  | value  |

---
## 程序举例

### 例1：
![屏幕截图2.jpg](http://upload-images.jianshu.io/upload_images/2952111-ec5fa82d12a42a34.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```python
a = {"a":1, "b":2}
b = a.copy()


a == b  # True value一样
a is b  # False id不一样
```
---
### 例2：
![屏幕截图.jpg](http://upload-images.jianshu.io/upload_images/2952111-21696bc9de2d0e56.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```python
>>> x = y = [4,5,6]
>>> z = [4,5,6]
>>> x == y
True
>>> x == z
True
>>> x is y
True
>>> x is z
False
>>>
>>> print id(x)
>>> print id(y)
>>> print id(z)
```

---
```python
>>> a = 1 #a和b为数值类型
>>> b = 1
>>> a is b
True
>>> id(a)
>>> id(b)
>>> a = 'cheesezh' #a和b为字符串类型
>>> b = 'cheesezh'
>>> a is b
True
>>> id(a)
>>> id(b)
>>> a = (1,2,3) #a和b为元组类型
>>> b = (1,2,3)
>>> a is b
False
>>> id(a)
>>> id(b)
>>> a = [1,2,3] #a和b为list类型
>>> b = [1,2,3]
>>> a is b
False
>>> id(a)
>>> id(b)
>>> a = {'cheese':1,'zh':2} #a和b为dict类型
>>> b = {'cheese':1,'zh':2}
>>> a is b
False
>>> id(a)
>>> id(b)
>>> a = set([1,2,3])#a和b为set类型
>>> b = set([1,2,3])
>>> a is b
False
>>> id(a)
>>> id(b)
```
