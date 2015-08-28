#!/bin/bash

# preparation of mysql database

RESULT=`mysql -h rearview-mysql -uroot -p$MYSQL_ROOT_PASSWORD --skip-column-names -e "SHOW DATABASES LIKE '$MYSQL_DATABASE'"`
if [ "$RESULT" == "$MYSQL_DATABASE" ]; then
    echo "Rearview database already exists -> nothing to do here."
else
	echo "Rearview database does not exist -> Creating database named $MYSQL_DATABASE."
	Q1="CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
	mysql -h rearview-mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "$Q1"
	echo "Rearview database does not exist -> Creating database user named $MYSQL_USER and grant access to db."
	Q2="GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
	Q3="FLUSH PRIVILEGES;"
	mysql -h rearview-mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "${Q2}${Q3}"
	echo "Rearview database does not exist -> Import dump."
	mysql -h rearview-mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /tmp/mysql-dumps/initial-mysql-dump.sql
fi

# set rearview-config

sed -i -r 's/graphite\.host=.+/graphite.host="http:\/\/monitoring.hh.iteratec.de"/g' common.conf
sed -i -r 's/db\.default\.user=.+/db.default.user="$MYSQL_USER"/g' common.conf
sed -i -r 's/db\.default\.password=.+/db.default.password="$MYSQL_PASSWORD"/g' common.conf