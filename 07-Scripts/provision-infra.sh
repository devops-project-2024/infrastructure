#!bin/bash

sh ~/infrastracture/02-Terraform/pipeline-dev/userdata/bastion-setup.sh

cd infrastructure/02-Terraform/pipeline-dev 
terraform init
terraform plan 
terraform apply --auto-approve 2> ./infra-error.log 


cd ~/infrastracture/03-Ansible/playbook

ansible-playbook -i host.ini ping.yml 2> ~/ping-error.txt

ansible-playbook -i host.ini docker-sonarqube.yml
ansible-playbook -i host.ini k8s-master-node.yml
ansible-playbook -i host.ini k8s-worker-node.yml

