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

RUN cd / && \
    git clone git://github.com/ansible/ansible.git --recursive
RUN pip install paramiko PyYAML Jinja2 httplib2 six markupsafe docker-py ansible-lint
RUN gem install serverspec

COPY files/system/start.sh /usr/local/bin/start.sh
COPY files/system/get-public-key /usr/local/bin/get-public-key
COPY files/mod_ansible/profile_tasks.py /ansible/lib/ansible/plugins/callback/profile_tasks.py

RUN mkdir /etc/ansible && \
    echo 'localhost ansible_connection=local' >> /etc/ansible/hosts && \
    chown -R jenkins:jenkins /ansible && \
    chmod 0755 /usr/local/bin/start.sh && \
    chmod 0755 /usr/local/bin/get-public-key && \
    chmod 0644 /ansible/lib/ansible/plugins/callback/profile_tasks.py

# make all static preparations not necessary in Ansible

# checkout Ansible version to work with
RUN cd /ansible && \
    git reset --hard 2790929e73 && \
    git submodule update

# copy static AnsibleCI content
COPY files/jenkinsdata/jenkins_home /usr/share/jenkins/ref
COPY files/jenkinsdata/ansible-ci /usr/share/jenkins/ref/ansible-ci

# install jenkins plugins
COPY files/mod_jenkins/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# copy ansible default config
RUN mkdir /ansible_config
COPY files/ansibleconfig /ansible_config

# copy ansible data
RUN mkdir /ansible_data
COPY files/ansibledata /ansible_data

ENTRYPOINT ["/usr/local/bin/start.sh"]

USER jenkins
