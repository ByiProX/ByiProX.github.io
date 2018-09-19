---
title: Java类属性和方法的可见性
date: 2018-09-06 10:33:20
tags:
  - Java
categories:
  - Java
---




| 作用域       | 当前类      |同一package |子孙类     |其他package |
| ------------| -----------|---------- |----------|----------|
| public      | Y          |Y          |Y         |Y           |
| protected   | Y          |        Y  | Y         |  N         |
| friendly(default)    | Y          | Y         | N         | N          |
| private     | Y         |N         | N         |   N         |


不写时默认为`friendly`
