---
title: What is the difference between “ is None ” and “ ==None ” --- Reprint
date: 2018-03-29 03:08:51
tags:
  - Python3
categories:
  - Python3 进阶
---
## Answer 1
The answer is explained [here](http://jaredgrubb.blogspot.com/2009/04/python-is-none-vs-none.html).

To quote:

> A class is free to implement comparison any way it chooses, and it can choose to make comparison against None mean something (which actually makes sense; if someone told you to implement the None object from scratch, how else would you get it to compare True against itself?).

Practically-speaking, there is not much difference since custom comparison operators are rare. But you should use `is None` as a general rule.

`is None` is a bit (~50%) faster than `== None` :) – [Nas Banov](https://stackoverflow.com/users/226086/nas-banov)

<!-- more -->
## Answer 2
`is` always returns `True` if it compares the same object instance

Whereas `==` is ultimately determined by the `__eq__()` method

i.e.

```python
class Foo:
    def __eq__(self,other):
        return True
foo=Foo()

print(foo==None)
# True

print(foo is None)
# False
```

## Answer 3
In this case, they are the same. `None` is a singleton object (there only ever exists one `None`).

`is` checks to see if the object is the same object, while == just checks if they are equivalent.

For example:
```Python
p = [1]
q = [1]
p is q # False because they are not the same actual object
p == q # True because they are equivalent

```
But since there is only one `None`, they will always be the same, and `is` will return True.

```Python
p = None
q = None
p is q # True because they are both pointing to the same "None"
```

## Answer 4
`(ob1 is ob2)` equal to `(id(ob1) == id(ob2))`

... but (ob is ob2) is a LOT faster. Timeit says "(a is b)" is 0.0365 usec per loop and "(id(a)==id(b))" is 0.153 usec per loop. 4.2x faster! – [AKX](https://stackoverflow.com/users/51685/akx)

`{} is {}` is false and `id({}) == id({})` can be (and **is** in CPython) true.


## Reference

1. [What is the difference between “ is None ” and “ ==None ”](https://stackoverflow.com/questions/3257919/what-is-the-difference-between-is-none-and-none)
2. [Is there any difference between “foo is None” and “foo == None”?](https://stackoverflow.com/questions/26595/is-there-any-difference-between-foo-is-none-and-foo-none)
