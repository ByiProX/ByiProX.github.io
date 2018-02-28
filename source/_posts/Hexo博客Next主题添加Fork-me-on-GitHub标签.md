---
title: Hexo博客Next主题添加Fork me on GitHub标签
date: 2018-02-28 18:09:26
tags:
  - Hexo
categories:
  - Hexo
---

给自己的个人博客添加Fork me on GitHub标签感觉很专业很逼格，添加的方法也很简单，介绍如下。

打开文件：**hexo博客根目录/themes/next/layout/_layout.swig** 找到如下代码块
```python
...
<div class="{{ container_class }} {% block page_class %}{% endblock %} ">
    <div class="headband"></div>
    [样式代码]
...

```
<!-- more -->
样式代码 [**看这里**](https://link.jianshu.com/?t=https://github.com/blog/273-github-ribbons) ，挑选自己喜欢的样式。

然后将样式代码添加到上述 **_layout.swig** 代码块后面，比如选择黑色经典款，即：
```python
...
<div class="{{ container_class }} {% block page_class %}{% endblock %} ">
    <div class="headband"></div>
    # [样式代码]
    <a href="https://github.com/you"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/38ef81f8aca64bb9a64448d0d70f1308ef5341ab/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png"></a>

...

```


重新部署一下就可以查看了，如果显示不出来，需要清理浏览器的cookie,多刷新几次就OK了。
大家看我的，感觉很搭( ⊙ o ⊙ )！
![fork me on github](http://upload-images.jianshu.io/upload_images/2952111-13a15afaa9450272.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
