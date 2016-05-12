FROM jenkins:1.651.1
MAINTAINER thomas.steinbach iteratec.de

USER root

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      python-dev \
      python-pip \
      python-apt \
      git \
      ruby \
      ruby-dev \
      rake \
      apt-transport-https && \
    apt-key adv \
      --keyserver hkp://p80.pool.sks-keyservers.net:80 \
      --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo 'deb https://apt.dockerproject.org/repo debian-jessie main' > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y docker-engine && \
    apt-get clean && \
    apt-get autoremove

RUN gem install serverspec
RUN pip install paramiko==1.16.0 \
                PyYAML==3.11 \
                Jinja2==2.8 \
                httplib2==0.9.2 \
                six==1.8.0 \
                markupsafe==0.23 \
                ansible==2.0.2.0 \
                docker-py==1.8.0 \
                ansible-lint==2.6.2

# install required Jenkins PlugIns
COPY files/mod_jenkins/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# configure Ansible
RUN mkdir /etc/ansible && \
    echo 'localhost ansible_connection=local' >> /etc/ansible/hosts

# modify Ansible installation
COPY files/mod_ansible/profile_tasks.py /usr/local/lib/python2.7/dist-packages/ansible/plugins/callback/profile_tasks.py

# copy AnsibleCI static content to Jenkins
COPY files/jenkinsdata/jenkins_home /usr/share/jenkins/ref
COPY files/jenkinsdata/ansible-ci /usr/share/jenkins/ref/ansible-ci

# copy AnsibleCI setup scripts
RUN mkdir /ansible_data
COPY files/ansibledata /ansible_data

# copy AnsibleCI default and example configuration files
RUN mkdir /ansible_config /example_config
COPY files/exampleconfig /example_config

# copy system and tool scripts
COPY files/system/start.sh /usr/local/bin/start.sh
COPY files/system/get-public-key /usr/local/bin/get-public-key
COPY files/system/deploy-agents /usr/local/bin/deploy-agents
COPY files/system/deploy-prelive /usr/local/bin/deploy-prelive
COPY files/tools/local_client_setup.sh /tools/local_client_setup.sh

# set rights and permissions
RUN chown -R jenkins:jenkins /example_config && \
    chmod 0755 /usr/local/bin/start.sh && \
    chmod 0755 /usr/local/bin/get-public-key && \
    chmod 0755 /usr/local/bin/deploy-agents && \
    chmod 0755 /usr/local/bin/deploy-prelive && \
    chmod 0644 /usr/local/lib/python2.7/dist-packages/ansible/plugins/callback/profile_tasks.py

ENTRYPOINT ["/usr/local/bin/start.sh"]

USER jenkins
