---
title: Java中的volatile关键字
date: 2020-04-12 16:40:41
tags: Java
---
Volatile [ˈvɑːlətl]，中文解释：反复无常的，易变的，不稳定的。
volatile的本意是告诉编译器，此变量的值是易变的，每次读写该变量的值时务必从该变量的内存地址中读取或写入，不能为了效率使用对一个“临时”变量的读写来代替对该变量的直接读写。编译器看到了volatile关键字，就一定会生成内存访问指令，每次读写该变量就一定会执行内存访问指令直接读写该变量。若是没有volatile关键字，编译器为了效率，只会在循环开始前使用读内存指令将该变量读到寄存器中，之后在循环内都是用寄存器访问指令来操作这个“临时”变量，在循环结束后再使用内存写指令将这个寄存器中的“临时”变量写回内存。在这个过程中，如果内存中的这个变量被别的因素（其他线程、中断函数、信号处理函数、DMA控制器、其他硬件设备）所改变了，就产生数据不一致的问题。

volatile关键字在用C语言编写嵌入式软件里面用得很多，不使用volatile关键字的代码比使用volatile关键字的代码效率要高一些，但就无法保证数据的一致性。
在Java中，volatile 会确保我们对于这个变量的读取和写入，都一定会同步到主内存里，而不是从 Cache 里面读取。
<!-- more -->
#### Case 1

```Java
public class VolatileTest {
    private static volatile int COUNTER = 0;

    public static void main(String[] args) {
        new ChangeListener().start();
        new ChangeMaker().start();
    }

    static class ChangeListener extends Thread {
        @Override
        public void run() {
            int threadValue = COUNTER;
            while ( threadValue < 5){
                if( threadValue!= COUNTER){
                    System.out.println("Got Change for COUNTER : " + COUNTER + "");
                    threadValue= COUNTER;
                }
            }
        }
    }

    static class ChangeMaker extends Thread{
        @Override
        public void run() {
            int threadValue = COUNTER;
            while (COUNTER <5){
                System.out.println("Incrementing COUNTER to : " + (threadValue+1) + "");
                COUNTER = ++threadValue;
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) { e.printStackTrace(); }
            }
        }
    }
}
```

在这个程序里，我们先定义了一个 volatile 的 int 类型的变量，COUNTER。然后，我们分别启动了两个单独的线程，一个线程我们叫 ChangeListener。

ChangeListener 这个线程运行的任务很简单。它先取到 COUNTER 当前的值，然后一直监听着这个 COUNTER 的值。一旦 COUNTER 的值发生了变化，就把新的值通过 println 打印出来。直到 COUNTER 的值达到 5 为止。这个监听的过程，通过一个永不停歇的 while 循环的`忙等待`来实现。

另外一个 ChangeMaker 线程运行的任务同样很简单。它同样是取到 COUNTER 的值，在 COUNTER 小于 5 的时候，每隔 500 毫秒，就让 COUNTER 自增 1。在自增之前，通过 println 方法把自增后的值打印出来。

最后，在 main 函数里，我们分别启动这两个线程，来看一看这个程序的执行情况。

``` Java
Incrementing COUNTER to : 1
Got Change for COUNTER : 1
Incrementing COUNTER to : 2
Got Change for COUNTER : 2
Incrementing COUNTER to : 3
Got Change for COUNTER : 3
Incrementing COUNTER to : 4
Got Change for COUNTER : 4
Incrementing COUNTER to : 5
Got Change for COUNTER : 5
```

程序的输出结果并不让人意外。ChangeMaker 函数会一次一次将 COUNTER 从 0 增加到 5。因为这个自增是每 500 毫秒一次，而 ChangeListener 去监听 COUNTER 是`忙等待`的，所以每一次自增都会被 ChangeListener 监听到，然后对应的结果就会被打印出来。

终极原因是：volatile保证所有数据的读和写都来自`主内存`。ChangeMaker 和 ChangeListener 之间，获取到的 COUNTER 值就是一样的。

#### Case 2

如果我们把上面的程序小小地修改一行代码，把我们定义 COUNTER 这个变量的时候，设置的 volatile 关键字给去掉，重新运行后发现：
``` Java
Incrementing COUNTER to : 1
Incrementing COUNTER to : 2
Incrementing COUNTER to : 3
Incrementing COUNTER to : 4
Incrementing COUNTER to : 5
```
这个时候，ChangeListener 又是一个忙等待的循环，它尝试不停地获取 COUNTER 的值，这样就会从`当前线程的“Cache”里面获取`。于是，这个线程就没有时间从主内存里面同步更新后的 COUNTER 值。这样，它就一直卡死在 COUNTER=0 的死循环上了。

#### Case 3
再对程序做一个小的修改。我们不再让 ChangeListener 进行完全的忙等待，而是在 while 循环里面，Sleep 5 毫秒，看看会发生什么情况。
``` Java
static class ChangeListener extends Thread {
    @Override
    public void run() {
        int threadValue = COUNTER;
        while ( threadValue < 5){
            if( threadValue!= COUNTER){
                System.out.println("Sleep 5ms, Got Change for COUNTER : " + COUNTER + "");
                threadValue= COUNTER;
            }
            try {
                Thread.sleep(5);
            } catch (InterruptedException e) { e.printStackTrace(); }
        }
    }
}
```

运行结果：
``` Java
Incrementing COUNTER to : 1
Sleep 5ms, Got Change for COUNTER : 1
Incrementing COUNTER to : 2
Sleep 5ms, Got Change for COUNTER : 2
Incrementing COUNTER to : 3
Sleep 5ms, Got Change for COUNTER : 3
Incrementing COUNTER to : 4
Sleep 5ms, Got Change for COUNTER : 4
Incrementing COUNTER to : 5
Sleep 5ms, Got Change for COUNTER : 5
```

解释：
虽然没有使用 volatile 关键字强制保证数据的一致性，但是短短 5ms 的 Thead.Sleep 的线程会让出CPU，线程被唤醒后才会去重新加载变量。它也就有机会把最新的数据从主内存同步到自己的高速缓存里面了。于是，ChangeListener 在下一次查看 COUNTER 值的时候，就能看到 ChangeMaker 造成的变化了。

虽然 JMM 只是 Java 虚拟机这个进程级虚拟机里的一个隔离了硬件实现的虚拟机内的抽象模型，但是这个内存模型，和计算机组成里的 CPU、高速缓存和主内存组合在一起的硬件体系非常相似。以上就是一个很好的“缓存同步”问题的示例。也就是说，如果我们的数据，在不同的线程或者 CPU 核里面去更新，因为不同的线程或 CPU 核有着各自的缓存，很有可能在 A 线程的更新，因为数据暂时不一致，在 B 线程里面是不可见的。

