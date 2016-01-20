FROM jenkins:latest
MAINTAINER thomas.steinbach iteratec.de

USER root
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      python-pip \
      python-dev \
      git && \
      ruby-serverspec \
    apt-get clean && \
    apt-get autoremove

RUN pip install markupsafe ansible docker-py ansible-lint

RUN mkdir /etc/ansible

USER jenkins
