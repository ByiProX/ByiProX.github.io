---
title: Linux切割命令split
date: 2018-09-05 18:06:09
tags:
  - Linux/Mac OS
categories:
  - Linux/Mac OS
---

如果文件太大，导致一些携带设备无法复制问题。利用`split`就可以了。它可以帮助我们将一个大文件依据文件大小或者行数来切割成小文件，快速而有效。

<!-- more -->
具体使用方法可以通过`man split`查看。

范例1：一部复仇者联盟的电影，大小为1.7G,现将他们分割为每一份512M。
```Bash
split -b 512m Avengers.mp4 AvengerSplit

ll
-rw-r--r--  1 Dhyana  staff   512M Sep  5 18:19 AvengerSplitaa
-rw-r--r--  1 Dhyana  staff   512M Sep  5 18:19 AvengerSplitab
-rw-r--r--  1 Dhyana  staff   512M Sep  5 18:19 AvengerSplitac
-rw-r--r--  1 Dhyana  staff   171M Sep  5 18:19 AvengerSplitad
```

如果需要将文件合并，使用命令
```Bash
cat AvengerSplit* >> AvengerBack.mp4
```
即可。

范例2：使用`ls -al /`输出的信息中，每10行记录成一个文件
```Bash
ls -al / | split -l 10 - lsroot

wc -l lsroot*
10 lsrootaa
10 lsrootab
 7 lsrootac
27 total

```
重点在那个`-`。一般来讲，如果需要stdin/stdout,但是没有相应的文件，此时`-`就代表了stdin/stdout。
