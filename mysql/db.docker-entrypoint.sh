#!/bin/sh
openrc

if [ ! -f "/etc/my.cnf" ]; then
    echo "[client]" >> /etc/my.cnf
    echo "user=root" >> /etc/my.cnf
    echo "password=${MYSQL_ROOT_PASSWORD}" >> /etc/my.cnf
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
    /etc/init.d/mariadb setup
    /etc/init.d/mariadb start
else
    /etc/init.d/mariadb restart
fi
sleep 3

USER_EXISTS=$(mysql -sse "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = '${MYSQL_USER}');")
if [ "$USER_EXISTS" != 1 ]; then
    echo "Create USER: ${MYSQL_USER}"
    mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'";
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION;";
    mysql -e "FLUSH PRIVILEGES;";
fi

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Create DB: ${MYSQL_DATABASE}"
    mysql -e "CREATE DATABASE ${MYSQL_DATABASE};";
fi

echo "--READY--"
tail -f /dev/null
