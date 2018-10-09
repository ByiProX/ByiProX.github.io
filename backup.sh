rm backup_source_files.tar.gz
tar zcvf backup_source_files.tar.gz ./source/ ./themes ./node_modules _config.yml ./public ./scaffolds ./package* ./README.md

git add .
git commit -m 'backup source files'
git push origin master:Hexo-Blog-Backup

echo "backup finished !"
