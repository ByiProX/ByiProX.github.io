---
title: Github多分支管理Hexo-Blog项目
date: 2018-02-27 00:23:41
tags:
  - Hexo
  - Git
categories:
  - Hexo
---

Hexo在部署之后在github的仓库中我们只能找到生成的静态文件。然而博客的源文件：主题、文章、配置等文件都还在本地，并没有备份。对于多台终端设备的用户不够友好，而且存在一定的风险，万一那天电脑坏了或者是出现一些其他问题，就得从头再来。为了解决上述问题，我们可以利用github的分支思想来备份我们的源文件。

备份之前，需要了解博客根目录下面的文件以及文件夹作用：
```python
.deploy_git/        网站静态文件(git)
node_modules/       插件
public/             网站静态文件
scaffolds/          文章模板
source/             博文等
themes/             主题
_config.yml         网站配置文件
package.json        Hexo信息
db.json             数据文件
```
## 备份的思路
`master分支存放部署生成的静态文件，Hexo-Bog分支存放我们要备份项目源文件。`实际备份中，.deploy_git、public文件夹和我们的master分支内容重复，所以略过。因此，我们在根目录下面建一个**.gitignore**文件来建立“黑名单”，禁止备份。

## 编辑**.gitignore**过滤文件
文件内容如下：
```python
.DS_Store
public/
.deploy*/
```
## 关于备份
终端中在项目的根目录下执行，对于作者自己的项目，命令执行的路径为ByiProX/下：
```Bash
$ git init
$ git remote add origin git@github.com:username/username.github.io.git		
# username为博客项目的名称，也就是git的用户名
$ git add .
$ git commit -m "ready for backup of the project"
$ git push origin master:Hexo-Blog
```

执行完毕后会发现github博客仓库已经有了一个新分支Hexo-Blog，于是备份工作完成。
以后，开始写博文时，即终端运行
```Bash
$ hexo new [layout] <title>
```
完成文章后,对编辑后的文章进行备份保存，即终端运行,为下面的部署做准备
```Bash
    $ git add .
    $ git commit -m "add one article"
    $ git push origin master:Hexo-Blog
```

## 部署
运行一下命令进行仓库master分支静态文件部署
```Bash
$ hexo clean
$ hexo generate
$ hexo deploy
```

以上完成项目源文件以及静态文件的Git管理

## 参考文献及进阶
[Hexo+github搭建个人博客并实现多终端管理](https://mrlrf.github.io/2017/05/05/Hexo-github%E6%90%AD%E5%BB%BA%E5%8D%9A%E5%AE%A2/)
[如何在github上面备份Hexo](https://blog.zaihua.me/post/blog_github_backup.html)
[Hexo的版本控制与持续集成](https://formulahendry.github.io/2016/12/04/hexo-ci/)
[使用hexo，如果换了电脑怎么更新博客](https://www.zhihu.com/question/21193762)
