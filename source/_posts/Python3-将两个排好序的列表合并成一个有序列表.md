---
title: Python3 将两个排好序的列表合并成一个有序列表
date: 2018-03-12 00:11:27
tags:
  - Python3
  - Algorithm
categories:
  - Algorithm
---
```Python
def merge_list(a, b):
    if not a:
        return b
    if not b:
        return a
    a_index = b_index = 0
    ret = []
    while a_index < len(a) and b_index < len(b):
        if a[a_index] <= b[b_index]:
            ret.append(a[a_index])
            a_index += 1
        else:
            ret.append(b[b_index])
            b_index += 1
    if a_index < len(a):
        ret.extend(a[a_index:])
    if b_index < len(b):
        ret.extend(b[b_index:])
    return ret


if __name__ == '__main__':
    a = [1, 2, 3, 5, 7, 9]
    b = [1, 2, 2, 4, 5, 6, 8, 10]
    print(merge_list(a, b))

```
