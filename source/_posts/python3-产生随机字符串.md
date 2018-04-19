---
title: python3 产生随机字符串
date: 2018-04-19 16:26:53
tags:
  - Python3
categories:
  - Python3 进阶
---

```python
import random
import string


# 长度为16的随机字符串
rand_str = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(16))

```
