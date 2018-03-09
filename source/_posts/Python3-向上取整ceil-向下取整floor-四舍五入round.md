---
title: Python3 向上取整ceil|向下取整floor|四舍五入round
date: 2018-03-09 14:21:35
tags:
  - Python3
categories:
  - Python3 进阶
---
```python
import math

#向上取整
print("math.ceil---向上取整")  
print("math.ceil(2.3) => ", math.ceil(2.3))  # 3
print("math.ceil(2.6) => ", math.ceil(2.6))  # 3

#向下取整
print("\nmath.floor---向下取整")
print("math.floor(2.3) => ", math.floor(2.3)) # 2
print("math.floor(2.6) => ", math.floor(2.6)) # 2

#四舍五入
print("\nround---四舍五入")
print("round(2.3) => ", round(2.3)) # 2
print("round(2.6) => ", round(2.6)) # 3

```
<!-- more -->
```Bash
math.ceil---向上取整
math.ceil(2.3) =>  3
math.ceil(2.6) =>  3

math.floor---向下取整
math.floor(2.3) =>  2
math.floor(2.6) =>  2

round---四舍五入
round(2.3) =>  2
round(2.6) =>  3

```
