#!/bin/bash
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
echo $SSH_PUB_KEY >> /home/jenkins/.ssh/authorized_keys

/usr/sbin/sshd -D
