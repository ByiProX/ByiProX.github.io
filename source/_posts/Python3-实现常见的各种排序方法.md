---
title: Python3 实现常见的各种排序方法
date: 2018-03-09 15:56:09
tags:
  - Python3
  - Algorithm
  - Data Structures
categories:
  - Algorithm
---


## 冒泡排序

冒泡排序原理即：从数组下标为0的位置开始，比较下标位置为0和1的数据，如果0号位置的大，则交换位置，如果1号位置大，则什么也不做，然后右移一个位置，比较1号和2号的数据，和刚才的一样，如果1号的大，则交换位置，以此类推直至最后一个位置结束，到此数组中最大的元素就被排到了最后，之后再根据之前的步骤开始排前面的数据，直至全部数据都排序完成。

就是传说中的大的沉到底原则，适用于小量数据

冒泡排序思路: 每一趟只能将一个数归位, 如果有n个数进行排序,只需将n-1个数归位, 也就是说要进行n-1趟操作(已经归位的数不用再比较)

缺点: 冒泡排序解决了桶排序浪费空间的问题, 但是冒泡排序的效率特别低
![冒泡排序](http://upload-images.jianshu.io/upload_images/2952111-020fcd7b86279da7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<!-- more -->
```Python
def bubbleSort(relist):
    """冒泡排序"""
    len_ = len(relist)
    for i in range(len_ - 1):  # 这个循环负责设置冒泡排序进行的次数
        for j in range(0,len_-i-1):
            if relist[j] > relist[j+1]:
                relist[j+1], relist[j] = relist[j], relist[j+1]
    return relist

print(bubbleSort([1,5,2,6,9,3]))
```
![冒泡排序](http://upload-images.jianshu.io/upload_images/2952111-e421e0f31170cb93.gif?imageMogr2/auto-orient/strip)

由上图看出最大的数一直沉到底部


## 选择排序

选择排序基本原理：
1. 第1趟，在待排序记录r1 ~ r[n]中选出最小的记录，将它与r1交换；
2. 第2趟，在待排序记录r2 ~ r[n]中选出最小的记录，将它与r2交换；
3. 以此类推，第i趟在待排序记录r[i] ~ r[n]中选出最小的记录，将它与r[i]交换，使有序序列不断增长直到全部排序完毕。

```Python
# 方法一
def selectSort(relist):
    len_ = len(relist)
    for i in range(len_):
        min_index = i
        for j in range(i+1,len_):  # 这个循环会找到值比第i个索引所代表值小的索引
            if relist[j] < relist[min_index]:
                min_index = j
        relist[i] ,relist[min_index] = relist[min_index], relist[i]  # 互换两个索引位置
    return relist

print selectSort([1,5,2,6,9,3])

# 方法二
def findSmallest(arr):
    smallest = arr[0]
    smallest_index = 0
    for i in range(1, len(arr)):
        if arr[i] < smallest:
            smallest = arr[i]
            smallest_index = i
    return smallest_index

def selectionSort(arr):
    newArr = []
    for i in range(len(arr)):
        smallest = findSmallest(arr)
        newArr.append(arr.pop(smallest))
    return newArr

print(selectionSort([5,3,7,2,1,8]))
```

![选择排序](http://upload-images.jianshu.io/upload_images/2952111-3b59aac6b772ddf0.gif?imageMogr2/auto-orient/strip)


## 归并排序

`所谓归并是指将若干个已排好序的部分合并成一个有序的部分。`

假设我们有一个没有排好序的序列(14,12,15,13,11,16)，那么首先我们使用分割的办法将这个序列分割成一个个已经排好序的子序列。然后再利用归并的方法将一个个的子序列合并成排序好的序列。分割和归并的过程可以看下面的图例。这样通过先递归的分解数列，再合并数列就完成了归并排序。

![MergeSort.jpg](https://upload-images.jianshu.io/upload_images/2952111-b7ca2aad908df253.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```Python
import math
def merge(left, right):
    result = []
    while left and right:
        result.append(left.pop(0) if left[0] <= right[0] else right.pop(0))
    while left:
        result.append(left.pop(0))
    while right:
        result.append(right.pop(0))

    return result

def mergeSort(relist):
    if len(relist) <= 1:
        return relist
    mid_index = math.floor(len(relist)/2)
    left = mergeSort(relist[:mid_index])  # 递归拆解的过程
    right = mergeSort(relist[mid_index:])
    return merge(left, right)  # 合并的过程

print(mergeSort([1,5,2,6,9,3]))

```
![归并排序](https://upload-images.jianshu.io/upload_images/2952111-8ee3d2a2a81eab80.gif?imageMogr2/auto-orient/strip)

## 快速排序
快速排序的思路：
1. 先从数列中取出一个数作为基准数。
2. 分区过程，将比这个数大的数全放到它的右边，小于或等于它的数全放到它的左边(假定从小到大排序)。
3. 再对左右区间重复第二步，直到各区间只有一个数

```Python
def quicksort(array):
    """快速排序"""
    if len(array) < 2:  # 基线条件：为空或者只有一个元素的数组是有序的
        return array
    else:
        pivot = array[0]  # 递归条件,基准值
        less = [i for i in array[1:] if i <= pivot]  # 所有小于基准值的元素组成的子数组
        greater = [i for i in array[1:] if i > pivot]  # 所有大于基准值的元素组成的子数组
        return quicksort(less) + [pivot] + quicksort(greater)

print(quicksort([1,2,7,4,2,9,3]))
```

![快速排序](http://upload-images.jianshu.io/upload_images/2952111-d52e0c914f7272a4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![20170801013540271.gif](http://upload-images.jianshu.io/upload_images/2952111-03cf1024e51c6dee.gif?imageMogr2/auto-orient/strip)


## 堆排序

1. 创建最大堆:将堆所有数据重新排序，使其成为最大堆
2. 最大堆调整:作用是保持最大堆的性质，是创建最大堆的核心子程序
3. 堆排序:移除位在第一个数据的根节点，并做最大堆调整的递归运算

![堆排序.png](https://upload-images.jianshu.io/upload_images/2952111-5903c9ca1e9a0473.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```Python
# code from -http://blog.csdn.net/minxihou/article/details/51850001
import random

def MAX_Heapify(heap,HeapSize,root):#在堆中做结构调整使得父节点的值大于子节点

    left = 2*root + 1
    right = left + 1
    larger = root
    if left < HeapSize and heap[larger] < heap[left]:
        larger = left
    if right < HeapSize and heap[larger] < heap[right]:
        larger = right
    if larger != root:#如果做了堆调整则larger的值等于左节点或者右节点的，这个时候做对调值操作
        heap[larger],heap[root] = heap[root],heap[larger]
        MAX_Heapify(heap, HeapSize, larger)

def Build_MAX_Heap(heap):#构造一个堆，将堆中所有数据重新排序
    HeapSize = len(heap)#将堆的长度当独拿出来方便
    for i in range((HeapSize -2)//2,-1,-1):#从后往前出数
        MAX_Heapify(heap,HeapSize,i)

def HeapSort(heap):#将根节点取出与最后一位做对调，对前面len-1个节点继续进行对调整过程。
    Build_MAX_Heap(heap)
    for i in range(len(heap)-1,-1,-1):
        heap[0],heap[i] = heap[i],heap[0]
        MAX_Heapify(heap, i, 0)
    return heap

if __name__ == '__main__':
    a = [30,50,57,77,62,78,94,80,84]
    print(a)
    HeapSort(a)
    print(a)
    b = [random.randint(1,1000) for i in range(1000)]
    #print b
    HeapSort(b)
    print(b)


```
![堆排序.gif](https://upload-images.jianshu.io/upload_images/2952111-d80509464c38434d.gif?imageMogr2/auto-orient/strip)

## 复杂度


| 排序法 | 最差时间 | 平均时间复杂度 |稳定度|空间复杂度|
| :--- | :------- | :------ |:------ |:------ |
| 冒泡排序 | O(n^2) | O(n^2) |稳定|O(1)|
| 选择排序 | O(n^2) | O(n^2) |不稳定|O(1)|
| 插入排序 | O(n^2) | O(n^2) |稳定|O(1)|
| 希尔排序 | O      | O           |不稳定|O(1)|
| 归并排序 | O(n*log n)| O(n*log n) |稳定|?|
| 快速排序 | O(n^2) | O(n*log n) |不稳定|O(log2n)~O(n)|
| 二叉树排序 | O(n^2) | O(n*log n) |不一定|O(n)|
| 堆排序 | O(n*log n) | O(n*log n) |不稳定|O(1)|

>Ps:算法第四版179页,还没有人证明`希尔排序`对随机数据的运行时间是线性代数级别

## 参考
1. http://blog.csdn.net/mrlevo520/article/details/77829204
2. http://blog.csdn.net/minxihou/article/details/51850001
