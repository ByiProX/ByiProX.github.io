---
title: 什么是Socket(转)
date: 2018-03-13 00:49:26
tags:
  - 网络
categories:
  - 网络
---
对TCP/IP、UDP、Socket编程这些词你不会很陌生吧？随着网络技术的发展，这些词充斥着我们的耳朵。那么我想问：
1. 什么是TCP/IP、UDP？
2. Socket在哪里呢？
3. Socket是什么呢？
4. 你会使用它们吗？

## 什么是TCP/IP、UDP

TCP/IP（Transmission Control Protocol/Internet Protocol）即传输控制协议/网间协议，是一个工业标准的协议集，它是为广域网（WANs）设计的。
UDP（User Data Protocol，用户数据报协议）是与TCP相对应的协议。它是属于TCP/IP协议族中的一种。

![1.jpg](https://upload-images.jianshu.io/upload_images/2952111-571c60b933d42028.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<!-- more -->
TCP/IP协议族包括运输层、网络层、链路层。由上图可以知道TCP/IP与UDP的关系。

## Socket在哪里
![2.jpg](https://upload-images.jianshu.io/upload_images/2952111-1dd2ce6b61d08816.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Socket是什么
Socket是应用层与TCP/IP协议族通信的中间软件抽象层，它是一组接口。在设计模式中，Socket其实就是一个门面模式，它把复杂的TCP/IP协议族隐藏在Socket接口后面，对用户来说，一组简单的接口就是全部，让Socket去组织数据，以符合指定的协议。

## 如何使用
前人已经给我们做了好多的事了，网络间的通信也就简单了许多，但毕竟还是有挺多工作要做的。以前听到Socket编程，觉得它是比较高深的编程知识，但是只要弄清Socket编程的工作原理，神秘的面纱也就揭开了。
一个生活中的场景。你要打电话给一个朋友，先拨号，朋友听到电话铃声后提起电话，这时你和你的朋友就建立起了连接，就可以讲话了。等交流结束，挂断电话结束此次交谈。    
生活中的场景就解释了这工作原理，也许TCP/IP协议族就是诞生于生活中，这也不一定。

![3.jpg](https://upload-images.jianshu.io/upload_images/2952111-99ebc49204f5b380.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

先从服务器端说起。服务器端先初始化Socket，然后与端口绑定(bind)，对端口进行监听(listen)，调用accept阻塞，等待客户端连接。在这时如果有个客户端初始化一个Socket，然后连接服务器(connect)，如果连接成功，这时客户端与服务器端的连接就建立了。客户端发送数据请求，服务器端接收请求并处理请求，然后把回应数据发送给客户端，客户端读取数据，最后关闭连接，一次交互结束。

在这里我就举个简单的例子，我们走的是TCP协议这条路（见图2）。例子用MFC编写，运行的界面如下：


![4.jpg](https://upload-images.jianshu.io/upload_images/2952111-36073682cf397e4f.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![5.jpg](https://upload-images.jianshu.io/upload_images/2952111-61b92a5dbbb8bf69.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在客户端输入服务器端的IP地址和发送的数据，然后按发送按钮，服务器端接收到数据，然后回应客户端。客户端读取回应的数据，显示在界面上。

客户端就一个函数完成了一次通信。在这里IP地址为何用127.0.0.1呢？使用这个IP地址，服务器端和客户端就能运行在同一台机器上，这样调试方便多了。当然你可以在你朋友的机器上运行Server程序(本人在局域网中测试过)，在自己的机器上运行Client程序，当然输入的IP地址就该是你朋友机器的IP地址了。

## 参考
1. http://www.360doc.com/content/11/0609/15/5482098_122692444.shtml
