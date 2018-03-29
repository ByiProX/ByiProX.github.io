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

## Answers 2

There is a simple rule of thumb to tell you when to use `==` or `is`.

  * `==` is for _value equality_. Use it when you would like to know if two objects have the same value.
  * `is` is for _reference equality_. Use it when you would like to know if two references refer to the same object.

In general, when you are comparing something to a simple type, you are usually checking for _value equality_, so you should use `==`. For example, the intention of your example is probably to check whether x has a value equal to 2 (`==`), not whether `x` is literally referring to the same object as 2.


Something else to note: because of the way the CPython reference implementation works, you'll get unexpected and inconsistent results if you mistakenly use `is` to compare for reference equality on integers:

```python
>>> a = 500
>>> b = 500
>>> a == b
True
>>> a is b
False
```

That's pretty much what we expected: `a` and `b` have the same value, but are distinct entities. But what about this?

```python
>>> c = 200
>>> d = 200
>>> c == d
True
>>> c is d
True
```

This is inconsistent with the earlier result. What's going on here? It turns out the reference implementation of Python caches integer objects in the range -5..256 as singleton instances for performance reasons. Here's an example demonstrating this:

```python
>>> for i in range(250, 260): a = i; print "%i: %s" % (i, a is int(str(i)));
...
250: True
251: True
252: True
253: True
254: True
255: True
256: True
257: False
258: False
259: False
```

This is another obvious reason not to use `is`: the behavior is left up to implementations when you're erroneously using it for value equality.


## References

1. [Is there a difference between `==` and `is` in Python?
](https://stackoverflow.com/questions/132988/is-there-a-difference-between-and-is-in-python/134659#134659)
