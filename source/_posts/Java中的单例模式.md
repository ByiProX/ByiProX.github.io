---
title: Java中的单例模式
date: 2018-10-30 12:00:22
tags:
  - Java
categories:
  - Java
---
#### 1. 饿汉模式
```Java
public class SingletonDemo {
    public static void main(String[] args) {
        ArrayUtil.getInstance().sort(null);
    }

}

class ArrayUtil {
    //1. 在该类中，实例化一个实例
    private static final ArrayUtil instance = new ArrayUtil();

    //2. 私有化自身的构造器，防止外界通过构造器new对象
    private ArrayUtil() {
    }

    //3. 对外开放一个静态公共方法，用于获取对象
    public static ArrayUtil getInstance(){
        return instance;
    }

    public void sort(int[] array) {
        //此处编写排序代码
        System.out.println("I'm sorting " + array);
    }


}
```
