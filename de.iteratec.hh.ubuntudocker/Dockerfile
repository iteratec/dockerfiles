FROM ubuntu:xenial
MAINTAINER thomas.steinbach iteratec.de

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      apt-transport-https \
      ca-certificates && \
    apt-key adv \
      --keyserver hkp://p80.pool.sks-keyservers.net:80 \
      --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y docker-engine && \
    apt-get clean && \
    apt-get autoremove

COPY start.sh /usr/local/bin/start.sh
RUN chmod 0755 /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]
