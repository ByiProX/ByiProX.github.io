---
title: Java包装类中的缓存设计
date: 2018-10-30 15:13:26
tags:
  - Java
categories:
  - Java
---
包装类中的`缓存设计`([享元模式-FlyWeight](https://baike.baidu.com/item/%E4%BA%AB%E5%85%83%E6%A8%A1%E5%BC%8F/10541959?fr=aladdin))，本质就是缓存设计。

`Byte/Short/Integer/Long`:缓存[-128, 127]区间的数据；
`Character`:缓存[0,127]区间的数据.
<!-- more -->
首先来看一个有意思的面试题

```Java
public class Test {
    public static void main(String[] args) {
        //case 1
        Integer i1 = new Integer(123);
        Integer i2 = new Integer(123);
        System.out.println(i1 == i2); //false

        //case 2
        Integer i3 = Integer.valueOf(123);
        Integer i4 = Integer.valueOf(123);
        System.out.println(i3 == i4); //true

        //case 3
        Integer i5 = 123; //自动装箱操作，底层编译后代码为Integer.valueOf(123);    和case2相同
        Integer i6 = 123;
        System.out.println(i5 == i6); // true

        System.out.println(">>>>>>>>>>>>>>>>>>>");

        //case 4
        Integer ii1 = new Integer(250);
        Integer ii2 = new Integer(250);
        System.out.println(ii1 == ii2); //false

        //case 5
        Integer ii3 = Integer.valueOf(250); // 250不在缓存区间内，就得new新对象
        Integer ii4 = Integer.valueOf(250);
        System.out.println(ii3 == ii4); // false

        // case 6
        Integer ii5 = 250;
        Integer ii6 = 250;
        System.out.println(ii5 == ii6); // false
    }
}
```

查看一下integer源码,如下所示。可以看到Integer的缓存空间在[-128, 127]之间。
当传入的数值在此区间内时，之间调用缓存内的数据。反之，重新`return new Integer(i);`在堆空间返回一个新整形对象。


```Java
public static Integer valueOf(int i) {
        if (i >= IntegerCache.low && i <= IntegerCache.high)
            return IntegerCache.cache[i + (-IntegerCache.low)];
        return new Integer(i);
    }

private static class IntegerCache {
        static final int low = -128;
        static final int high;
        static final Integer cache[];

        static { // 初始化操作
            // high value may be configured by property
            int h = 127;
            String integerCacheHighPropValue =
                sun.misc.VM.getSavedProperty("java.lang.Integer.IntegerCache.high");
            if (integerCacheHighPropValue != null) {
                try {
                    int i = parseInt(integerCacheHighPropValue);
                    i = Math.max(i, 127);
                    // Maximum array size is Integer.MAX_VALUE
                    h = Math.min(i, Integer.MAX_VALUE - (-low) -1);
                } catch( NumberFormatException nfe) {
                    // If the property cannot be parsed into an int, ignore it.
                }
            }
            high = h;

            cache = new Integer[(high - low) + 1];
            int j = low;
            for(int k = 0; k < cache.length; k++)
                cache[k] = new Integer(j++);

            // range [-128, 127] must be interned (JLS7 5.1.7)
            assert IntegerCache.high >= 127;
        }

        private IntegerCache() {}
    }
```
