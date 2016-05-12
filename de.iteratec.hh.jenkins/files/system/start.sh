#!/bin/bash

set -e

## Start of definition of singleton functions

if [[ $1 == 'get-local-start-script' ]]; then
  cat /tools/local_client_setup.sh
  exit
fi

## End of definition of singleton functions

# update used configuration
if [[ $(ls /ansible_config/) ]]; then
  cp /ansible_config/* /used_config
fi

# execute default Docker jenkins start script
/usr/local/bin/jenkins.sh date # pass 'date' to suppress startup of jenkins

# for any deployment gather vault password
if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]] || [[ "$1" == 'deploy-aci' ]] || [[ "$1" == 'deploy-agents' ]] || [[ "$1" == 'deploy-prelive' ]]; then
  if [[ -z $ANSIBLE_VAULT_PASSWORD ]]; then
    echo "You have to provide the vault password through the ANSIBLE_VAULT_PASSWORD variable."
    exit 1
  fi
  echo "$ANSIBLE_VAULT_PASSWORD" > /tmp/ansible_vaultpass
fi

# for any deployment despite the prelive deployment gather agents login user if file not already present
if [[ ! -f /used_config/agent_user.yml ]] || ][[ $# -lt 1 ]] || [[ "$1" == "--"* ]] || [[ "$1" == 'deploy-aci' ]] || [[ "$1" == 'deploy-agents' ]]; then
  if [[ -z $ACIA_LOGIN_USER ]]; then
    echo "You have to provide the user for logging onto the ACI agents machine through the ACIA_LOGIN_USER variable."
    exit 1
  fi
  echo "acia_login_user: $ACIA_LOGIN_USER" > /used_config/agent_user.yml
fi

# initiate default startup if no other commands than jenkins parameters are passed...
if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then

  # 'Install' ACI into Jenkins
  cd /ansible_data/playbooks/setup
  ansible-playbook --vault-password-file /tmp/ansible_vaultpass site.yml

  # And finally run Jenkins
  exec java $JAVA_OPTS -jar /usr/share/jenkins/jenkins.war $JENKINS_OPTS "$@"
fi

# ...or execute the command given
exec "$@"
