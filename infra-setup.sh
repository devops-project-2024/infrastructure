#!/bin/bash

cd ~/Devops-project-2024/infrastructure/02-Terraform/pipeline-dev 
terraform init
terraform plan 
terraform apply --auto-approve  
