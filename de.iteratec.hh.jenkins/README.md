# iteratech/jenkins

This is a library/jenkins with an additional Ansible installed. It is used for ansible-ci.

## run

```
docker run -d --name aci -p 8081:8080
  -v ~/git/hh.iteratec.de/ansible-infrastructure/playbooks:/var/jenkins_home/workspace/develop/defaultPlaybooks
  -v ~/git/hh.iteratec.de/ansible-infrastructure/roles:/var/jenkins_home/workspace/develop/defaultRoles
  iteratechh/jenkins
```
