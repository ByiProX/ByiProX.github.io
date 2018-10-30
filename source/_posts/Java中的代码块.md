---
title: Java中的代码块
date: 2018-10-30 09:24:49
tags:
  - Java
categories:
  - Java
---


> 什么是代码块：在类或者方法中，直接使用`{}`括起来的一段代码，表示一块带啊区域。

代码在块中属于局部变量，只在自己所在的花括号区域内有效。
根据代码块所定义的位置不同，代码块分为三种形式

1. `局部代码块`：直接定义在`方法内部`的代码块。
一般的，不会直接使用局部代码块，只不过会结合if、while等关键字，表示一块代码区域。

2. `初始化代码块(构造代码块)`：直接定义在`类`中。
每次创建对象的时候都会执行初始化代码块：每次创建对象的时候都会调用构造器，在调用构造器之前，会先执行本类中的初始化代码块。`PS`:`通过反编译，可以看到，初始化代码也作为构造器最初的语句。`一般不使用这种用法，因为不够优雅美观。即使要初始化操作，一般在构造器中进行初始化即可。或者专门定义一个方法做初始化操作，方法哦构造器中进行调用。

3. `静态代码块：使用static修饰的初始化代码块。`
静态代码块在主方法执行之前进行调用，而且只会执行一次。main方法是程序的入口，静态代码块由于main方法执行。静态成员随着字节码的加载也加载进JVM,此时main还没执行，因为方法需要JVM调用，先把字节码加载进JVM，然后JVM再调用main方法。`一般的，我们使用静态代码块来做初始化操作，加载资源，加载配置文件等。`

<!-- more -->
```Java
class CodeBlockDemo{
  {
    System.out.println("初始化代码块");
  }
  CodeBlockDemo(){
    System.out.println("构造器。。。");
  }

  static{
    System.out.println("静态代码块");
  }

  public static void main(String[] args){
    System.out.println("进入main方法");
    //创建三个匿名对象
    new CodeBlockDemo();
    new CodeBlockDemo();
    new CodeBlockDemo();
  }

}

/*执行结果如下
静态代码块
进入main方法
初始化代码块
构造器。。。
初始化代码块
构造器。。。
初始化代码块
构造器。。。
*/
```
一道Java面试题
```Java
public class App {
    private static App d = new App();
    private SuperClass t = new SubClass(); //先确定依赖，由此开始作为入口

    static{
        System.out.println(4);
    }

    App(){
        System.out.println(3);
    }

    public static void main(String[] args){
        System.out.println("Hello");
    }

}

class SuperClass{
    SuperClass(){
        System.out.println("构造SuperClass");
    }
}


class SubClass extends SuperClass{
    static {
        System.out.println(1);
    }

    SubClass(){
        //super();
        System.out.println(2);
    }
}


//执行结果
1
构造SuperClass
2
3
4
Hello

```

`分析：`

1. 首先在执行子类subclass构造器的时候先执行隐藏的`super();`来执行父类的构造器，也就是构造`SuperClass`在`2`之前打印.
2. 为什么不先打印4而是先打印子类的1？原因是class App依赖于依赖于subclass，会优先编译subclass，也就是说会优先编译被依赖的优先存在的类。所以首先把subclass加载到虚拟机，因此首先打印1.`编译的时候首先确定依赖!!!`

3. 非static字段的初始化都在构造器中执行，也就是说App类反编译后如下。可以看出，打印`1`后,在APP构造器中实例化subclass，此时，先打印父类构造器中的`构造SuperClass`,然后打印子类的`2`。紧接着继续执行APP构造器的代码块，打印app构造器中的`3`。

```Java
public class App {
    private static App d = new App();
    private SuperClass t = null; //先确定依赖，由此开始作为入口

    static{
        System.out.println(4);
    }

    App(){
        t = new SubClass(); //非static字段的初始化都在构造器中执行
        System.out.println(3);
    }

    public static void main(String[] args){
        System.out.println("Hello");
    }

}
```

4. 以上依赖关系确认完毕，然后开始将App加载进虚拟机，执行由于静态代码块优先于main，静态代码块执行，打印4，最后执行main方法，打印hello.
