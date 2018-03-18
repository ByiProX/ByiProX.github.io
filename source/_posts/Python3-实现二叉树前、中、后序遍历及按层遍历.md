---
title: Python3 实现二叉树前、中、后序遍历及按层遍历
date: 2018-03-15 23:57:26
tags:
  - Python3
  - Algorithm
  - Data Structures
categories:
  - Data Structures
---

```python
class Node(object):
    def __init__(self, value=None, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right

if __name__ == "__main__":
    tree = Node(1, Node(2, Node(4), Node(5, Node(8), Node(9, left=Node(11)))), Node(3, Node(6), Node(7, left=Node(10))))
```
