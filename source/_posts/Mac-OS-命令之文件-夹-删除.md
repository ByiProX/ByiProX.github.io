---
title: Mac OS 命令之文件(夹)删除
date: 2018-03-03 13:40:34
tags:
  - Linux/Mac OS
categories:
  - Linux/Mac OS
---
`rmdir`删除空目录，不过一旦目录非空会提示
Directiry not empty

使用`rm`既可以删除文件又可以删除文件夹
删除文件夹（无论文件夹是否为空），使用 `-rf` 命令即可。
即：
```bash
$ rm -rf 目录名字
```
`-r` 就是向下递归，不管有多少级目录，一并删除
`-f` 就是直接强行删除，不作任何提示的意思
<!-- more -->
删除`文件夹`实例：
```bash
$ rm -rf  /User/Dhyana/desktop
```
将会删除 /User/Dhyana/desktop目录以及其下所有文件、文件夹

删除`文件`使用实例：
```bash
$ rm -f  /User/Dhyana/desktop/test.py
```
将会**强制删除**/User/Dhyana/desktop/test.py这个文件

值得注意的是：
使用这个rm -rf的时候一定要格外小心，linux没有回收站的，删除之后再想找回就很难了。有一个非常好笑的笑话就是命令行中输入
```bash
$ rm -rf /.*
# 千万不要输入此命令，否则清空整个操作系统，后果自负
```
