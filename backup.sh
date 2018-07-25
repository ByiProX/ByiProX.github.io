rm backup_source_files.tar.gz
tar zcvf backup_source_files.tar.gz ./source/

git add .
git commit -m 'backup source files'
git push

echo "backup finished !"
