@echo off
title=һ������MySQL 5.5.30 winx64
color 8B
echo ��ʼ����MySQL 5.5.30 winx64  by ��ʥ��
echo ������ʾ����һ������ʱ����ʼ��MASTER��SLAVE���Ժ��������

echo.
echo ======================= [master] ��װMYSQLD   =======================
choice /C YC /T 3 /D Y /M "Yȷ����Cȡ����N������3����Զ�ִ�а�װ��"
if errorlevel 3 goto skip
if errorlevel 2 goto cancel
if errorlevel 1 goto mastermysqld
goto cancel
:mastermysqld
start ${Windows��ʽMySQL��װ��·��}\bin\mysqld.exe --defaults-file=${Linux��ʽMySQL��������·��}/master/mysqld_conf/mysqld.ini --console

:skip
echo.
echo ======================= [slave] ��װMYSQLD    =======================
choice /C YC /T 60 /D Y /M "Yȷ����Cȡ����N������60����Զ�ִ�а�װ��"
if errorlevel 3 goto master
if errorlevel 2 goto cancel
if errorlevel 1 goto slavemysqld
goto cancel
:slavemysqld
start ${Windows��ʽMySQL��װ��·��}\bin\mysqld.exe --defaults-file=${Linux��ʽMySQL��������·��}/slave/mysqld_conf/mysqld.ini --console

echo.
echo ======================= [master] ��ʼ��MASTER ========================
choice /C YKO /M "Y������K������O������"
if errorlevel 3 goto ok
if errorlevel 2 goto status
if errorlevel 1 goto initmaster
goto cancel
:initmaster
${Windows��ʽMySQL��װ��·��}\bin\mysql.exe -h 127.0.0.1 -P 3312 -u root -D test < ./master/master-init.sql

echo.
echo ======================= [slave] ��ʼ��SLAVE   ========================
choice /C YKO /M "Y������K������O������"
if errorlevel 3 goto ok
if errorlevel 2 goto status
if errorlevel 1 goto initslave
goto cancel
:initslave
${Windows��ʽMySQL��װ��·��}\bin\mysql.exe -h 127.0.0.1 -P 3313 -u root -D test < ./slave/slave-init.sql

:status
echo.
echo ======================= [master] MASTER״̬   ========================
${Windows��ʽMySQL��װ��·��}\bin\mysql.exe -h 127.0.0.1 -P 3312 -u slave --password=pass01! < ./master/master-status.sql

echo.
echo ======================= [slave] SLAVE״̬     ========================
${Windows��ʽMySQL��װ��·��}\bin\mysql.exe -h 127.0.0.1 -P 3313 -u slave --password=pass01! < ./slave/slave-status.sql

:master
echo.
echo ======================= [master] ����MYSQL    ========================
choice /C YMO /M "Y������M�л����ӻ���O������"
if errorlevel 3 goto ok
if errorlevel 2 goto slave
if errorlevel 1 goto mastermysql
goto cancel
:mastermysql
start ${Windows��ʽMySQL��װ��·��}\bin\mysql.exe -h 127.0.0.1 -P 3312 -u root -D test

:slave
echo.
echo ======================= [slave] ����MYSQL     ========================
choice /C YSO /M "Y������S�л���������O������"
if errorlevel 3 goto ok
if errorlevel 2 goto master
if errorlevel 1 goto slavemysql
goto cancel
:slavemysql
start ${Windows��ʽMySQL��װ��·��}\bin\mysql.exe -h 127.0.0.1 -P 3313 -u root -D test
goto master

:cancel
echo.
echo ǿ����ֹ����

:ok
echo.
echo MySQL 5.5.30 winx64�������
@pause