FROM ubuntu:trusty
MAINTAINER Birger Kamp <Birger.Kamp@iteratec.de>

# Make sure the package repository is up to date.
RUN apt-get update
RUN apt-get -y upgrade

# Install a basic SSH server
RUN apt-get install -y openssh-server

RUN apt-get install -y openjdk-8-jdk

RUN adduser --quiet jenkins

EXPOSE 22

ADD start_script.sh /start_script.sh
RUN chmod +x /start_script.sh

CMD ["/start_script.sh]
