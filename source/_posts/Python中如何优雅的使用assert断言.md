---
title: Python中如何优雅的使用assert断言
date: 2019-11-14 17:04:42
tags:
  - Python3
categories:
  - Python3 进阶
---

### 什么是assert断言

> Assert statements are a convenient way to insert debugging assertions into a program

断言声明是用于程序调试的一个便捷方式。断言可以看做是一个debug工具，Python的实现也符合这个设计哲学，在Python中assert语句的执行是依赖于`__debug__`这个内置变量的，其默认值为`True`。当`__debug__`为`True`时，assert语句才会被执行。

对于一般的声明，assert expression等价于
```Python
if __debug__:
    if not expression: raise AssertionError
```
assert可以同时声明两个个expression，例如**assert expression1, expression2**等价于
```Python
if __debug__:
    if not expression1: raise AssertionError(expression2)
```
如果执行脚本文件时加上`-O`参数， `__debug__`则为`False`

举一个例子，假设我们有一个脚本testAssert.py，内容为：
```Python
print(__debug__)
assert 1 > 2
```
<!-- more -->

当使用`python assert.py`运行时，`__debug__`会输出True，assert 1 > 2语句会抛出AssertionError异常。

当使用`python -O assert.py`运行时，`__debug__`会输出False，assert 1 > 2语句由于没有执行不会报任何异常。


### 断言和异常的使用场景

先说结论：

> 检查`先验条件`使用断言，检查`后验条件`使用异常

举个例子来说明一下，在开发中我们经常会遇到读取本地文件的场景。我们定义一个read_file方法。

```python
def read_file(path):
    assert is_instance(file_path, str)
    ...
```
read_file函数要求在开始执行的时候满足一定条件：file_path必须是str类型，这个条件就是先验条件，如果不满足，就不能调用这个函数，如果真的出现了不满足条件的情况，证明代码中出现了bug，这时候我们就可以使用assert语句来对file_path的类型进行推断，提醒程序员修改代码，也可以使用if...raise...语句来实现assert，但是要繁琐很多。在很多优秀的Python项目中都会看到使用assert进行先验判断的情况，平时可以多多留意。

read_file函数在被调用执行后，依然需要满足一定条件，比如file_path所指定的文件需要是存在的，并且当前用户有权限读取该文件，这些条件称为后验条件，对于后验条件的检查，我们需要使用异常来处理。

```python
def read_file(file_path):
    assert is_instance(file_path, str)
    if not check_exist(file_path):
        raise FileNotFoundError()
    if not has_privilege(file_path):
        raise PermissionError()
```

文件不存在和没有权限，这两种情况并不属于代码bug，是代码逻辑的一部分，上层代码捕获异常后可能会执行其他逻辑，因此我们不能接受这部分代码在生产环境中被忽略。并且，相比于assert语句只能抛出AssertionError，使用异常可以抛出更详细的错误，方便上层代码针对不同错误执行不同的逻辑。

---
[参考链接](https://juejin.im/post/5af02413f265da0b776f9e15)
