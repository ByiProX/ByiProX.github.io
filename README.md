该博客项目
由 [Hexo](https://hexo.io/) 强力驱动 | 主题 — [NexT.Gemini](https://github.com/iissnan/hexo-theme-next) v5.1.4

项目有两个分支，其中：
> master 分支用于部署博客内容，用于对外展示

> Hexo-Blog 分支用于备份整个Hexo项目源代码


博客的发布以及备份时在master分支下操作，举个说明。。。

- 如若发布文章，在master分支下hexo new 'python知识点'，然后对生成的文章进行编辑

- 编辑完成后，可以先备份再部署，也可以先部署再备份

- 部署操作即按照hexo clean --- hexo generate --- hexo deploy的步骤进行，此时应处于master分支下

- 备份时也要在master分支下，按照git add . --- git commit -m 'blablabla' --- git push origin master:Hexo-Blog


git push origin master:Hexo-Blog含义为将本地的master分支上传到远程的Hexo-Blog分支
