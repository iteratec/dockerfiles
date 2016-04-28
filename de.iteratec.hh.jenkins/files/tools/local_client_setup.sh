#!/bin/bash

set -e

repolabel=default

if [[ ! -d clientconfig ]]; then
  mkdir clientconfig
fi

if [[ ! -f clientconfig/vault.yml ]]; then
  echo "PKI_PASSWORD: $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)" > clientconfig/vault.yml
  echo 'ACI_PRIVATE_KEY: |' >> clientconfig/vault.yml
  ssh-keygen -t rsa -C 'AnsibleCI' -N '' -f /tmp/aci_key 1>/dev/null
  cat /tmp/aci_key | sed 's/^/  /' >> clientconfig/vault.yml
  echo "ACI_PUBLIC_KEY: $(cat /tmp/aci_key.pub)" >> clientconfig/vault.yml

  cat /tmp/aci_key.pub >> ~/.ssh/authorized_keys
  rm /tmp/aci_key /tmp/aci_key.pub

  echo ''
  echo 'It is the first time you are running ACI with this configuration. I have added a private vault file to your configuration, containing a couple of secrets unique for this ACI instance. Following you have to provide a password which you will be asked for every start of a new Docker container on this configuration. So please remember this password.'
  ansible-vault encrypt clientconfig/vault.yml
fi

if [[ ! -f clientconfig/repositories.yml ]]; then
  echo ''
  echo 'I see you have no repositories set up. Let us do this quickly.'
  read -p 'With label should your repository have? ' -e -i 'default' repolabel
  read -p 'In which subpath are your roles in? (leave blank if none) ' rolespath
  read -p 'In which subpath are your playbooks in? (leave blank if none) ' playbookspath

  echo -e "---\naci_repository:" > clientconfig/repositories.yml
  echo "  - name: $repolabel" >> clientconfig/repositories.yml
  if [[ $rolespath ]]; then echo "    subpath_roles: $rolespath" >> clientconfig/repositories.yml; fi
  if [[ $playbookspath ]]; then echo "    subpath_playbooks: $playbookspath" >> clientconfig/repositories.yml; fi
fi

echo ''
echo 'Starting ACI with...'
read -s -p 'Vault Password:' avp && echo ''
read -e -p 'The absolute path to your local ansible-infrastructure repository:' repopath
read -p 'The user ACI should use to login on the agents machine (normally your user name): ' agentuser

docker run -d \
  --name aci \
  -p 8081:8080 \
  --restart always \
  -e "ANSIBLE_VAULT_PASSWORD=$avp" \
  -e "ACIA_LOGIN_USER=$agentuser" \
  -v "$(pwd)/clientconfig":/ansible_config \
  -v "$repopath:/var/jenkins_home/workspace/develop/$repolabel" \
  iteratechh/jenkins 1>/dev/null

echo ''
echo 'The AnsibleCI Docker container has been started.'
echo 'You can monitor the startup and further logs with'
echo ''
echo '    docker logs -f aci'
echo ''
echo 'After a while ACI will be available on http://localhost:8081'
echo ''
echo 'When ACI is up and running you have to complete the setup by'
echo 'running the installation of the local Vagrant Agent by running'
echo ''
echo '    docker exec -it aci deploy-agents'
