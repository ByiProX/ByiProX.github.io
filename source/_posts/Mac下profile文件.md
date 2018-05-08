---
title: Mac下profile文件
date: 2018-05-08 18:50:47
tags:
  - Linux/Mac OS
categories:
  - Linux/Mac OS
---

当你的home下面有`.bash_profile`或者`.bash_login`的时候,会忽略调`.profile`.   

`.profile`主要有一下几种方式   
/etc/profile    
~/.bash_profile    
~/.bash_login    
~/.profile    
~/.bashrc    
~/.bash_logout   

/etc/profile   
`登录的时候`读入,默认的设定文件.   
~/.bash_profile   
`登录之后`在/etc/profile载入之后载入,十分重要的配置文件   
~/.bash_login   
`登录之后`如果~/.bash_profile不存在的话,载入这个文件   
~/.profile   
登录之后~/.bash_login不存在的话,才载入这个文件   
~/.bashrc   
bash shell打开的时候载入

`etc下的配置是针对系统,~下的主要是针对用户`

参考：https://blog.csdn.net/xdonx/article/details/8312938
