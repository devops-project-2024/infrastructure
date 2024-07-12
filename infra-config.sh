#!/bin/bash

cd ~/Devops-project-2024/infrastructure/03-Ansible/playbook

ansible-playbook -i host-pub.ini ping.yml -e 'ansible_host_key_checking=False'
ansible-playbook -i host-pub.ini docker-installation.yml
ansible-playbook -i host-pub.ini docker-sonarqube.yml
# ansible-playbook -i host-pub.ini k8s-master-node.yml
# ansible-playbook -i host-pub.ini k8s-worker-node.yml
ansible-playbook -i host-pub.ini jenkins-key.yml 


