---
title: IO密集型任务、计算密集型任务，以及多线程、多进程
date: 2018-03-05 10:41:27
tags:
  - 操作系统
categories:
  - 操作系统
  - 多任务处理
---
## IO密集型任务 VS 计算密集型任务

  * 所谓IO密集型任务，是指磁盘IO、网络IO占主要的任务，计算量很小。比如请求网页、读写文件等。当然我们在Python中可以利用sleep达到IO密集型任务的目的。  

  * 所谓计算密集型任务，是指CPU计算占主要的任务，CPU一直处于满负荷状态。比如在一个很大的列表中查找元素（当然这不合理），复杂的加减乘除等。


计算密集型任务的特点是要进行大量的计算，消耗CPU资源，比如计算圆周率、对视频进行高清解码等等，全靠CPU的运算能力。这种计算密集型任务虽然也可以用多任务完成，但是任务越多，花在任务切换的时间就越多，CPU执行任务的效率就越低，所以，要最高效地利用CPU，计算密集型任务同时进行的数量应当等于CPU的核心数。

计算密集型任务由于主要消耗CPU资源，因此，代码运行效率至关重要。Python这样的脚本语言运行效率很低，完全不适合计算密集型任务。对于计算密集型任务，最好用C语言编写。

第二种任务的类型是IO密集型，涉及到网络、磁盘IO的任务都是IO密集型任务，这类任务的特点是CPU消耗很少，任务的大部分时间都在等待IO操作完成（因为IO的速度远远低于CPU和内存的速度）。对于IO密集型任务，任务越多，CPU效率越高，但也有一个限度。常见的大部分任务都是IO密集型任务，比如Web应用。

IO密集型任务执行期间，99%的时间都花在IO上，花在CPU上的时间很少，因此，用运行速度极快的C语言替换用Python这样运行速度极低的脚本语言，完全无法提升运行效率。对于IO密集型任务，最合适的语言就是开发效率最高（代码量最少）的语言，脚本语言是首选，C语言最差。


## 多线程 VS 多进程
### 多线程
多线程即在一个进程中启动多个线程执行任务。一般来说使用多线程可以达到并行的目的，但由于Python中使用了全局解释锁GIL的概念，导致Python中的多线程并不是并行执行，而是“交替执行”。类似于下图：（图片转自网络，侵删）

![](https://pic2.zhimg.com/80/v2-dfad6468a9ddd7edd2494971296a00d0_hd.jpg)

所以Python中的多线程适合IO密集型任务，而不适合计算密集型任务。

Python提供两组多线程接口，一是thread模块_thread，提供低等级接口。二是threading模块，提供更容易使用的基于对象的接口，可以继承Thread对象来实现线程，此外其还提供了其它线程相关的对象，例如Timer，Lock等。

多线程模式通常比多进程快一点，但是也快不到哪去，而且，多线程模式致命的缺点就是任何一个线程挂掉都可能直接造成整个进程崩溃，因为所有线程共享进程的内存。在Windows上，如果一个线程执行的代码出了问题，你经常可以看到这样的提示：“该程序执行了非法操作，即将关闭”，其实往往是某个线程出了问题，但是操作系统会强制结束整个进程。

在Windows下，多线程的效率比多进程要高，所以微软的IIS服务器默认采用多线程模式。由于多线程存在稳定性的问题，IIS的稳定性就不如Apache。为了缓解这个问题，IIS和Apache现在又有多进程+多线程的混合模式，真是把问题越搞越复杂。

### 多进程
由于Python中GIL的原因，对于计算密集型任务，Python下比较好的并行方式是使用多进程，这样可以非常有效的使用CPU资源。当然同一时间执行的进程数量取决你电脑的CPU核心数。

![](https://pic3.zhimg.com/80/v2-f1cdf422f5aef9a23f714a399e8e7016_hd.jpg)

Python中的进程模块为mutliprocess模块，提供了很多容易使用的基于对象的接口。另外它提供了封装好的管道和队列，可以方便的在进程间传递消息。Python还提供了进程池Pool对象，可以方便的管理和控制线程。

多进程模式最大的`优点`就是稳定性高，因为一个子进程崩溃了，不会影响主进程和其他子进程。（当然主进程挂了所有进程就全挂了，但是Master进程只负责分配任务，挂掉的概率低）著名的Apache最早就是采用多进程模式。

多进程模式的`缺点`是创建进程的代价大，在Unix/Linux系统下，用fork调用还行，在Windows下创建进程开销巨大。另外，操作系统能同时运行的进程数也是有限的，在内存和CPU的限制下，如果有几千个进程同时运行，操作系统连调度都会成问题。

## 举个栗子
**实例讲解Python中的多线程、多进程如何应对IO密集型任务、计算密集型任务**

这里通过一个实例，说明多线程适合IO密集型任务，多进程适合计算密集型任务。首先定义一个队列，并定义初始化队列的函数：

```Python
import multiprocessing

# 定义全局变量Queue
g_queue = multiprocessing.Queue()

def init_queue():
    print("init g_queue start")
    while not g_queue.empty():
        print(g_queue.get())
    for _index in range(10):
        g_queue.put(_index)
    print("init g_queue end")
    return
```
定义IO密集型任务和计算密集型任务，分别从队列中获取任务数据

```python
# 定义一个IO密集型任务：利用time.sleep()
def task_io(task_id):
    print("IOTask[%s] start" % task_id)
    while not g_queue.empty():
        time.sleep(1)
        try:
            data = g_queue.get(block=True, timeout=1)
            print("IOTask[%s] get data: %s" % (task_id, data))
        except Exception as excep:
            print("IOTask[%s] error: %s" % (task_id, str(excep)))
    print("IOTask[%s] end" % task_id)
    return

g_search_list = list(range(10000))

# 定义一个计算密集型任务：利用一些复杂加减乘除、列表查找等
def task_cpu(task_id):
    print("CPUTask[%s] start" % task_id)
    while not g_queue.empty():
        count = 0
        for i in range(10000):
            count += pow(3*2, 3*2) if i in g_search_list else 0
        try:
            data = g_queue.get(block=True, timeout=1)
            print("CPUTask[%s] get data: %s" % (task_id, data))
        except Exception as excep:
            print("CPUTask[%s] error: %s" % (task_id, str(excep)))
    print("CPUTask[%s] end" % task_id)
    return task_id
```

准备完上述代码之后，进行试验：
```python
if __name__ == '__main__':
    print("cpu count:", multiprocessing.cpu_count(), "\n")

    print("========== 直接执行IO密集型任务 ==========")
    init_queue()
    time_0 = time.time()
    task_io(0)
    print("结束：", time.time() - time_0, "\n")

    print("========== 多线程执行IO密集型任务 ==========")
    init_queue()
    time_0 = time.time()
    thread_list = [threading.Thread(target=task_io, args=(i,)) for i in range(5)]
    for t in thread_list:
        t.start()
    for t in thread_list:
        if t.is_alive():
            t.join()
    print("结束：", time.time() - time_0, "\n")

    print("========== 多进程执行IO密集型任务 ==========")
    init_queue()
    time_0 = time.time()
    process_list = [multiprocessing.Process(target=task_io, args=(i,)) for i in range(multiprocessing.cpu_count())]
    for p in process_list:
        p.start()
    for p in process_list:
        if p.is_alive():
            p.join()
    print("结束：", time.time() - time_0, "\n")

    print("========== 直接执行CPU密集型任务 ==========")
    init_queue()
    time_0 = time.time()
    task_cpu(0)
    print("结束：", time.time() - time_0, "\n")

    print("========== 多线程执行CPU密集型任务 ==========")
    init_queue()
    time_0 = time.time()
    thread_list = [threading.Thread(target=task_cpu, args=(i,)) for i in range(5)]
    for t in thread_list:
        t.start()
    for t in thread_list:
        if t.is_alive():
            t.join()
    print("结束：", time.time() - time_0, "\n")

    print("========== 多进程执行cpu密集型任务 ==========")
    init_queue()
    time_0 = time.time()
    process_list = [multiprocessing.Process(target=task_cpu, args=(i,)) for i in range(multiprocessing.cpu_count())]
    for p in process_list:
        p.start()
    for p in process_list:
        if p.is_alive():
            p.join()
    print("结束：", time.time() - time_0, "\n")

```

结果说明：

**对于IO密集型任务：**

  * 直接执行用时：10.0333秒
  * 多线程执行用时：4.0156秒
  * 多进程执行用时：5.0182秒

说明多线程适合IO密集型任务。

**对于计算密集型任务**  


* 直接执行用时：10.0273秒
* 多线程执行用时：13.247秒
* 多进程执行用时：6.8377秒

说明多进程适合计算密集型任务


## 参考

1. https://zhuanlan.zhihu.com/p/24283040
