---
title: Java中的+=赋值运算
date: 2018-10-24 15:22:03
tags:
  - Java
categories:
  - Java
---

```Java

int a = 10;
a += 5;
System.out.println(a); //15

short s = 30;
s = s + 5;//编译报错
//Error:(23, 15) java: incompatible types: possible lossy conversion from int to short

short s = 30;
s += 5;//等价于 s = short(s+5),该表达式自带隐式类型转换
```

上述代码中，变量s为short类型，`s+5`的结果为int类型，int类型赋值给short类型，编译报错。
错误信息为如下：
`Error:(23, 15) java: incompatible types: possible lossy conversion from int to short`

关于`自动类型转换`，也称为`隐式类型转换`
当把`小数据范围类型的数值或变量`赋值给另一个`大数据范围类型变量`时，系统可以自动完成类型转换。
boolean类型是不可以转换为其他数据类型。

`强制类型转换`，也称为`显示类型转换`
当把`大范围类型的数值或变量`赋值给另一个`小范围类型变量`时，此时系统不能自动完成转换，需要加上强制转换符，但这样的操作可能在成数据精度的降低或溢出，使用时需要格外注意。
