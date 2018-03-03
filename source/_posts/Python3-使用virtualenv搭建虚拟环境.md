---
title: Python3 使用virtualenv搭建虚拟环境
date: 2018-03-03 13:28:31
tags:
  - Python3
categories:
  - Python3 进阶
  - Python3 virtualenv
---

在使用Python进行多个项目开发时，每个项目可能会需要安装不同的组件。把这些组件安装在同一台计算机下可能会导致组件之间的相互冲突，比如项目A使用Django 1.10，而项目B使用Django 1.8，那么同时安装两个版本可能在具体使用时产生冲突。使用虚拟环境可以有效避免这样的问题。

Python虚拟环境是一套由Ian Bicking编写的管理独立Python运行环境的系统。这样，开发者可以让每个项目运行在独立的虚拟环境中，从而避免了不同项目之间组件配置的冲突。
<!-- more -->
#### 1.虚拟环境安装

在终端中执行命令：
```bash
$ pip install virtualenv
```
#### 2.虚拟环境使用  


假定我们要开发一个新的项目，需要一套独立的Python运行环境，或者为已有的项目建立虚拟环境，终端执行如下命令：
```bash
$ cd   [项目所在目录]
$ virtualenv venv
```
该命令执行后，将在当前目录下建立一个venv目录，**该目录拷贝一份完整的当前系统的Python环境**；

我么也可以执行
```bash
$ virtualenv --no-site-packages venv
```
这样，已经安装到系统Python环境中的所有第三方包都不会复制过来，这样，我们就得到了一个不带任何第三方包的“干净”的Python运行环境。新建的Python环境被放到当前目录下的venv目录。

有了venv这个Python环境，可以用source进入该环境（注意是在cd之后的目录）：
```bash
$ source venv/bin/activate[.fish|.zsh]
```
注意到命令提示符变了，有个(venv)前缀，表示当前环境是一个名为venv的Python环境。在venv环境下，用pip安装的包都被安装到venv/lib目录，而不会影响系统的Python环境。

退出当前的venv环境，使用deactivate命令：
```bash
$ deactivate
```
此时回到了正常的环境，现在pip或python均是在系统Python环境下执行。

#### 3.注意

为保证项目之间的独立性，建议所有使用pip安装的组件都在项目虚拟环境中进行，避免不同版本的冲突。

最后附上[Virtualenv的官方文档](https://virtualenv.pypa.io/en/stable/)
