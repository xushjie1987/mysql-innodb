@echo off
title=一键部署MySQL 5.5.30 winx64
color 8B
echo 开始部署MySQL 5.5.30 winx64  by 徐圣杰
echo 友情提示：第一次启动时，初始化MASTER和SLAVE，以后务必跳过

echo.
echo ======================= [master] 安装MYSQLD   =======================
choice /C YC /T 3 /D Y /M "Y确定，C取消，N跳过，3秒后自动执行安装。"
if errorlevel 3 goto skip
if errorlevel 2 goto cancel
if errorlevel 1 goto mastermysqld
goto cancel
:mastermysqld
start ${Windows格式MySQL安装根路径}\bin\mysqld.exe --defaults-file=${Linux格式MySQL启动配置路径}/master/mysqld_conf/mysqld.ini --console

:skip
echo.
echo ======================= [slave] 安装MYSQLD    =======================
choice /C YC /T 60 /D Y /M "Y确定，C取消，N跳过，60秒后自动执行安装。"
if errorlevel 3 goto master
if errorlevel 2 goto cancel
if errorlevel 1 goto slavemysqld
goto cancel
:slavemysqld
start ${Windows格式MySQL安装根路径}\bin\mysqld.exe --defaults-file=${Linux格式MySQL启动配置路径}/slave/mysqld_conf/mysqld.ini --console

echo.
echo ======================= [master] 初始化MASTER ========================
choice /C YKO /M "Y启动，K跳过，O结束。"
if errorlevel 3 goto ok
if errorlevel 2 goto status
if errorlevel 1 goto initmaster
goto cancel
:initmaster
${Windows格式MySQL安装根路径}\bin\mysql.exe -h 127.0.0.1 -P 3312 -u root -D test < ./master/master-init.sql

echo.
echo ======================= [slave] 初始化SLAVE   ========================
choice /C YKO /M "Y启动，K跳过，O结束。"
if errorlevel 3 goto ok
if errorlevel 2 goto status
if errorlevel 1 goto initslave
goto cancel
:initslave
${Windows格式MySQL安装根路径}\bin\mysql.exe -h 127.0.0.1 -P 3313 -u root -D test < ./slave/slave-init.sql

:status
echo.
echo ======================= [master] MASTER状态   ========================
${Windows格式MySQL安装根路径}\bin\mysql.exe -h 127.0.0.1 -P 3312 -u slave --password=pass01! < ./master/master-status.sql

echo.
echo ======================= [slave] SLAVE状态     ========================
${Windows格式MySQL安装根路径}\bin\mysql.exe -h 127.0.0.1 -P 3313 -u slave --password=pass01! < ./slave/slave-status.sql

:master
echo.
echo ======================= [master] 启动MYSQL    ========================
choice /C YMO /M "Y启动，M切换到从机，O结束。"
if errorlevel 3 goto ok
if errorlevel 2 goto slave
if errorlevel 1 goto mastermysql
goto cancel
:mastermysql
start ${Windows格式MySQL安装根路径}\bin\mysql.exe -h 127.0.0.1 -P 3312 -u root -D test

:slave
echo.
echo ======================= [slave] 启动MYSQL     ========================
choice /C YSO /M "Y启动，S切换到主机，O结束。"
if errorlevel 3 goto ok
if errorlevel 2 goto master
if errorlevel 1 goto slavemysql
goto cancel
:slavemysql
start ${Windows格式MySQL安装根路径}\bin\mysql.exe -h 127.0.0.1 -P 3313 -u root -D test
goto master

:cancel
echo.
echo 强制终止部署

:ok
echo.
echo MySQL 5.5.30 winx64部署完成
@pause