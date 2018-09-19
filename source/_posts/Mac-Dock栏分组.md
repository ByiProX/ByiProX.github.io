---
title: Mac Dock栏分组
date: 2018-09-18 13:42:06
tags:
  - 玩转苹果
categories:
  - 玩转苹果
---

#### 方法1
终端下输入如下命令
```bash
~ defaults write com.apple.dock persistent-apps -array-add '{ "tile-type" = "spacer-tile"; }'

~ killall Dock
```
实际上在docker中添加了空白的icon，如需删除只需右键移除即可。

<!-- more -->

#### 方法2

https://github.com/DeromirNeves/VerticalBar

https://github.com/DeromirNeves/VerticalBar.git
