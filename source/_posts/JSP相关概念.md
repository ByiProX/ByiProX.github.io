---
title: JSP相关概念
date: 2018-09-28 10:49:49
tags:
---

#### JSP内置对象：

1. `request`：负责得到客户端请求的信息，对应类型：javax.servlet.http.HttpServletRequest

2. `response`:负责向客户端发出响应，对应类型：javax.servlet.http.HttpServletResponse

3. `session`:负责保存同一客户端一次会话过程中的一些信息，对应类型：javax.servlet.http.httpsession

4. `out`: 负责管理对客户端的输出，对应类型：javax.serlvet.jsp.jspwriter

5. `application`:表示整个应用环境的信息，对应类型：javax.servlet.servletcontext

6. `config`:表示ServletConfig，对应类型：javax.servlet.servletconfig

7. `exception`:表示页面中发生的异常，可以通过它获得页面异常信息，对应类型：java.lang.exception

8. `pagecontext`:表示这个JSP页面上下文，对应类型：javax.servlet.jsp.pagecontext

9. `page`:表示当前JSP页面本身。

<!-- more -->

#### JSP的四种作用域

1. `page`是代表一个页面相关的对象和属性。一个页面由一个编译好的java servlet类（可以带有include指令，但不可以带有include动作）表示。这既包括servlet又包括编译成servlet的jsp页面。

2. `request`是代表与web客户机发出的一个请求相关的对象和属性。一个请求可能跨越多个页面，涉及多个web组件（由于`forward`指令和`include`动作的关系）

3. `session`是代表与用于某个web客户机的一个用户体验相关的对象和属性。一个web回话也可以经常跨域多个客户机请求。

4. `application`是代表与整个web应用程序相关的对象和属性。这实质上是跨域整个web应用程序，包括多个页面、请求和回话的一个全局作用域
