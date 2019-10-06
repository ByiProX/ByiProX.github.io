---
title: 浅析Python中列表操作之*和*=
date: 2019-10-07 00:42:03
tags:
  - Python3
  - Python源码
categories:
  - Python3 进阶
---

初学Python时总是会将a*=n理解为a=a*n，稍微深入后就会知道在Python中的不同，其中*调用__mul__ ，而*=调用__imul__ 。

对于list对象也支持乘法操作，截止到Python3.7版本，上述仍然是成立的。我们知道list是由C实现的，所以真正的底层调用肯定是C的实现。观察list对象的C实现的源码我们会知道乘法*操作调用list_repeat，*=会调用list_inplace_repeat，下面分别看一下两者的C实现方式。初学Python时总是会将a*=n理解为a=a*n，稍微深入后就会知道在Python中的不同，其中*调用__mul__ ，而*=调用__imul__ 。

### ▍* --> list_repeat
```c
static PyObject *
list_repeat(PyListObject *a, Py_ssize_t n)
{
    ...
    size = Py_SIZE(a) * n;
    if (size == 0)
        return PyList_New(0);
    np = (PyListObject *) list_new_prealloc(size);
    ...
    return (PyObject *) np;
}
从以上可以看出，list_repeat方法需要多少空间就申请多少空间，该操作返回的一个新的列表对象。
```

### ▍*= --> list_inplace_repeat
```c
static PyObject *
list_inplace_repeat(PyListObject *self, Py_ssize_t n)
{
    ...
    size = PyList_GET_SIZE(self);
    if (list_resize(self, size*n) < 0)
        return NULL;
    ...
}

static int
list_resize(PyListObject *self, Py_ssize_t newsize)
{
    if (allocated >= newsize && newsize >= (allocated >> 1)) {
        assert(self->ob_item != NULL || newsize == 0);
        Py_SIZE(self) = newsize;
        return 0;
    }
    ...
    new_allocated = (size_t)newsize + (newsize >> 3) + (newsize < 9 ? 3 : 6);
    ...
}
```
list_inplace_repeat代码中通过调用list_resize来进行扩容，并告诉它这个列表需要容纳size*n个元素。从list_resize代码来看，当allocated空间足够时，不会进行扩容操作。但是新申请的空间总是比所需要的大的。如果进行pop等减小list元素数量的操作来看，实际上列表的大小也会按照相应策略进行缩减操作。

>If the newsize falls lower than half the allocated size, then proceed with the realloc() to shrink the list. --- From cpython

### ▍总结

1. *=会调用list_resize，可能会引起list空间扩容的情况，而且此时list对象占用空间会比实际list对象中元素占用空间大。
2. *会按需获取申请空间大小，不会调用list_resize方法。
