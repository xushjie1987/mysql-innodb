@echo off
start ${Windows格式MySQL安装根路径}\bin\mysqld.exe --defaults-file=${Linux格式MySQL启动配置路径}/master/mysqld_conf/mysqld.ini --console

start ${Windows格式MySQL安装根路径}\bin\mysqld.exe --defaults-file=${Linux格式MySQL启动配置路径}/slave/mysqld_conf/mysqld.ini --console