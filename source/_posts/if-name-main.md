---
title: 'if __name__ == ''__main__'': ?'
date: 2018-03-01 19:50:06
tags:
  - Python3
categories:
  - Python3 进阶
---
>Every Python module has it's `__name__` defined and if this is `'__main__'`, it implies that the module is being run standalone by the user and we can do corresponding appropriate actions.

当Python解析器读取一个源文件时,它会执行所有的代码.在执行代码前,会定义一些特殊的变量.例如,如果解析器运行的模块(源文件)作为主程序,它将会把`__name__`变量设置成`"__main__"`.如果只是引入其他的模块,`__name__`变量将会设置成模块的名字.
<!-- more -->

这么做的原因是有时你想让你的模块既可以直接的执行,还可以被当做模块导入到其他模块中去.通过检查是不是主函数,可以让你的代码只在它作为主程序运行时执行,而当其他人调用你的模块中的函数的时候不必执行.

直接上一个栗子：
```python
# Filename: using_name.py

print(__name__)
if __name__ == '__main__':
	print('This program is being run by itself')
else:
	print('I am being imported from another module')

```

```Python

$ python using_name.py
__main__
This program is being run by itself

$ python
>>> import using_name
using_name
I am being imported from another module
>>>

```
