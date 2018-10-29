---
title: Java编译类型和运行类型
date: 2018-10-29 22:00:41
tags:
  - Java
categories:
  - Java
---


```Java

class Animal{

}

class Dog extends Animal{
  public void eat(){}
}

----------
Animal a = new Dog();
a.eat()//编译报错
((Dog) a).run()//编译通过

```

如上的简易代码，编译时会报错。
编译类型：Animal a
运行类型：new Dog()

编译时，编译类型会根据a.eat()查找eat方法，找不到就会报错。
使用强制类型转换可以解决该问题，即
((Dog) a).run()
