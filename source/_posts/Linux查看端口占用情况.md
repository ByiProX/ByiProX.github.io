---
title: Linux查看端口占用情况
date: 2019-05-28 10:11:18
tags:
  - Linux/Mac OS
categories:
  - Linux/Mac OS
---

### lsof

- lsof -i 用以显示符合条件的进程情况，lsof(list open files)是一个列出当前系统打开文件的工具。以root用户来执行lsof -i命令

- lsof -i:端口号，用于查看某一端口的占用情况，比如查看22号端口使用情况，lsof -i:22

![Screen Shot 2019-05-28 at 13.50.08.png](https://upload-images.jianshu.io/upload_images/2952111-34cfaa89c8a414a5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### netstat

netstat -tunlp用于显示tcp，udp的端口和进程等相关情况

![Screen Shot 2019-05-28 at 13.51.26.png](https://upload-images.jianshu.io/upload_images/2952111-79a5c99ebc5ba5c3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
