#!/bin/bash

set -e

/usr/local/bin/jenkins.sh date # pass 'date' to suppress startup of jenkins

# if `docker run` first argument start with `--` the user is passing jenkins launcher arguments
if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then

  if [[ $(ls /ansible_config/) ]]; then
    cp /ansible_config/* /example_config
  fi

  echo "$ANSIBLE_VAULT_PASSWORD" > /tmp/ansible_vaultpass
  cd /ansible_data/playbooks/setup
  ansible-playbook --vault-password-file /tmp/ansible_vaultpass site.yml

   exec java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS "$@"
fi

exec "$@"
