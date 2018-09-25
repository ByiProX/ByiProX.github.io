---
title: URL、URI和URN三者之间的区别
date: 2018-09-25 14:37:38
tags:
  - 网络
categories:
  - 网络
---
URL -- Uniform Resource Locator，统一资源定位符。即URL可以用来标识一个资源，而且还指明了如何locate这个资源。

URN -- Uniform Resource Name，统一资源命名。即通过名字来表示资源的。

URI -- Uniform Resource Identifier，即统一资源标志符，用来唯一的标识一个资源。

URL和URN都是URI的子集。

一个用于理解这三者的例子。

关于URL：

> URL是URI的一种，不仅标识了Web 资源，还指定了操作或者获取方式，同时指出了主要访问机制和网络位置。

关于URN：

> URN是URI的一种，用特定命名空间的名字标识资源。使用URN可以在不知道其网络位置及访问方式的情况下`讨论`资源。

-----------

<!-- more -->
下面展示一个例子，非常简单清楚地告诉你在互联网中URI 、URL和URN之间的不同。


这是一个`URI`:
```bash
http://bitpoetry.io/posts/hello.html#intro
```
其中：

- `http://`:是定义如何访问资源的**方式**。

- `bitpoetry.io/posts/hello.html`是资源存放的**位置**。

- `#intro`是资源。


URL是URI的一个子集，告诉我们访问网络位置的方式。在我们的例子中，`URL`应该如下所示：
```bash
http://bitpoetry.io/posts/hello.html
```


`URN`是URI的子集，包括名字（给定的命名空间内），但是不包括访问方式，如下所示：

```bash
bitpoetry.io/posts/hello.html#intro
```


至少要记住一件事：URI可以被分为URL、URN或两者的组合。如果你一直使用URI这个术语，绝对不会出错错。









----------
