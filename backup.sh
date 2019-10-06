rm backup_source_files.tar.gz
tar zcvf backup_source_files.tar.gz ./source/_posts/  ./README.md

git add .
git commit -m 'backup markdown files'
git push origin master:Hexo-Blog-Backup

echo "backup finished !"
