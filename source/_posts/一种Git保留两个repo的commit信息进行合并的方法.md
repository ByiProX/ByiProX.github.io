---
title: 一种Git保留两个repo的commit信息进行合并的方法
date: 2018-02-27 14:46:37
tags:
  - Git
categories:
  - Git

---

以往的合并时首先要删除repo的.git文件夹，然后重新add-commit-push。带来的问题是会丢失某一个仓库的提交信息，不利于时光倒退。经过摸索终于实现了保留两个仓库提交信息的合并方法。介绍如下：

<!--more-->

比如要将DownloadPicsBySeleniumAndPhantomJS这个项目合并到Web-Spider中，终端中执行：

![](http://img.blog.csdn.net/20180213030000117)

接下来解决merge冲突即可（可以尝试使用mergetool），如有需要可以删除多余分支和远程连接


```Bash
$ git mergetool # 解决merge冲突  
```
```bash

$ git remote rm other # 删除远程连接  
$ git branch -d repo1 # 删除分支操作  
```
