---
title: Java之super和this
date: 2018-10-29 09:31:49
tags:
  - Java
categories:
  - Java
---

this: 当前的对象，哪一个对象调用this，this就代指哪一个对象。
super: 当前对象的父类方法或构造器。

#### super
1. `当new一个子类对象的时候，会先创建一个父类对象`。可以认为，在调用子类构造器之前，在子类构造器中会先调用父类的构造器，默认调用的是父类无参数的构造器。调用父类构造器后悔创建一个父类的对象。

2. 如果父类不存在可以被子类访问的构造器，则不能存在子类，即子类不会被创建成功。

3. 如果父类没有提供无参数的构造器，则此时子类必须显式的通过`super`语句去掉用父类带参数的构造器。

4. 子类构建的所有的行为建立在第一条规则基础之上。


<!-- more -->
```Java
class Animal {
    private String name;
    private int    age;
    Animal(String name, int age){
        this.name = name;
        this.age = age;
        System.out.println("animal constructor");
    }
    Animal(String color){
        System.out.println("this is a " + color +" color");
    }
    public void say(){
        System.out.println("Animals Say sth...");
    }

}

class Fish extends Animal
{
    private String color;
    Fish(){
       //构造器中的第一句必须为super，如果不写，则默认调用super()
       super("RED"); //子类没有提供无参数的构造器，必须显示super滴啊用，否则会编译失败
       System.out.println("Fish Constructor");
    }
}
```
一个简单的示意图如下：
![Screen Shot 2018-10-28 at 22.12.48.png](https://upload-images.jianshu.io/upload_images/2952111-2db47a7c0f8a1ec1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


#### this

##### 存在于位置
1. 在构造器中，表示当前创建的对象
2. 在方法中，哪一个对象调用this所在的方法，那么此时this就表示哪一个对象。

![Screen Shot 2018-10-28 at 16.28.10.png](https://upload-images.jianshu.io/upload_images/2952111-bf1b724c2da63d77.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


##### this的使用
1. 解决成员变量的参数（局部变量）之间的二义性，必须使用this区分
2. 同类中实例方法互相调用时可以省略this关键字，但是不建议省略
3. 将this作为参数传递给另外一个方法
4. 将this作为方法的返回值（链式方法编程）
5. 构造器函数的互相调用，this([参数])必须写在构造器内的第一行，与super类似。
6. this不能喝static一起使用。原因是当字节码被加载进jvm时，static成员已经存在了，但是此时对象还没有被创建，没有对象，也就没有this。

```Java
User(String name){
  this.name = name;
}
User(String name, int age){
  this(name); //表示在调用参数为string类型的构造器
  this.age = age;
}

//上述调用方式为多参数构造器调用少参数构造器，一般工程经验为少参数构造器调用多参数构造器
//对于多余的参数，使用默认值赋值即可，如下
User(String name, int age){
  this.name = name;
  this.age = age;
}

User(String name){
  this(name, 0);//此处对int age赋值为0即可
}

```


![Screen Shot 2018-10-28 at 16.41.16.png](https://upload-images.jianshu.io/upload_images/2952111-955c8e05df6fd8ef.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![Screen Shot 2018-10-28 at 16.58.54.png](https://upload-images.jianshu.io/upload_images/2952111-1d10520f4fc5a369.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

















是
