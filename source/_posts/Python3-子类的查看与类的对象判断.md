---
title: Python3 子类的查看与类的对象判断
date: 2018-03-03 02:24:21
tags:
  - Python3
categories:
  - Python3 进阶
---
1. 如果想要查看一个类是不是另一个类的子类，可以使用內建的 `issubclass` 函数或者使用它的特殊特性`__base__`；

2. 如果想要检查一个对象是不是一个类的实例，可以使用內建的 `isinstance` 函数或者使用它的特殊特性`__class__`;

```python
# -*- coding: utf-8 -*-  
__metaclass__ = type #确定使新式类  


class father():  
    def init(self):  
        print("father()已经创建")  

class son(father):  
    def init(self):  
        print("son()已经创建")  

#下面测试issubclass()函数  
print(issubclass(father,son))  # output: False
print(issubclass(son,father))  # output: True

#下面使用__bases__  
print("father.__bases__:",father.__bases__)  # output: father.__bases__: (<class 'object'>,)  
print("son.__bases__:",son.__bases__)        # output: son.__bases__: (<class '__main__.father'>,)  

#下面测试isinstance()函数  
s = son()  
print(isinstance(s,son))    # output: True
print(isinstance(s,father)) # output: True
print(isinstance(s,str))    # output: False

#下面使用__class__  
print("s.__class__:",s.__class__) # output: s.__class__: <class '__main__.son'>  
```
