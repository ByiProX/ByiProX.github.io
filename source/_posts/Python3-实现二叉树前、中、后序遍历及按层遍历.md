---
title: Python3 实现二叉树前、中、后序遍历及按层遍历
date: 2018-03-15 23:57:26
tags:
  - Python3
  - Algorithm
  - Data Structures
categories:
  - Data Structures
---
假设有这么一个二叉树如下：
![二叉树.png](https://upload-images.jianshu.io/upload_images/2952111-707a1e95da262138.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

前序遍历结果：1, 2, 4, 5, 8, 9, 11, 3, 6, 7, 10
中序遍历结果：4, 2, 8, 5, 11, 9, 1, 6, 3, 10, 7
后序遍历结果：4, 8, 11, 9, 5, 2, 6, 10, 7, 3, 1

## 二叉树的类实现
```python
class Node(object):
    def __init__(self, value=None, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right

if __name__ == "__main__":
    tree = Node(1, Node(2, Node(4),
                           Node(5, Node(8),
                                   Node(9, left=Node(11)))),
                   Node(3, Node(6),
                           Node(7, left=Node(10))))
```
<!-- more -->
## 深度优先遍历
### 递归法

```python
# 前序遍历（递归）
def pre_deep_func(root):
    if root is None:
        return
    print(root.value, end = ' ')  # print 放到下一行 就是中序遍历，放到最后 就是后序遍历
    pre_deep_func(root.left)
    pre_deep_func(root.right)

```

### 非递归法
#### 前序遍历
根据已有的认识，此函数需要一个栈，保存树尚未访问过的部分信息。对于前序遍历也会有不同的实现方法，下面考虑一种方法，即：
1. 由于采取先序遍历，遇到结点就应该访问，下一步就应该沿着树的坐分支下行
2. 但结点的右分支（右子树）还没有访问，因此需要记录，将右子结点入栈。
3. 遇到空树时回溯，取出栈中保存的一个右分支，像一颗二叉树一样遍历它。


```python
## 方法一 常规打印
def preorder_nonrec(root):
    s = []
    while s or root:
        while root:  # 沿左分支下行
            print(root.value, end = ' ')  # 先处理根数据
            s.append(root.right)          # 右分支入栈
            root = root.left
        root = s.pop()                    #  遇到空树，回溯

## 方法二 通过生成器函数遍历
def preorder_elements(root):
    s = []
    while s or root:
        while root:
            s.append(root.right)
            yield root.value
            root = root.left
        root = s.pop()

## 方法三
# 前序遍历（根左右）:模拟压栈过程
# 入栈之前读（根、左），这样出栈时再读右（也是右结点子节点们的根）
def pre_deep_func2(root):
    a = []
    while a or root:
        while root:
            print(root.value, end = ' ')
            a.append(root)  ## 根入栈
            root = root.left
        h = a.pop()
        root = h.right

```

非递归算法的一个价值是把算法过程完整的暴露出来，便于进行细致的分析。
时间复杂度：在非递归的算法中，因为在执行的过程中访问每个结点一次，一部分子树(所有右子树，方法一、二)被压入和弹出各一次(栈操作是O(1)时间)，所以整个遍历过程需要的时间复杂度为O(n)。
空间复杂度：这里的关键因素是遍历中栈可能达到的最大深度（栈中元素的最大深度个数），而栈的最大深度由被遍历的二叉树的高度决定。由于二叉树的高度可能达到O(n)，所以在最坏情况下，算法的空间复杂度为O(n)，n个结点的二叉树的平均高度为O(log n)，所以非递归前序遍历的平均空间复杂度为O(log n)。
在一些情况下，修改实现方法也可能降低空间的开销。对于上面函数，修改其定义，只把非空的右子树进栈，在很多情况下能减小一些空间开销。

其他非递归的遍历算法，包括中序遍历和后续遍历算法以及层次遍历算法，都可以直接了当的修改成迭代器。但是递归算法不可以。

#### 中序遍历
```python
# 中序遍历（左根右）:模拟压栈过程
# 出栈之后读（左、根），这样出栈后指针变更再读右
def mid_deep_func2(root):
    a = []
    while a or root:
        while root:
            a.append(root)
            root = root.left
        h = a.pop()
        print h.value
        root = h.right
```

#### 后序遍历
```python
# 后序遍历（左右根）:模拟逆序(根右左)存入数组b，然后再数组b逆序输出
# (根右左)与(根左右)类似，入栈a前读（根、右），出栈后指针变更再读左
## 方法 1
def after_deep_func2(root):
    a = []
    b = []
    while a or root:
        while root:
            b.append(root.value)
            a.append(root.left)
            root = root.right
        root = a.pop()
    print(b[::-1])

## 方法2
def after_deep_func2(root):
    a = []
    b = []
    while a or root:
        while root:
            b.append(root.value)
            a.append(root)
            root = root.right
        h = a.pop()
        root = h.left
    print b[::-1]
```

## 广度优先遍历
```python
def level_func(root):
    a = []
    a.append(root)
    while a:
        head = a.pop(0)
        print head.value
        if head.left:
            a.append(head.left)
        if head.right:
            a.append(head.right)

```



## 参考

1. http://blog.csdn.net/su92chen/article/details/70242822
2. 《数据结构与算法Python语言描述》 --- 裘宗燕
