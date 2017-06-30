Ansible
=======

Run Ansible from this Docker container instead of installing Ansible on your machine. It uses Ansible from source and you can optionally choose the branch and version to execute.
This image is a stripped-down copy of [this one](https://hub.docker.com/r/thomass/ansible/).

Usage
-----

* If you deploy to `localhost`, your playbook must not override the `localhost`

Run

```
docker run -it --rm \
  -v "/path/to/ansible-artifacts":/ansible-artifacts \
  -v "$(echo $HOME)/.ssh/id_rsa":/root/.ssh/id_rsa \
  --env "LOCAL_USER=$(whoami)" \
  iteratec/ansible bash
```

Now you can execute your mounted playbooks under `/ansible-artifacts`.

Configuration
-------------

You can configure you container by environment variables.

|Variable | Description |
|----------|------|
| UPDATE_REPO | Merge the latest commits to the Ansible repository |
| BRANCH | The branch to use from the Ansible repository |
| VERSION | The commit or tag to use from the Ansible repository |

Licence
-------

The whole repository is licenced under BSD. Please mention following:
