---
title: Linux数据流重定向
date: 2018-09-05 11:58:25
tags:
  - Linux/Mac OS
categories:
  - Linux/Mac OS
---

`标准输出(standard output)`指的是命令执行所回传的正确的信息，而`标准错误输出(standard error output)`可以理解为命令执行失败后，所回传的错误信息。
一般情况下，不管正确还是错误信息数据默认的是输出到屏幕上，所以屏幕上是很混乱的。可以通过数据流重定向将stdout和stderr分别传送到其他的文件或者设备去，而分别传送所用的特殊字符如下所示：

<!-- more -->

1. 标准输入（stdin）：代码为`0`，使用`<`或者`<<`
2. 标准输出（stdout）：代码为`1`，使用`>`或者`>>`
3. 标准错误输出（stderr）：代码为`2`，使用`>`或者`>>`

#### 标准输出和标准错误输出
如果仅存在`>`，则代表默认代码为1。

- `1>`:以`覆盖`的方法将`正确`的数据输出到指定的文件或者设备上
- `1>>`:以`累加`的方法将`正确`的数据输出到指定的文件或者设备上
- `2>`:以`覆盖`的方法将`错误`的数据输出到指定的文件或者设备上
- `2>>`:以`累加`的方法将`错误`的数据输出到指定的文件或者设备上


示例1：将stdout和stderr分别存到不同的文件中去。
```bash
find /home -name .bashrc > list_right 2> list_error
```

示例2：将错误的数据丢弃，屏幕上显示正确的数据
```bash
find /home -name .bashrc 2> /dev/null
```
/dev/null垃圾黑洞设备

示例3：将正确和错误的数据全部写入一个文件
```bash
find /home -name .bashrc >list 2>&1

或者

find /home -name .bashrc &> list

```

#### 标准输入

`<`意味着将原本需要由键盘输入的数据改由文件内容来替代。

示例1：利用`cat`命令来创建一个文件的简单流程，了解一下什么是`键盘输入`
```bash
cat > catfile
1
2
3
<==此处按下ctrl+c或者ctrl+d来离开
```
示例2：利用`stdin`替代键盘的输入来创建新文件的流程
```bash
cat > catfile < ~/.bashrc
--------------------------
ll catfile ~/.bashrc
-rw-r--r--  1 root root 176 Sep  5 14:10 catfile
-rw-r--r--. 1 root root 176 Dec 29  2013 /root/.bashrc
# 注意到两个文件大小几一模一样，几乎是使用cp命令复制一份
```
理解了`<`后，再来看`<<`。`<<`：`代表的是结束输入的意思`。举例来讲，我要用cat直接将输入的信息输出到catfile中，且当由键盘输入eof时，本次输入就结束，可以按照如下方式进行：
```bash
cat > catfile << "eof"
>1
>2
>3
>eof  <==输入该关键字后，立刻就结束输入而不需要输入ctrl + d/c
```









---------
