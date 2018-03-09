---
title: Python3 实现二分查找
date: 2018-03-09 14:32:16
tags:
  - Python3
  - Algorithm
categories:
  - Algorithm
---

二分查找,给出一个已经排好序的列表,`注意是已经排好序的`,查找指定元素在列表中的位置
```Python
import math

def binary_search(my_list, item):
    """从list中查找item"""
    low = 0
    high = len(my_list) - 1

    while low <= high:
        mid = math.floor((low + high)/2)
        guess = my_list[mid]
        if guess > item:
            high = mid - 1
        elif guess < item:
            low = mid + 1
        else:
            return mid
    return None

my_list = [1,3,5,7,9]
item = 1
print(binary_search(my_list, item))

```
