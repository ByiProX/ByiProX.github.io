---
title: Python3 回文字符串的判断
date: 2018-03-19 18:25:12
tags:
  - Python3
  - Algorithm
categories:
  - Algorithm
---
```python
def isPalindrome(str_):
    if len(str_) < 2:
        return True
    if str_[0] != str_[-1]:
        return False

    return isPalindrome(str_[1:-1])
```
