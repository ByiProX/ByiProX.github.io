---
title: TCP 套接字编程
date: 2018-07-25 20:50:59
tags:
  - 网络
categories:
  - 网络
---


![Screen Shot 2018-07-25 at 19.55.29.png](https://upload-images.jianshu.io/upload_images/2952111-016af56091643bbc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<!-- more -->


## TCPClient.py
```python
from socket import *

serverName = 'server.kunxiang.wang'
serverPort = 12000

clientSocket = socket(AF_INET, SOCK_STREAM)

# 如果不绑定客户端进程端口，则自动选择端口
clientSocket.bind(('', 34567))

clientSocket.connect((serverName, serverPort))

msg = input('please input lowercase sentence: ').encode()

clientSocket.send(msg)

modifiedMsg = clientSocket.recv(2048)

print(modifiedMsg)


clientSocket.close()
```

## TCPServer.py
```python
from socket import *

serverPort = 12000

serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('', serverPort))
serverSocket.listen(1)

print('the server is ready to receive')

while True:
    connectionSocket, clientAddress = serverSocket.accept()
    print(connectionSocket, clientAddress)

    msg = connectionSocket.recv(1024)
    print(msg)

    modifiedMsg = msg.upper()
    connectionSocket.send(modifiedMsg)
    connectionSocket.close()

```