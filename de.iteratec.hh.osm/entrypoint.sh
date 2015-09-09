#!/bin/bash

# set tomcat user and password for probe
TOMCAT_USER=${TOMCAT_USER:=tomcat}
sed -i "s/\${TOMCAT_USER}/$TOMCAT_USER/g" /usr/local/tomcat/conf/tomcat-users.xml
TOMCAT_PASSWORD=${TOMCAT_PASSWORD:=tomcat}
sed -i "s/\${TOMCAT_PASSWORD}/$TOMCAT_PASSWORD/g" /usr/local/tomcat/conf/tomcat-users.xml

# prepare osm config respective set env variables
OSM_CONFIG_TARGET_LOCATION="/root/.grails/OpenSpeedMonitor-config.groovy"
if [ -n "BASE_URL_OSM" ] && [ -n "$OSM_ADMIN_USER" ] && [ -n "$OSM_ADMIN_PASSWORD" ] && [ -n "$OSM_ROOT_USER" ] && [ -n "$OSM_ROOT_PASSWORD" ] && [ -n "$MYSQL_DATABASE" ] && [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ]
then
    echo "complete osm config file gets prepared"
	cp -f /osm-templates/osm-config.groovy $OSM_CONFIG_TARGET_LOCATION
	sed -i "s/\${BASE_URL_OSM}/$BASE_URL_OSM/g" $OSM_CONFIG_TARGET_LOCATION
	sed -i "s/\${OSM_ADMIN_USER}/$OSM_ADMIN_USER/g" $OSM_CONFIG_TARGET_LOCATION
	sed -i "s/\${OSM_ADMIN_PASSWORD}/$OSM_ADMIN_PASSWORD/g" $OSM_CONFIG_TARGET_LOCATION
	sed -i "s/\${OSM_ROOT_USER}/$OSM_ROOT_USER/g" $OSM_CONFIG_TARGET_LOCATION
	sed -i "s/\${OSM_ROOT_PASSWORD}/$OSM_ROOT_PASSWORD/g" $OSM_CONFIG_TARGET_LOCATION
	sed -i "s/\${MYSQL_DATABASE}/$MYSQL_DATABASE/g" $OSM_CONFIG_TARGET_LOCATION
	sed -i "s/\${MYSQL_USER}/$MYSQL_USER/g" $OSM_CONFIG_TARGET_LOCATION
	sed -i "s/\${MYSQL_PASSWORD}/$MYSQL_PASSWORD/g" $OSM_CONFIG_TARGET_LOCATION
	cp -f /osm-templates/setenv.sh /usr/local/tomcat/bin
elif [ -z "BASE_URL_OSM" ] && [ -z "$OSM_ADMIN_USER" ] && [ -z "$OSM_ADMIN_PASSWORD" ] && [ -z "$OSM_ROOT_USER" ] && [ -z "$OSM_ROOT_PASSWORD" ] && [ -z "$MYSQL_DATABASE" ] && [ -z "$MYSQL_USER" ] && [ -z "$MYSQL_PASSWORD" ] && [ ! -e $OSM_CONFIG_TARGET_LOCATION ]
then
	echo "osm config file with some default users gets prepared"
	cp -f /osm-templates/osm-just-users-config.groovy $OSM_CONFIG_TARGET_LOCATION
	sed -i "s/\${OSM_ADMIN_USER}/admin/g" $OSM_CONFIG_TARGET_LOCATION
	sed -i "s/\${OSM_ADMIN_PASSWORD}/admin/g" $OSM_CONFIG_TARGET_LOCATION
	sed -i "s/\${OSM_ROOT_USER}/root/g" $OSM_CONFIG_TARGET_LOCATION
	sed -i "s/\${OSM_ROOT_PASSWORD}/root/g" $OSM_CONFIG_TARGET_LOCATION
	cp -f /osm-templates/setenv.sh /usr/local/tomcat/bin
fi

# start tomcat
catalina.sh run