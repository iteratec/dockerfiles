#!/bin/bash

/usr/local/bin/jenkins.sh date # pass 'date' to suppress startup of jenkins

source /ansible/hacking/env-setup
ansible --version

cd /ansible_data/playbook

echo "$ANSIBLE_VAULT_PASSWORD" > /tmp/ansible_vaultpass
ansible-playbook --vault-password-file /tmp/ansible_vaultpass site.yml

# the following lines are from the docker images original /usr/local/bin/jenkins.sh

# if `docker run` first argument start with `--` the user is passing jenkins launcher arguments
if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then
   exec java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS "$@"
fi

# As argument is not jenkins, assume user want to run his own process, for sample a `bash` shell to explore this image
exec "$@"
