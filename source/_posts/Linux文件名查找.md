---
title: Linux文件名查找
date: 2018-09-05 19:43:59
tags:
  - Linux/Mac OS
categories:
  - Linux/Mac OS
---
通常情况下`find`不是很常用，因为速度较慢。一般都是先使用`whereis`或者是`locate`来检查，如果真找不到，才使用`find`来查找。因为`whereis`与`locate`是利用数据库来查找数据，所以速度相当快，而且并没有实际去查询硬盘，比较节省时间;`find`直接打查找硬盘，所以查询速度要慢。

<!-- more -->

#### whereis
> whereis [-bmsu] 文件或者目录名

Linux系统会将系统内的所有文件都记录在一个数据库文件里面，而当使用`whereis`或者下面的`locate`命令时，都会以此数据库文件内容为准。因此有时候还会发现使用这两个命令查找文件时，会找到已经删掉的文件。而且有可能找不到最新刚刚创建的文件。

#### locate
> locate [-ir] keyword

locate使用更简单，直接在后面输入`文件的部分名称`后就能得到结果。被搜索的数据库默认是每天执行一次，该数据库的位置为`/var/lib/mlocate/`。我们可以选择手动更新数据库，直接命令行输入`updatedb` 即可。

#### find
> find [path] [option] [option]

示例1：将过去24小时内有改动的文件列出
```Bash
find / -mtime 0

find / -mtime 3 <==表示三天前的24小时
```

示例2：寻找/etc下面的文件，如果文件日期比/etc/passwd新就列出
```Bash
find /etc -newer /etc/passwd
```
示例3：查找/home下属于wkx的文件
```Bash
find /home -user wkx
```

示例4：查找系统中不属于任何人的文件
```Bash
find / -nouser
```
示例5：找出文件名为passwd的文件
```Bash
find / -name passwd
```
示例6：找出/var目录下文件类型为socket的文件名有哪些
```Bash
find /var -type s
```

示例7：找出含有SGID或者SUID或者SBIT的属性文件
```Bash
find / -perm +7000
# 文件权限只要含有s或者t就列出
```

- -perm  mode: 文件权限刚好等于mode的文件
- -perm -mode: 文件权限`全部包括mode`的文件
- -perm +mode: 文件权限`包含任意mode`的文件





---------
