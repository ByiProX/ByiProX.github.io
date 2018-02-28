---
title: Hexo部署的网站项目(.deploy_git)中添加README.md
date: 2018-02-28 14:05:20
tags:
  - Hexo
categories:
  - Hexo
---
终端中执行hexo generate时，会将source文件夹中的.md文件渲染为.html文件到public文件夹中，所以我们可以将README.md文件放到source文件夹中，这样在执行hexo deploy时，生成的.deploy_git文件夹中就会有README文件。但此时并不是我们想要的README.md。
<!-- more -->
需要注意的是，我们要防止此.md文件被渲染为.html文件，因此，需要在站点配置文件_config.yml中设置skip_render: README.md，这样部署完成后我们就可以在配置的.deploy_git中看到README.md了。

配置截图如下：

![](http://upload-images.jianshu.io/upload_images/2952111-1ce4c1b9e78bee3c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
