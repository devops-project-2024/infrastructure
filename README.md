# Provisioning Infrastructure 

### Step by step guide to provision infrastructure 

Here are the step-by-step instructions to execute the tasks you've outlined:

### 1. Run the Bastion Setup Script

This step involves executing a shell script that likely sets up a bastion host or performs initial configurations.

- Open a terminal, ssh into your bastion server.
- Execute the bastion setup script by running:

  ```bash
  cd ~/infrastructure/07-Scripts/userdata/
  sh bastion-setup.sh
  ```

NB: Ensure that the script `bastion-setup.sh` has executable permissions. If not, you might need to run `chmod +x ~/infrastracture/02-Terraform/pipeline-dev/userdata/bastion-setup.sh` before executing it.

### 2. Initialize and Apply Terraform Configuration

These steps are for initializing Terraform, creating a plan, and then applying the plan to provision infrastructure.

- Change directory to where your Terraform configuration is located:

  ```bash
  cd ~/infrastructure/02-Terraform/pipeline-dev
  ```

- Initialize Terraform:

  ```bash
  terraform init
  ```

- Create a Terraform plan to see what actions will be performed:

  ```bash
  terraform plan
  ```

- Apply the Terraform plan to provision the resources, and save the output to a file:

  ```bash
  terraform apply --auto-approve > ~/infra-output.txt
  ```

### 3. Execute Ansible Playbooks

These steps will execute Ansible playbooks to configure and manage your infrastructure.

- Change directory to where your Ansible playbooks are located:

  ```bash
  cd ~/infrastracture/03-Ansible/playbook
  ```

- Run the ping playbook to check connectivity to your hosts:

  ```bash
  ansible-playbook -i host.ini ping.yml > ~/ping-output.txt
  ```

- Run the playbook to set up Docker and SonarQube:

  ```bash
  ansible-playbook -i host.ini docker-sonarqube.yml
  ```

- Deploy the Kubernetes master node:

  ```bash
  ansible-playbook -i host.ini k8s-master-node.yml
  ```

- Deploy the Kubernetes worker nodes:

  ```bash
  ansible-playbook -i host.ini k8s-worker-node.yml
  ```
