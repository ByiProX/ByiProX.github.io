---
title: Java方法的值传递机制
date: 2018-10-26 10:48:38
tags:
  - Java
categories:
  - Java
---

- 对于基本数据类型(八种基本数据类型)来说，方法形参传递的是`值的副本`;
- 对于引用数据类型，方法的形参传递的是`引用的地址值的副本`;

对于引用数据类型，JVM中的存储图如下：

![IMG_0013.PNG](https://upload-images.jianshu.io/upload_images/2952111-24d050aa031dd985.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
