---
title: Redis之数据类型的内部编码
date: 2018-11-01 11:25:48
tags:
  - Redis
categories:
  - Redis
  - 数据类型
---
#### 哈希
哈希类型内部编码有两种形式：

1. `ziplist`(压缩列表，感觉与python中的zip方法类似，有待验证。。。)：当哈希类型元素个数小于`hash-max-ziplist-entries`配置(默认512)、同时所有值都小于`hash-max-ziplist-value`配置(默认64字节)，Redis会使用ziplist作为哈希的内部实现。ziplist使用更加紧凑结构实现多个元素的连续存储，所以在节省内存方面比hashtable更有优势。

2. `hashtable`(哈希表)：当哈希类型无法满足ziplist条件时，Redis会使用hashtable作为哈希的内部实现，因此此时ziplist读写效率会下降，hashtable读写的时间复杂度为O(1).


<!-- more -->
#### 列表
从Redis3.2之后开始提供了`quicklist内部编码，它是一种将ziplist和linkedlist结合的一种编码方式`。

1. `ziplist`(压缩列表):当列表的元素个数小于`list-max-ziplist-entries`配置(默认512个),同时列表中每个元素值都小于`list-max-ziplist-value`配置(默认64字节),Redis会选用ziplist来作为列表内部的实现来减小内存使用。
2. `linkedlist`(链表):当列表类型无法满足ziplist的条件时，Redis会使用linkedlist作为列表的内部实现。

Redis3.2之后提供了quicklist内部编码，简单的说它是一个ziplist为节点的linkedlist，它结合了两者的优势，为列表类型提供了一种更为优秀的内部编码实现。
