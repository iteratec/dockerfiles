FROM debian:7

MAINTAINER infrastruktur-ham@iteratec.de

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y wget apt-utils ca-certificates

RUN wget https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb && \
  dpkg -i puppetlabs-release-wheezy.deb && \
  apt-get update

RUN apt-get install -y puppetserver=1.0.0-1puppetlabs1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY puppet.conf /etc/puppet/puppet.conf

VOLUME ["/opt/puppet"]

RUN cp -rf /etc/puppet/* /opt/puppet/

VOLUME ["/opt/varpuppet/lib/puppet"]

RUN cp -rf /var/lib/puppet/* /opt/varpuppet/lib/puppet/

EXPOSE 8140

ENTRYPOINT [ "/usr/bin/puppet", "master", "--no-daemonize", "--verbose" ]
