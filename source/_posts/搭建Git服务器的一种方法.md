---
title: 搭建Git服务器的一种方法
date: 2019-02-11 13:43:13
tags:
  - Git
  - Github
categories:
  - Git
---

### 1. 确保自己的服务器上安装有Git和ssh
```bash
yum install ssh
yum install git
```

### 2. 配置git用户
#### 新建git用户
主要是为了让大家在上传代码时登录使用，一般使用：git
```bash
adduser git
```

<!-- more -->
#### 配置git用户的ssh登录
```bash
cd /home/git    //进入git用户文件夹
sudo mkdir .ssh    //创建 .ssh 文件夹
sudo touch .ssh/authorized_keys    //创建authorized_keys文件，用以保存公钥
```
`authorized_keys` 是公钥保存文件，`客户端的私钥`与`服务器的公钥`配对成功，则可以登录。`之后将需要使用这个git服务器的成员的公钥复制粘贴到这个文件中（每个占一行）`。

客户端电脑进入 /users/用户名/.ssh 文件夹，如果已经有自己的秘钥，直接打开 `pub` 文件，复制里面的公钥信息，进入服务器，粘贴到 authorized_keys 文件中，如果没有，使用`ssh-keygen`命令生成后复制粘贴即可。

### 3. 初始化裸仓库来保存项目
在`/home/git`下
```bash
sudo mkdir repos    //创建repos文件夹，用于保存git仓库，名字随各人喜好，这里使用repos
cd repos    //进入repos文件夹
sudo git init --bare sample.git    //创建一个裸仓库，名字按自己需要选择，这里使用sample
```
repos文件夹中会创建 sample.git 文件夹。那么，剩下的事情，就是将本地代码上传到服务器的仓库中。

1. 如果本地没有初始代码，可以直接从服务器克隆仓库到本地：
```bash
git clone git@server:repos/sample.git
```

 git@server是登录服务器使用的用户名（git）和IP地址（server），登录之后有默认进入用户文件夹（/home/git），后面的路径就是用户文件夹下的仓库路径，也就是 repos/sample.git 。

2. 如果本地有一些初始代码，需要直接同步到服务器的仓库，可以进入本地代码文件夹，创建并将代码保存到git仓库后同步至服务器仓库：
```bash
git init    //创建git仓库
git add .    //添加所有文件
git commit -m "your remark"    //将代码提交到本地仓库
git remote add origin git@server:repos/sample.git    //添加远程仓库地址
git push --set-upstream origin master    //将代码上传到远程仓库并把本地上传的代码设为master分支
```

有时会出现git远程仓库配置写错的情况，或者需要修改远程仓库，可以使用以下命令删除原有的远程仓库配置后重新配置：
```bash
git remote rm origin
```









------
