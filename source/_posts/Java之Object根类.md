---
title: Java之Object根类
date: 2018-10-29 11:48:41
tags:
  - Java
categories:
  - Java
---

Object本身就是指对象的意思。开发时发现对象具有一些共通的行为，因此抽象出一个类：Object，来表示对象类，其他都会继承于Object类，也就是Object中的方法。

`引用数据类型：类/接口/数组`，`引用类型又称为对象类`，`所谓的数组变量名称应该指代数组对象`。
Object类常用方法：

1. `protected void finalize()`:当垃圾回收器确定不存在对该对象的更多引用时，由对象回收期调用此方法。垃圾回收器在回收某一个对象之前会调用该方法，做扫尾操作。

2. `Class getClass`:返回当前对象的真实类型。

3. `int hashCode()`:返回该对象的哈希值，hashCode决定了对象在哈希表中的存储位置，不同对象的hashCode是不一样的。

4. `boolean equals(Object obj)`: 拿当前对象(this)和参数obj比较。在Object类中的equals方法，本身和'=='符号相同，都是比较的内存地址。官方建议：每个类都应该赋写equals方法，不要比较内存地址，而是比较我们关心的数据。

5. `String toString()`:表示把一个对象转换为字符串表示。在调用打印时，其实打印的就是对象的toString方法。`System.out.println(obj);`等价于`System.out.println(obj.toString);`(决堤可以查看Java源代码)。默认情况下打印对象，打印的是对象的十六进制hashCode,但我们更关心对象中的真实存储数据。官方建议：每个类最好赋写toString方法，返回我们关心的数据。


![Screen Shot 2018-10-29 at 12.08.42.png](https://upload-images.jianshu.io/upload_images/2952111-d5a996ebf97c420b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
