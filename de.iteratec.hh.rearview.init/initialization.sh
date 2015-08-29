#!/bin/bash

LINKED_MYSQL_CONTAINER="rearview-mysql"

# preparation of mysql database

RESULT=`mysql -h $LINKED_MYSQL_CONTAINER -uroot -p$MYSQL_ROOT_PASSWORD --skip-column-names -e "SHOW DATABASES LIKE '$MYSQL_DATABASE'"`
if [ "$RESULT" == "$MYSQL_DATABASE" ]; then
    echo "Rearview database already exists -> nothing to do here."
else
	echo "Rearview database does not exist -> Creating database named $MYSQL_DATABASE."
	Q1="CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
	mysql -h $LINKED_MYSQL_CONTAINER -uroot -p$MYSQL_ROOT_PASSWORD -e "$Q1"
	echo "Rearview database does not exist -> Creating database user named $MYSQL_USER and grant access to db."
	Q2="GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER' IDENTIFIED BY '$MYSQL_PASSWORD';"
	Q3="FLUSH PRIVILEGES;"
	mysql -h $LINKED_MYSQL_CONTAINER -uroot -p$MYSQL_ROOT_PASSWORD -e "${Q2}${Q3}"
	echo "Rearview database does not exist -> Import dump."
	mysql -h $LINKED_MYSQL_CONTAINER -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /tmp/mysql-dumps/initial-mysql-dump.sql
fi

# set rearview-config

echo "set graphite.host in common.conf to $GRAPHITE_HOST"
sed -i -r "s/graphite\.host=.+/graphite.host=\"http:\/\/$GRAPHITE_HOST\"/g" /app/conf/common.conf
echo "set db.default.user to $MYSQL_USER"
sed -i -r "s/db\.default\.user=.+/db.default.user=\"$MYSQL_USER\"/g" /app/conf/common.conf
echo "set db.default.password to ***"
sed -i -r "s/db\.default\.password=.+/db.default.password=\"$MYSQL_PASSWORD\"/g" /app/conf/common.conf
echo "set db.default.url to jdbc:mysql://$LINKED_MYSQL_CONTAINER:3306/$MYSQL_DATABASE"
sed -i -r "s/db\.default\.url=.+/db.default.url=\"jdbc:mysql:\/\/rearview\-mysql:3306\/$MYSQL_DATABASE\"/g" /app/conf/common.conf