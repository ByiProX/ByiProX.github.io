---
title: Java 方法设置默认参数
date: 2018-09-09 18:59:52
tags:
  - Java
categories:
  - Java
---
Java本身不支持设置默认值，需要用重载间接实现。

因为“默认参数”和“方法重载”同时支持的话有二义性的问题，Java可能为了简单就不要“默认参数”了。使用“方法重载”可以间接实现”默认参数“的效果，而且避免了代码过于hack（乱）。

```Java
public class A{
   public void doA(int a){
   }
   public void doA(){
       this.doA(0);//这里默认传入0，可以近似与通过这个方法重载，实现了默认值
   }
}

```
