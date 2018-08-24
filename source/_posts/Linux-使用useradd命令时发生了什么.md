---
title: Linux 使用useradd命令时发生了什么
date: 2018-08-24 11:38:49
tags:
  - Linux/Mac OS
categories:
  - Linux/Mac OS
---


使用useradd命令创建用户时首先会参考
- /etc/default/useradd
- /etc/login.defs
- /etc/skel/*

命令执行后，接下来就会创建
- /etc/passwd
- /etc/shadow
- /etc/group
- /etc/gshadow
- 主文件目录（如果配置有的话）

所以，如果我们自己了解整个系统运行的状态，也是可以自己手动直接修改相关文件。
<!-- more -->
