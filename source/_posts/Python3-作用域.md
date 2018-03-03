---
title: Python3 作用域
date: 2018-03-03 11:48:30
tags:
  - Python3
categories:
  - Python3 进阶
  - Python3 作用域
---
Python 中，一个变量的作用域总是由在代码中被赋值的地方所决定的。

Python 获取变量中的值的搜索顺序为：

本地作用域（Local）→ 当前作用域被嵌入的本地作用域（Enclosing locals）→ 全局/模块作用域（Global）→内置作用域（Built-in）
