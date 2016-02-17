FROM ubuntu:trusty
MAINTAINER Birger Kamp <Birger.Kamp@iteratec.de>

# Make sure the package repository is up to date.
RUN apt-get update
RUN apt-get -y upgrade

# Install a basic SSH server
RUN apt-get install -y openssh-server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

RUN apt-get install -y software-properties-common git
# Java 7
RUN apt-get install -y openjdk-7-jdk
# Java 8
RUN add-apt-repository -y ppa:openjdk-r/ppa && apt-get update && apt-get install -y openjdk-8-jdk

RUN adduser --quiet jenkins
RUN mkdir -p /home/jenkins/.ssh && chmod -R 700 /home/jenkins/.ssh && chown -R jenkins /home/jenkins/.ssh

EXPOSE 22

ADD start_script.sh /start_script.sh
RUN chmod +x /start_script.sh

CMD ["/start_script.sh"]
