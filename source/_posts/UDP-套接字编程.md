---
title: UDP 套接字编程
date: 2018-07-25 19:31:29
tags:
  - 网络
categories:
  - 网络
---

![Screen Shot 2018-07-25 at 19.54.43.png](https://upload-images.jianshu.io/upload_images/2952111-0d1e97d91078ff77.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<!-- more -->

## UDPClient.py
```python
from socket import *

# serverName = '140.143.38.125'
serverName = 'server.kunxiang.wang'
serverPort = 12000

clientSocket = socket(AF_INET, SOCK_DGRAM)

msg = input('please input lowercase sentence: ').encode()
clientSocket.sendto(msg, (serverName, serverPort))

modifiedMsg, serverAddress = clientSocket.recvfrom(2048)

print(modifiedMsg, serverAddress, end='\n')

clientSocket.close()
```


## UDPServer.py
```python
from socket import *
serverPort = 12000
serverSocket = socket(AF_INET, SOCK_DGRAM)
serverSocket.bind(('', serverPort))
print('The server is ready to receive')
while True:
    message, clientAddress = serverSocket.recvfrom(2048)
    print(message)
    print(clientAddress)
    modifiedMessage = message.upper()
    serverSocket.sendto(modifiedMessage, clientAddress)

```

![Screen Shot 2018-07-25 at 19.55.29.png](https://upload-images.jianshu.io/upload_images/2952111-016af56091643bbc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)