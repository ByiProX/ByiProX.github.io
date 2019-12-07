---
title: 简述Python中变量作用域的规则
date: 2019-12-07 23:22:52
tags:
  - Python3
categories:
  - Python3 进阶
  - Python3 闭包
---
介绍这一题目的目的是引出python中较为高级的话题---闭包和装饰器。

在下面的例子中，定义并测试一个函数，它读取两个变量的值:一个是局部变量a，是函数的参数； 另一个是变量b，这个函数没有定义它。

```python
>>> def f1(a):
...     print(a)
...     print(b)
...
>>> f1(1)
1
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 3, in f1
NameError: name 'b' is not defined
```
出现此结果完全在意料范围内，因为我们压根从来没有定义过变量b。如果我们在调用函数f1前定义变量b，那么不会存在问题，因为此处的b是`全局变量`。

```python
>>> b=2
>>> f1(1)
1
2
```
下面来一个较为特殊的例子
```python
>>> b=2
>>> def f2(a):
...     print(a)
...     print(b)
...     b=3
...
>>> f2(1)
1
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 3, in f2
UnboundLocalError: local variable 'b' referenced before assignment
```

可以看到在赋值之前，第二个print失败了，`提示局部变量b在赋值前被引用了`。

实际上，Python 编译函数的定义体时，它判断 b 是局部变量，因为在函数中给它赋值了。生成的字节码证实了这种判断（后面会讨论），Python 会尝试从本地环境获取 b。后面调用f2(1)时，f2的定义体会获取并打印局部变量 a 的值，但是尝试获取局部变量 b 的值时，发现 b 没有绑定值。

这是Python的设计选择：Python不要求声明变量类型，但是默认在函数定义体中赋值的变量是局部变量。如果在函数中赋值时想让解释器把 b 当成全局变量，要使用 `global` 声明：
```python
>>> b=2
>>> def f3(a):
...     global b
...     print(a)
...     print(b)
...     b=3
...
>>> f3(1)
1
2
>>> b
3
>>> f3(1)
1
3
>>> b=30
>>> b
30
>>> f3(1)
1
30
```

接下来，我们看一下f1和f2的字节码：
![Screen Shot 2019-12-07 at 17.10.03.png](https://upload-images.jianshu.io/upload_images/2952111-8e292da51753cfef.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

对于f1函数的反汇编：
1.  LOAD_GLOBAL加载全局名称 print。
2.  LOAD_FAST加载本地名称 a。
3.  LOAD_GLOBAL加载全局名称 b。

对于f2函数的反汇编：
4.  LOAD_FAST加载本地名称 b。这表明，编译器把 b 视作`局部变量`，即使在后面才为 b 赋值。

对于函数f3的反汇编如下图所示，可以看到变量b为全局变量。
![Screen Shot 2019-12-07 at 17.30.33.png](https://upload-images.jianshu.io/upload_images/2952111-9f820de0acd3270c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


至此，我们可以基本了解python函数中变量作用域的问题，这将为后面介绍的闭包和装饰器的学习打下基础。

---------
