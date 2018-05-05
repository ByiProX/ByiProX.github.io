---
title: 终端格式化打印json数据的方法
date: 2018-04-25 11:26:54
tags:
  - Linux/Mac OS
categories:
  - Linux/Mac OS
---
命令行调试API很方便，对于返回数据是JSON格式的，打印出来的内容超级痛苦。有一种解决方法如下：
```bash
echo '{"status":200,"data":[{"id":1000,"name":"John"},{"id":1004,"name":"Tom"}]}' | python -m json.tool
```

即终端打印的json数据通过管道符号经过python json工具格式化输出，搞定!
