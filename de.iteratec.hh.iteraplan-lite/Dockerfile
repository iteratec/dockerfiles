FROM java:openjdk-7-jdk
MAINTAINER Hauke Mettendorf <hauke.mettendorf@iteratec.de>

ENV ITERAPLAN_URL http://www.iteraplan.de/download/iteraplan-lite-edition/?wpdmdl=1409
ENV ITERAPLAN_HOME /opt/iteraplan
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# Add user
RUN useradd iteraplan -M -f 0

RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y unzip wget supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN (cd /tmp && \
    wget $ITERAPLAN_URL -O iteraplan.zip) 

RUN (cd /tmp && \
    unzip -q iteraplan.zip && \
    mv /tmp/iteraplan* /opt/ && \
    cd /opt/iteraplan && \
    ln -s apache-tomcat-* tomcat)

RUN (rm /opt/iteraplan.zip && \
    rm -rf /tmp/*)

COPY config/tomcat-users.xml /opt/iteraplan/tomcat/conf/tomcat-users.xml
COPY config/probe-2.4.0/probe.war /opt/iteraplan/tomcat/webapps/probe.war

# Copy iteraplan to ROOT context
RUN rm -R /opt/iteraplan/tomcat/webapps/ROOT/* && \
    mv /opt/iteraplan/tomcat/webapps/iteraplan/* /opt/iteraplan/tomcat/webapps/ROOT/ && \
    rm -R /opt/iteraplan/tomcat/webapps/iteraplan

RUN (chmod a+x /opt/iteraplan/*.sh  && \
     chmod a+x /opt/iteraplan/tomcat/bin/*.sh)

RUN chown -R iteraplan:iteraplan /opt/iteraplan

# Configure supervisor
COPY config/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY config/supervisor/hsqldb.conf /etc/supervisor/conf.d/hsqldb.conf
COPY config/supervisor/tomcat.conf /etc/supervisor/conf.d/tomcat.conf

# Volumes
VOLUME /opt/iteraplan/hsqldb/data
VOLUME /opt/iteraplan/apache-tomcat-7.0.39/logs
VOLUME /var/log/supervisor

# Ports
EXPOSE 8080
EXPOSE 8009
EXPOSE 8005
EXPOSE 9001

CMD /usr/bin/supervisord -n
