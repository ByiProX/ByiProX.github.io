---
title: Python3 拷贝对象(深拷贝deepcopy和浅拷贝copy)
date: 2018-03-03 12:10:54
tags:
  - Python3
categories:
  - Python3 进阶
  - Python3 拷贝对象
---

1. copy.copy 浅拷贝 `只拷贝父对象`，不会拷贝对象的内部的子对象。
2. copy.deepcopy 深拷贝 `拷贝对象及其子对象`
---
![屏幕截图3.jpg](http://upload-images.jianshu.io/upload_images/2952111-17e1f4233f95285d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<!-- more -->
```python
# -*-coding:utf-8 -*-
import copy
a = [1, 2, 3, 4, ['a', 'b']] #原始对象

b = a #赋值，传对象的引用
c = copy.copy(a) #对象拷贝，浅拷贝
d = copy.deepcopy(a) #对象拷贝，深拷贝

a.append(5) #修改对象a
a[4].append('c') #修改对象a中的['a', 'b']数组对象

print 'a = ', a
print 'b = ', b
print 'c = ', c
print 'd = ', d
输出结果：
a =  [1, 2, 3, 4, ['a', 'b', 'c'], 5]
b =  [1, 2, 3, 4, ['a', 'b', 'c'], 5]
c =  [1, 2, 3, 4, ['a', 'b', 'c']]
d =  [1, 2, 3, 4, ['a', 'b']]
```
