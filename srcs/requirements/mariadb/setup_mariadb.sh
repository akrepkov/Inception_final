#!/bin/bash


mv /50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

mkdir -p /var/log/mysql 
mkdir -p /run/mysqld 
mkdir -p /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql /var/log/mysql /run/mysqld 

# Start MariaDB
service mariadb start
echo "Starting script..."
# until mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SELECT 1" > /dev/null 2>&1; do
# 	echo "Loading MariaDB..."
sleep 2
# done

#-u user; -p password
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
FLUSH PRIVILEGES;
EOF


service mariadb stop

exec mysqld_safe

