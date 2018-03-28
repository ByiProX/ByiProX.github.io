---
title: Differences between `==` and `is` in Python3?---(Reprint)
date: 2018-03-29 02:47:37
tags:
  - Python3
categories:
  - Python3 进阶
---

## Source Question
My [Google-fu](https://english.stackexchange.com/questions/19967/what-does-google-fu-mean) has failed me.

In Python, are the following two tests for equality equivalent?

```Python
n = 5
# Test one.
if n == 5:
    print 'Yay!'

# Test two.
if n is 5:
    print 'Yay!'
```

Does this hold true for objects where you would be comparing instances (a `list` say)?

Okay, so this kind of answers my question:

```python
L = []
L.append(1)
if L == [1]:
    print 'Yay!'
# Holds true, but...

if L is [1]:
    print 'Yay!'
# Doesn't.
```

So `==` tests value where `is` tests to see if they are the same object?

<!-- more -->


## Answers 1

`is` will return `True` if two variables point to the same object, `==` if the objects referred to by the variables are equal.

```python
>>> a = [1, 2, 3]
>>> b = a
>>> b is a
True
>>> b == a
True
>>> b = a[:]
>>> b is a
False
>>> b == a
True
```

In your case, the second test only works `because Python caches small integer objects`, which is an implementation detail. For `larger integers`, this does not work:

```python
>>> 1000 is 10**3
False
>>> 1000 == 10**3
True
```

The same holds true for `string literals`:

```python
>>> "a" is "a"
True
>>> "aa" is "a" * 2
True
>>> x = "a"
>>> "aa" is x * 2
False
>>> "aa" is intern(x*2)
True
```
Please see [this question](https://stackoverflow.com/questions/26595/is-there-any-difference-between-foo-is-none-and-foo-none) as well.










## References

1. [Is there a difference between `==` and `is` in Python?
](https://stackoverflow.com/questions/132988/is-there-a-difference-between-and-is-in-python/134659#134659)
