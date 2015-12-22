FROM jenkins:latest
MAINTAINER thomas.steinbach iteratec.de

USER root
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      python-pip \
      python-dev && \
      git && \
    apt-get clean && \
    apt-get autoremove

RUN pip install markupsafe ansible docker-py

COPY hosts /etc/ansible/hosts

USER jenkins
