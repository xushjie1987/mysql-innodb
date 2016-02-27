-- 控制以下SQL语句不写入bin log
SET sql_log_bin=0;

-- 创建一个主库的用户，slave从库使用此账户连接到主库
CREATE USER 'slave'@'%' IDENTIFIED BY 'pass01!';
CREATE USER 'slave'@'localhost' IDENTIFIED BY 'pass01!';

-- REPLICATION CLIENT权限开启SHOW MASTER STATUS和SHOW SLAVE STATUS的使用。
-- 也开启了SHOW BINARY LOGS语句的使用。
GRANT REPLICATION CLIENT ON *.* TO 'slave'@'%' IDENTIFIED BY 'pass01!';
GRANT REPLICATION CLIENT ON *.* TO 'slave'@'localhost' IDENTIFIED BY 'pass01!';
FLUSH PRIVILEGES;

-- REPLICATION SLAVE权限应该被授予给slave server使用的账户，以便连接到master server；
-- 没有这个权限，slave就不能请求那些在master server数据库中执行的更新。
GRANT REPLICATION SLAVE ON *.* TO 'slave'@'%' IDENTIFIED BY 'pass01!';
GRANT REPLICATION SLAVE ON *.* TO 'slave'@'localhost' IDENTIFIED BY 'pass01!';
FLUSH PRIVILEGES;

-- 控制后续的SQL语句写入bin log
SET sql_log_bin=1;

CREATE DATABASE db_a DEFAULT CHARACTER SET utf8;

USE db_a;

CREATE TABLE tbl_a 
(
a1 INT, 
a2 CHAR(10), 
PRIMARY KEY (a1)
) ENGINE=INNODB;

INSERT INTO tbl_a VALUES (1, 'a'), (2, 'b');

SELECT * FROM tbl_a;
