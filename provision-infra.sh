#!/bin/bash

# cd ./infrastracture/02-Terraform/pipeline-dev/userdata/
# sh bastion-setup.sh

cd ~/Devops-project-2024/infrastructure/02-Terraform/pipeline-dev 
terraform init
terraform plan 
terraform apply --auto-approve 2> ./error.log 


cd ~/Devops-project-2024/infrastructure/03-Ansible/playbook

ansible-playbook -i host.ini ping.yml 2> ./ping-output.txt
ansible-playbook -i host.ini docker-sonarqube.yml
ansible-playbook -i host.ini k8s-master-node.yml
ansible-playbook -i host.ini k8s-worker-node.yml

