---
title: Python中如何生成一定格式的日期字符串
date: 2018-12-03 16:20:56
tags:
  - Python3
categories:
  - Python3 进阶
---

```Python
import time

timeStamp = time.time()
timeArray = time.localtime(time.time())
print(timeArray)
# time.struct_time(tm_year=2018, tm_mon=12, tm_mday=3, tm_hour=16, tm_min=23, tm_sec=55, tm_wday=0, tm_yday=337, tm_isdst=0)

formatTime = time.strftime("%Y%m%d-%H:%M:%S", timeArray)
print(formatTime)
# 20181203-16:23:55

```
