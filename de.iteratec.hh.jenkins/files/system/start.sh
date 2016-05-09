#!/bin/bash

set -e

if [[ $1 == 'get-local-start-script' ]]; then
  cat /tools/local_client_setup.sh
  exit
fi

/usr/local/bin/jenkins.sh date # pass 'date' to suppress startup of jenkins

# if `docker run` first argument start with `--` the user is passing jenkins launcher arguments
if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then

  if [[ -z $ACIA_LOGIN_USER ]]; then
    echo "You must set the ACIA_LOGIN_USER variable with the name of the user logging into the ACI Agents machine."
    exit 1
  fi

  if [[ $(ls /ansible_config/) ]]; then
    cp /ansible_config/* /example_config
  fi

  echo "acia_login_user: $ACIA_LOGIN_USER" > /example_config/agent_user.yml

  echo "$ANSIBLE_VAULT_PASSWORD" > /tmp/ansible_vaultpass
  cd /ansible_data/playbooks/setup
  ansible-playbook --vault-password-file /tmp/ansible_vaultpass site.yml

  exec java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS "$@"
fi

exec "$@"
