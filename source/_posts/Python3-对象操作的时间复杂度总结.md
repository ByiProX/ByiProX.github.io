---
title: Python3 对象操作的时间复杂度总结
date: 2018-03-29 19:27:04
tags:
  - Python3
  - Algorithm
categories:
  - Python3 进阶
---
## 列表 list
列表是以数组（Array）实现的。最大的开销发生在超过当前分配大小的增长，这种情况下所有元素都需要移动；或者是在起始位置附近插入或者删除元素，这种情况下所有在该位置后面的元素都需要移动，这种情况可以考虑使用双向队列来解决。

| Operation                                                    | Average Case | [Amortized Worst Case](http://en.wikipedia.org/wiki/Amortized_analysis) |
| ------------------------------------------------------------ | ------------ | ------------------------------------------------------------ |
| Copy                                                         | O(n)         | O(n)                                                         |
| Append[1]                                                    | O(1)         | O(1)                                                         |
| Pop last                                                     | O(1)         | O(1)                                                         |
| Pop intermediate                                             | O(k)         | O(k)                                                         |
| Insert                                                       | O(n)         | O(n)                                                         |
| Get Item                                                     | O(1)         | O(1)                                                         |
| Set Item                                                     | O(1)         | O(1)                                                         |
| Delete Item                                                  | O(n)         | O(n)                                                         |
| Iteration                                                    | O(n)         | O(n)                                                         |
| Get Slice                                                    | O(k)         | O(k)                                                         |
| Del Slice                                                    | O(n)         | O(n)                                                         |
| Set Slice                                                    | O(k+n)       | O(k+n)                                                       |
| Extend[1]                                                    | O(k)         | O(k)                                                         |
| [Sort](http://svn.python.org/projects/python/trunk/Objects/listsort.txt) | O(n log n)   | O(n log n)                                                   |
| Multiply                                                     | O(nk)        | O(nk)                                                        |
| x in s                                                       | O(n)         |                                                              |
| min(s), max(s)                                               | O(n)         |                                                              |
| Get Length                                                   | O(1)         | O(1)                                                         |

<!-- more -->
## 双向队列 collections.deque

deque是以双向链表的形式实现的。双向队列的两端都是可达的，但从查找队列中间的元素较为缓慢，增删元素就更慢了。

|  **操作**  | **平均情况** | **最坏情况** |
| :--------: | :----------: | :----------: |
|    复制    |     O(n)     |     O(n)     |
|   append   |     O(1)     |     O(1)     |
| appendleft |     O(1)     |     O(1)     |
|    pop     |     O(1)     |     O(1)     |
|  popleft   |     O(1)     |     O(1)     |
|   extend   |     O(k)     |     O(k)     |
| extendleft |     O(k)     |     O(k)     |
|   rotate   |     O(k)     |     O(k)     |
|   remove   |     O(n)     |     O(n)     |


## 集合 set
| **Operation**                     | **Average case**                                             | **Worst Case**                                | **notes**                                  |
| --------------------------------- | ------------------------------------------------------------ | --------------------------------------------- | ------------------------------------------ |
| x in s                            | O(1)                                                         | O(n)                                          |                                            |
| Union s\|t                        | [O(len(s)+len(t))](https://wiki.python.org/moin/TimeComplexity_%28SetCode%29) |                                               |                                            |
| Intersection s&t                  | O(min(len(s), len(t))                                        | O(len(s) * len(t))                            | replace "min" with "max" if t is not a set |
| Multiple intersection s1&s2&..&sn |                                                              | (n-1)*O(l) where l is max(len(s1),..,len(sn)) |                                            |
| Difference s-t                    | O(len(s))                                                    |                                               |                                            |
| s.difference_update(t)            | O(len(t))                                                    |                                               |                                            |
| Symmetric Difference s^t          | O(len(s))                                                    | O(len(s) * len(t))                            |                                            |
| s.symmetric_difference_update(t)  | O(len(t))                                                    | O(len(t) * len(s))                            |                                            ||

## 字典 dict
字典的平均情况基于以下假设：
1. 对象的散列函数足够撸棒（robust），不会发生冲突。
2. 字典的键是从所有可能的键的集合中随机选择的。

| **Operation** | **Average Case** | **Amortized Worst Case** |
| ------------- | ---------------- | ------------------------ |
| Copy[2]       | O(n)             | O(n)                     |
| Get Item      | O(1)             | O(n)                     |
| Set Item[1]   | O(1)             | O(n)                     |
| Delete Item   | O(1)             | O(n)                     |
| Iteration[2]  | O(n)             | O(n)                     |


## 参考
1. https://wiki.python.org/moin/TimeComplexity
