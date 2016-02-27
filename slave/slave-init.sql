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

-- 告诉备库如何连接到主库并重放二进制日志
CHANGE MASTER TO 
MASTER_HOST='127.0.0.1', 
MASTER_USER='slave', 
MASTER_PASSWORD='pass01!', 
MASTER_PORT=3312;

-- 开始复制
START SLAVE;
