---
title: Python3 让字典保持有序
date: 2018-03-06 12:02:36
tags:
  - Python3
categories:
  - Python3 进阶
  - Python3 字典
---

## 背景
想创建一个字典，同时当对字典做迭代或序列化操作时，也能控制其中元素的顺序。

## 解决方案

要控制字典中元素的顺序，可以使用`collections模块`中的`OrderDict类`。当对字典做迭代时，他会严格按照元素初始添加的顺序执行。例如：
```Python
from collections import OrderedDict

d = OrderedDict()
d['foo'] = 1
d['bar'] = 2
d['spam'] = 3
d['qrok'] = 4

for key in d:
    print(key, d[key])

# output:
# foo 1
# bar 2
# spam 3
# qrok 4
```
<!-- more -->
当想创建一个映射结构以便稍后对其做序列化或编码成另一种格式时，OrderedDict就显得特别有用。例如，如果想在进行json编码时精确控制各个字段的顺序，那么只要首先在OrderedDict中构建数据就可以了。

```Python
>>> import json
>>> json.dumps(d)
'{"foo":1,"bar":2,"spam":3,"qrok":4}'
>>>
```

## 讨论

OrderedDict内部维护了一个双向链表，他会根据元素加入的顺序来排列键的位置。第一个加入的元素被放置的链表的末尾。接下来对已存在的键做重新赋值不会改变键的顺序。

注意OrderedDict的大小是普通字典的两倍多，这是由于它额外创建的链表所致。因此，如果打算构建一个涉及大量OrderedDict实例的数据结构（例如从CSV文件中读取100000行内容到OrderedDict列表中），那么需要认真对应用做需求分析，从而判断使用OrderedDict所带来的好处是否能够超越额外的内存开销带来的缺点。








a
