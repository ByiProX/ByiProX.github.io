---
title: Python3 函数重载
date: 2018-03-03 10:54:44
tags:
  - Python3
categories:
  - Python3 进阶
  - Python3 重载
---
## 函数重载的目的

在静态语言中，方法重载是希望类可以以统一的方式处理不同类型的数据提供了可能。多个同名函数同时存在，具有不同的参数个数/类型，重载是一个类中多态性的一种表现。

在Java中实现函数重载：
```Java
class Writer{
    public static void write(StringIO output, String content){
        output.write(content);
        return null;
    }

    public static void write(File output, String content){
        output.write(content);
        return null;
    }

```

而在动态语言中，有鸭子类型，如果走起路来像鸭子，叫起来也像鸭子，那么它就是鸭子。一个对象的特征不是由它的类型决定，而是通过对象中的方法决定，所以函数重载在动态语言中就显得没有意义了，因为函数可以通过鸭子类型来处理不同类型的对象，鸭子类型也是多态性的一种表现。

在Python中实现函数重载：
```Python
from io import StringIO

class Writer:
    @staticmethod
    def write(output, content):
        # output对象只要实现了write方法就行
        output.write(content)

# stringIO类型
output = StringIO()
Writer.write(output, "hello world")

# file 类型
output = open("out.txt", "w")
Writer.write(output, "hello world")

```

参考自知乎用户`刘志军`：https://www.zhihu.com/question/20053359

---

## 函数重载主要是为了解决两个问题

1. 可变参数类型。
2. 可变参数个数。

>另外，一个基本的设计原则是，仅仅当两个函数除了参数类型和参数个数不同以外，其功能是完全相同的，此时才使用函数重载，如果两个函数的功能其实不同，那么不应当使用重载，而应当使用一个名字不同的函数。

好吧，那么对于情况 1 ，函数功能相同，但是参数类型不同，python 如何处理？答案是根本不需要处理，因为 python 可以接受任何类型的参数，如果函数的功能相同，那么不同的参数类型在 python 中很可能是相同的代码，没有必要做成两个不同函数。

那么对于情况 2 ，函数功能相同，但参数个数不同，python 如何处理？大家知道，答案就是`缺省参数`。对那些缺少的参数设定为缺省参数即可解决问题。因为你假设函数功能相同，那么那些缺少的参数终归是需要用的。好了，鉴于情况 1 跟 情况 2 都有了解决方案，python 自然就不需要函数重载了。

参考自知乎用户`pansz`：https://www.zhihu.com/question/20053359
