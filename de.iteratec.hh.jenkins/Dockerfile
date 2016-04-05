FROM jenkins:latest
MAINTAINER thomas.steinbach iteratec.de

USER root
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      python-pip \
      python-dev \
      git \
      ruby \
      ruby-dev \
      rake && \
    apt-get clean && \
    apt-get autoremove

RUN gem install serverspec
RUN pip install markupsafe ansible docker-py ansible-lint

COPY profile_tasks.py /usr/local/lib/python2.7/dist-packages/ansible/plugins/callback/profile_tasks.py
RUN chmod 0644 /usr/local/lib/python2.7/dist-packages/ansible/plugins/callback/profile_tasks.py

RUN chown root:jenkins /usr/local/lib/python2.7/dist-packages/ansible/plugins/callback
RUN chmod 0774 /usr/local/lib/python2.7/dist-packages/ansible/plugins/callback

USER jenkins

# make all static preparations not necessary in Ansible

COPY jenkins_home /usr/share/jenkins/ref
COPY ansible-ci /usr/share/jenkins/ref/ansible-ci

# install jenkins plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
