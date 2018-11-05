---
title: Java中的接口和抽象类
date: 2018-11-04 22:20:35
tags:
  - Java
  - 面试
categories:
  - Java
---

相同点：
- 都位于继承的顶端，用于被其他实现或继承
- 都不能实例化
- 都可以定义抽象方法，其子类/实现类都必须复写这些抽象方法。

不同点：
- 接口没有构造方法，抽象类有构造方法。这是因为子类继承抽象类后，在实例化一个子类时，需要检查父类的是否有构造方法。
- 抽象类可包含骗人通方法和抽象方法，`接口只能包含抽象方法（java8之前）`
- 一个类只能继承一个直接父类（可能是抽象类），接口是多继承并且支持一个类实现多个接口（弥补了Java的单继承）
- 成员变量：接口里默认是public static final，抽象类默认包权限
- 方法：接口里默认public abstract,抽象类默认包访问权限
- 内部类：接口里默认public static，抽象类默认包访问权限

如果接口和实现类可以完成与其他方法实现的其他功能，尽量使用接口，面向接口编程。

设计模式：接口和抽象类集合使用的（适配器模式）

`面向接口编程：多态的好处：把实现类对象付给接口类型变量，屏蔽了不同实现类之间的差异，从而可以做到通用编程`

<!-- more -->
```java
package com.wkx.jedis;


interface IUSB{
    void swapData();
}

class Mouse implements IUSB{
    public void swapData(){
        System.out.println("i am moving...");
    }
}

class Printer implements IUSB{
    public void swapData(){
        System.out.println("i am printing, dididi...");
    }
}

class MotherBoard{
    private static IUSB[] usbs = new IUSB[6];
    private static int num = 0;

    public static void pluginIn(IUSB usb){

        if (usbs.length == num) return;
        usbs[num] = usb;
        num ++;

    }
    public static void doWork(){
        for (IUSB usb : usbs){
            if(usb != null) usb.swapData();
        }
    }
}

public class IUSBDemo {
    public static void main(String[] args){
        MotherBoard.pluginIn(new Mouse());
        MotherBoard.pluginIn(new Mouse());
        MotherBoard.pluginIn(new Mouse());
        MotherBoard.pluginIn(new Printer());
        MotherBoard.pluginIn(new Printer());
        MotherBoard.pluginIn(new Printer());
        MotherBoard.pluginIn(new Printer());
        MotherBoard.doWork();
    }

}

```
