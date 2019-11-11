---
title: 浅析Python中的列表和元组
date: 2019-10-07 13:25:10
tags:
  - Python3
  - Python源码
categories:
  - Python3 进阶
---

#### 区别
1. 列表是`动态数组`，它们可变且可以重设长度(改变其内部元素的个数)。
2. 元组是`静态数组`，它们不可变，且其内部数据一旦创建便无法改变。
3. 元组缓存于Python运行时环境，这意味着我们每次使用元组时无须访问内核去 分配内存。

这些区别揭示了两者在设计哲学上的不同:元组用于描述一个不会改变的事物的多个属性，而列表可被用于保存多个互相独立对象的数据集合。

<!-- more -->
#### 动态数组--列表

列表可以改变大小及内容不同，列表的可变性的代价在于存储它们需要额外的内存以及使用它们需要额外的计算。我们在[浅析Python中列表操作之\*和\*=](https://mp.weixin.qq.com/s?__biz=MzU5OTUwMTA4NA==&mid=2247483804&idx=1&sn=4cef9561e71e5c6a621529be757a5b2f&chksm=feb2b1efc9c538f9ddcb91175fedd6468cfbc5e2b613b3d8a48077a8ea0194b41a7ff8e20e9d&token=475883438&lang=zh_CN#rd)中一起研究了cpython的list对象的源码，看到了list对象的动态分配数组的大体过程(调用resize函数)，而且在动态调整数组大小时使用如下的分配公式:

```c
new_allocated = (size_t)newsize + (newsize >> 3) + (newsize < 9 ? 3 : 6);
```

下图是一个列表多次添加元素时分配空间的变化示意图：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191007131224310.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM0MTUyMjQ0,size_16,color_FFFFFF,t_70)

#### 静态数组--元组
元组的不可改变性使其成为了一个非常轻量级的数据结构。这意味着存储元组不需要很多的内存开销，而且对元组的操作也非常直观。一旦元组被创建，它的内容无法被修改或它的大小也无法被改变。虽然它们不支持改变大小，但是我们可以将两个元组合并成一个新元组。这一操作类似列表的resize操作，但我们不需要为新生成的元组分配任何`额外`的空间。任意两个元组相加或者元组乘以一个整数进行repeat始终返回一个新分配的元组。其中两个元组相加调用cpython中的tupleconcat方法，而乘法操作调用的是tuplerepeat方法。上述两个方法的实现如下：

```c
static PyObject *
tupleconcat(PyTupleObject *a, PyObject *bb)
{
    ...
    size = Py_SIZE(a) + Py_SIZE(b);
    np = tuple_alloc(size);
    ...
    return (PyObject *)np;

}
```


```c
static PyObject *
tuplerepeat(PyTupleObject *a, Py_ssize_t n)
{
    ...
    size = Py_SIZE(a) * n;
    np = tuple_alloc(size);
    ...

    return (PyObject *) np;
}
```

元组的静态特性的另一个好处体现在一些会在Python后台发生的事:资源缓存。Python是一门垃圾收集语言，这意味着当一个变量不再被使用时，Python会将该变量使用的内存释放回操作系统，以供其他程序(或变量)使用。`然而，从源码中可以看到，对于长度为1~20的元组，即使它们不再被使用，它们的空间也不会立刻被还给系统，而是留待未来使用`。这意味着当未来需要一个同样大小的新元组时，我们不再需要向操作系统申请一块内存来存放数据，因为我们已经有了预留的内存。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191007131407450.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM0MTUyMjQ0,size_16,color_FFFFFF,t_70)

我们可以验证资源缓存这一点，可以看到初始化一个列表消耗的时间是初始化一个元组消耗时间的6倍！可以想象一下，某些场景中在一个循环中频繁创建列表，耗时还是非常可观的，此时可以考虑使用元组来提高执行效率。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191007132116239.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM0MTUyMjQ0,size_16,color_FFFFFF,t_70)


-----
