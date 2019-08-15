---
title: 服务器中的物理CPU、逻辑CPU和CPU核数
date: 2019-06-20 22:18:07
tags:
  - 操作系统
categories:
  - 操作系统
---

## 重要概念
### 物理CPU               
实际Server中插槽上的CPU个数
物理cpu数量，可以数不重复的 physical id 有几个,查看方法

```bash
grep "physical id" /proc/cpuinfo|sort|uniq|wc -l
2
```         

### CPU核数           
单块CPU上面能处理数据的芯片组的数量，如双核、四核等 （cpu cores）。
比如现在的i5 760,是双核心四线程的CPU、而 i5 2250 是四核心四线程的CPU 。一般来说，物理CPU个数×每颗核数就应该等于逻辑CPU的个数，如果不相等的话，则表示服务器的CPU支持超线程技术    

```bash
cat /proc/cpuinfo |grep "cpu cores"|uniq
grep "cpu cores" /proc/cpuinfo|uniq|awk -F ":" "{print $2}"
8
```

### 逻辑CPU               
Linux用户对 /proc/cpuinfo 这个文件肯定不陌生. 它是用来存储cpu硬件信息的
信息内容分别列出了processor 0 – n 的规格。这里需要注意，如果你认为n就是真实的cpu数的话, 就大错特错了。

一般情况，我们认为`一颗cpu可以有多核`，加上`intel的超线程技术(HT)`, 可以在逻辑上再分一倍数量的cpu core出来
`逻辑CPU数量=物理cpu数量 x cpu cores 这个规格值 x 2(如果支持并开启ht)`。

`如果有一个以上逻辑处理器拥有相同的 core id 和 physical id，则说明系统支持超线程（HT）技术`

备注一下：Linux下top查看的CPU也是逻辑CPU个数

```bash
cat /proc/cpuinfo| grep "processor" |wc -l
32（支持超线程）
```
<!-- more -->

## 查看方法
通过cat /proc/cpuinfocpu来查看相关信息。
> - vendor id     如果处理器为英特尔处理器，则字符串是 GenuineIntel。
>- processor     包括这一逻辑处理器的唯一标识符。
>- physical id   包括每个物理封装的唯一标识符。
>- core id       保存每个内核的唯一标识符。
>- siblings      列出了位于相同物理封装中的逻辑处理器的数量。
>- cpu cores     包含位于相同物理封装中的内核数量。

1. 拥有相同 physical id 的所有逻辑处理器共享同一个物理插座，每个 physical id 代表一个唯一的物理封装。
2. Siblings 表示位于这一物理封装上的逻辑处理器的数量，它们可能支持也可能不支持超线程（HT）技术。
3. 每个 core id 均代表一个唯一的处理器内核，所有带有相同 core id 的逻辑处理器均位于同一个处理器内核上。简单的说：“siblings”指的是一个物理CPU有几个逻辑CPU，”cpu cores“指的是一个物理CPU有几个核。
4. 如果有一个以上逻辑处理器拥有相同的 core id 和 physical id，则说明系统支持超线程（HT）技术。
5. 如果有两个或两个以上的逻辑处理器拥有相同的 physical id，但是 core id不同，则说明这是一个多内核处理器。cpu cores条目也可以表示是否支持多内核。


## top命令关于cpu使用率

下面做一个简单的测试，终端中使用如下命令
```bash
md5sum /dev/zero &
```
开启top，如下所示

![Screen Shot 2019-06-20 at 22.53.34.png](https://upload-images.jianshu.io/upload_images/2952111-81c2a7654f73c645.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

按数字键1后查看所有核的使用率。

![Screen Shot 2019-06-20 at 22.56.42.png](https://upload-images.jianshu.io/upload_images/2952111-70b5f8c2b58f77cd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

发现使用top命令，左上角显示的是整体负载，即单核的负载数除以核数。%CPU数值代表单个核的使用率，超过100%代表使用其他核的计算资源。


第一行：
- 10:01:23 — 当前系统时间
- 126 days, 14:29 — 系统已经运行了126天14小时29分钟（在这期间没有重启过）
- 2 users — 当前有2个用户登录系统
- load average: 1.15, 1.42, 1.44 — load average后面的三个数分别是1分钟、5分钟、15分钟的负载情况。load average数据是每隔5秒钟检查一次活跃的进程数，然后按特定算法计算出的数值。如果这个数`除以逻辑CPU的数量`，`结果高于5的时候就表明系统在超负荷运转了。`

第二行：
- Tasks — 任务（进程），系统现在共有183个进程，其中处于运行中的有1个，182个在休眠（sleep），stoped状态的有0个，zombie状态（僵尸）的有0个。

第三行：cpu状态
- 6.7% us — 用户空间占用CPU的百分比。
- 0.4% sy — 内核空间占用CPU的百分比。
- 0.0% ni — 改变过优先级的进程占用CPU的百分比
- 92.9% id — 空闲CPU百分比
- 0.0% wa — IO等待占用CPU的百分比
- 0.0% hi — 硬中断（Hardware IRQ）占用CPU的百分比
- 0.0% si — 软中断（Software Interrupts）占用CPU的百分比












------------
