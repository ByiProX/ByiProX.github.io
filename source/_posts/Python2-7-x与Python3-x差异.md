---
title: Python2.7.x与Python3.x差异
date: 2018-03-06 01:08:15
tags:
  - Python3
categories:
  - Python3 进阶
---
**Contents**

1. [`__future__模块`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#__future__%E6%A8%A1%E5%9D%97)
2. [`print函数`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#print%E5%87%BD%E6%95%B0)
3. [`整除`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#%E6%95%B4%E9%99%A4)
4. [`Unicode`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#Unicode)
5. [`xrange模块`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#xrange%E6%A8%A1%E5%9D%97)
6. [`Python3中的range对象的__contains__方法`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#Python3%E4%B8%AD%E7%9A%84range%E5%AF%B9%E8%B1%A1%E7%9A%84__contains__%E6%96%B9%E6%B3%95)
7. [`Raising exceptions`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#Raising_exceptions)
8. [`Handling exceptions`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#Handling_exceptions)
9. [`next()函数 and .next()方法`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#next()
10. [`For循环变量和全局命名空间泄漏`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#For%E5%BE%AA%E7%8E%AF%E5%8F%98%E9%87%8F%E5%92%8C%E5%85%A8%E5%B1%80%E5%91%BD%E5%90%8D%E7%A9%BA%E9%97%B4%E6%B3%84%E6%BC%8F)
11. [`比较不可排序类型`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#%E6%AF%94%E8%BE%83%E4%B8%8D%E5%8F%AF%E6%8E%92%E5%BA%8F%E7%B1%BB%E5%9E%8B)
12. [`通过input()解析用户的输入`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#%E9%80%9A%E8%BF%87input()
13. [`返回可迭代对象，而不是列表`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#%E8%BF%94%E5%9B%9E%E5%8F%AF%E8%BF%AD%E4%BB%A3%E5%AF%B9%E8%B1%A1%EF%BC%8C%E8%80%8C%E4%B8%8D%E6%98%AF%E5%88%97%E8%A1%A8)
14. [`更多的关于 Python 2 和 Python 3 的文章`](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/#%E6%9B%B4%E5%A4%9A%E7%9A%84%E5%85%B3%E4%BA%8E_Python_2_%E5%92%8C_Python_3_%E7%9A%84%E6%96%87%E7%AB%A0)

 **参考：**
 1. [Python2.x与Python3.x差异](http://chenqx.github.io/2014/11/10/Key-differences-between-Python-2-7-x-and-Python-3-x/)

 2. [Key differences between Python 2.7.x and Python 3.x](http://nbviewer.jupyter.org/github/rasbt/python_reference/blob/master/tutorials/key_differences_between_python_2_and_3.ipynb?create=1)
