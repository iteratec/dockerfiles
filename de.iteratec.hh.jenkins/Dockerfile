FROM jenkins:1.651.1
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

RUN pip install paramiko PyYAML Jinja2 httplib2 six markupsafe ansible docker-py ansible-lint
RUN gem install serverspec

# install jenkins plugins
COPY files/mod_jenkins/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

COPY files/system/start.sh /usr/local/bin/start.sh
COPY files/system/get-public-key /usr/local/bin/get-public-key
COPY files/system/deploy-agents /usr/local/bin/deploy-agents
COPY files/system/deploy-prelive /usr/local/bin/deploy-prelive
COPY files/mod_ansible/profile_tasks.py /usr/local/lib/python2.7/dist-packages/ansible/plugins/callback/profile_tasks.py

RUN mkdir /etc/ansible && \
    echo 'localhost ansible_connection=local' >> /etc/ansible/hosts

# make all static preparations not necessary in Ansible

# copy static AnsibleCI content
COPY files/jenkinsdata/jenkins_home /usr/share/jenkins/ref
COPY files/jenkinsdata/ansible-ci /usr/share/jenkins/ref/ansible-ci

# copy ansible default and example config
RUN mkdir /ansible_config /example_config
COPY files/exampleconfig /example_config

# copy ansible data
RUN mkdir /ansible_data
COPY files/ansibledata /ansible_data

# set rights and permissions
RUN chown -R jenkins:jenkins /ansible && \
    chown -R jenkins:jenkins /example_config && \
    chmod 0755 /usr/local/bin/start.sh && \
    chmod 0755 /usr/local/bin/get-public-key && \
    chmod 0755 /usr/local/bin/deploy-agents && \
    chmod 0755 /usr/local/bin/deploy-prelive && \
    chmod 0644 /usr/local/lib/python2.7/dist-packages/ansible/plugins/callback/profile_tasks.py

ENTRYPOINT ["/usr/local/bin/start.sh"]

USER jenkins
