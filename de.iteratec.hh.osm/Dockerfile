FROM tomcat:7.0.64-jre7
MAINTAINER nils.kuhn@iteratec.de

# add war files
ADD webapps/OpenSpeedMonitor-3.1.9.war /usr/local/tomcat/webapps/OpenSpeedMonitor.war
ADD webapps/probe.war /usr/local/tomcat/webapps/probe.war
VOLUME /usr/local/tomcat/webapps

# add and prepare osm config file
RUN mkdir -p /root/.grails
ADD templates/osm-config.groovy /osm-templates/osm-config.groovy
ADD templates/osm-just-users-config.groovy /osm-templates/osm-just-users-config.groovy
ADD tomcat/setenv.sh /osm-templates/setenv.sh
VOLUME /osm-templates
VOLUME /root/.grails

# add tomcat-users.xml
ADD templates/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
VOLUME /usr/local/tomcat/conf
VOLUME /usr/local/tomcat/bin

# add and start entrypoint script
ADD entrypoint.sh /root/entrypoint.sh
RUN chmod u+x /root/entrypoint.sh
CMD /root/entrypoint.sh