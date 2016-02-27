@echo off
start ${Windows格式MySQL安装根路径}\bin\mysqladmin.exe -h 127.0.0.1 -P 3313 -u root shutdown

start ${Windows格式MySQL安装根路径}\bin\mysqladmin.exe -h 127.0.0.1 -P 3312 -u root shutdown