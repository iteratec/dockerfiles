FROM jenkins:latest
MAINTAINER thomas.steinbach iteratec.de

USER root
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      python-pip \
      python-dev \
      git \
      ruby \
      rake && \
    apt-get clean && \
    apt-get autoremove

RUN gem install serverspec
RUN pip install markupsafe ansible docker-py ansible-lint

COPY profile_tasks.py /usr/local/lib/python2.7/dist-packages/ansible/plugins/callback/profile_tasks.py
RUN chmod 0644 /usr/local/lib/python2.7/dist-packages/ansible/plugins/callback/profile_tasks.py

USER jenkins
