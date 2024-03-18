# Kubernetes Playbooks README

## Overview

This README document explains the purpose and functionality of a series of Ansible playbooks designed to set up and manage a Kubernetes cluster. The playbooks cover the setup of Kubernetes master and worker nodes, network configurations, and the deployment of necessary Kubernetes components.

## Prerequisites

Before running the playbooks, you need to have the following installed on your machine:

- Ansible
- Access to a set of machines (virtual or physical) where Kubernetes will be installed
- SSH access to all the machines

## Playbook Descriptions

### 1. Kubernetes Master Setup

`k8s-master-playbook.yml`: This playbook initializes the Kubernetes master node, sets up the Kubernetes cluster, and deploys the Calico network plugin.

### 2. Kubernetes Nodes Setup

`k8s-nodes-playbook.yml`: This playbook joins worker nodes to the Kubernetes cluster and configures them as necessary.

### 3. Common Setup

`common-setup-playbook.yml`: Contains common setup tasks for all nodes in the cluster, such as installing Docker and Kubernetes packages.

## Usage

1. Update the inventory file (`hosts.ini`) with the IP addresses of your master and worker nodes.

2. Run the playbook for setting up the Kubernetes master:

    ```bash
    ansible-playbook -i hosts.ini k8s-master-playbook.yml
    ```

3. Once the master is set up, run the playbook for setting up the worker nodes:

    ```bash
    ansible-playbook -i hosts.ini k8s-nodes-playbook.yml
    ```

4. Verify the cluster status with:

    ```bash
    kubectl get nodes
    ```

## Configuration

Edit the `group_vars/all.yml` file to modify any default settings used across the playbooks, such as Kubernetes version or network settings.

## Contributing

Contributions to improve the playbooks or add new features are welcome. Please submit your pull requests or issues through the project's repository.

## License

Specify the license under which the playbooks are shared.

## Acknowledgments

- Mention any individuals or organizations whose work was included or inspired the creation of these playbooks.

---

Save this as `README.md` in the same directory as your playbooks to provide users with guidance on how to use and contribute to your Kubernetes setup playbooks.