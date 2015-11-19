FROM jenkins:1.625.2
MAINTAINER thomas.steinbach iteratec.de

USER root
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      python-pip \
      python-dev && \
    apt-get clean && \
    apt-get autoremove

RUN pip install markupsafe ansible docker-py
