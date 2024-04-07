#!bin/bash

sh ~/infrastracture/02-Terraform/pipeline-dev/userdata/bastion-setup.sh

cd ~/infrastracture/02-Terraform/pipeline-dev 
terraform init
terraform plan 
terraform apply --auto-approve > ~/infra-output.txt 


cd ~/infrastracture/03-Ansible/playbook

ansible-playbook -i host.ini ping.yml > ~/ping-output.txt

ansible-playbook -i host.ini docker-sonarqube.yml
ansible-playbook -i host.ini k8s-master-node.yml
ansible-playbook -i host.ini k8s-worker-node.yml

