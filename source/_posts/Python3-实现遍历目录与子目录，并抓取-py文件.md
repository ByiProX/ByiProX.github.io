---
title: Python3 实现遍历目录与子目录，并抓取.py文件
date: 2018-03-12 16:54:54
tags:
  - Python3
categories:
  - Python3 进阶
---

```bash
tree test
.
├── subtest1
│   ├── subsubdir
│   │   └── sub.py
│   └── test1.py
├── subtest2
│   └── test2.py
└── subtest3
    └── test3.py
```
```python
# 1. for-in dir/subdir to get the filesname  
# 2. splitext filename to filter  

import os  

def getFiles(dir, suffix):  

    res = []  
    for root, directory, files in os.walk(dir):  
        for filename in files:  
            name, suf = os.path.splitext(filename)  
            if suf == suffix:  
                res.append(os.path.join(root, filename))  
    return res  

for file in getFiles("./", '.py'):  
    print(file)
# output:
# ./walkdir.py
# ./subtest2/test2.py
# ./subtest3/test3.py
# ./subtest1/test1.py
# ./subtest1/subsubdir/sub.py

```
