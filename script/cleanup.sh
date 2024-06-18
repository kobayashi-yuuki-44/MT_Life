find log/*.log -mtime +2 -exec rm {} \;
find tmp/* -mtime +2 -exec rm -r {} \;
find public/assets -mtime +2 -exec rm -r {} \;