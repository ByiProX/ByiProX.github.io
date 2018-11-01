---
title: Redis之哈希数据类型的内部编码
date: 2018-11-01 11:25:48
tags:
  - Redis
categories:
  - Redis
  - Redis哈希数据类型
---

哈希类型内部编码有两种形式：

1. `ziplist`(压缩列表，感觉与python中的zip方法类似，有待验证)：当哈希类型元素个数小于`hash-max-ziplist-entries`配置(默认512)、同时所有值都小于`hash-max-ziplist-value`配置(默认64字节)，Redis会使用ziplist作为哈希的内部实现。ziplist使用更加紧凑结构实现多个元素的连续存储，所以在节省内存方面比hashtable更有优势。

2. `hashtable`(哈希表)：当哈希类型无法满足ziplist条件时，Redis会使用hashtable作为哈希的内部实现，因此此时ziplist读写效率会下降，hashtable读写的时间复杂度为O(1).
