# Ansible Playbooks README

## Overview

This document details Ansible playbooks for setting up a Kubernetes cluster, including master and worker nodes, network configurations, and Kubernetes components. It also includes playbooks for pinging servers, deploying sonaqube on docker server and handling SSH host key checking.

## Prerequisites

- Ansible installed on your host machine
- Machines (virtual or physical) for Kubernetes configuration
- SSH access to these machines

## Set Server private keys 
- **File:** [acloud-key.pem file]
- **Description:** Ensures connectivity to all servers by adding server key pairs to /tmp file.

## Populate `hosts.ini` with your nodes' IP addresses. 
- **File:** [Inventory file](host.ini)
- **Description:** Ensures node private ip address are updated on the host.ini file.

## Playbook Descriptions

### 1. Ping Servers
- **File:** [ping playbook](./ping.yml)
- **Description:** Ensures connectivity to all servers in the inventory by sending ping requests.

### 2. Setup Sonarqube on Docker
- **File:** [Sonarqube docker playbook](./docker-sonarqube.yml)
- **Description:** Ensures connectivity to all servers in the inventory by sending ping requests.

### 3. Kuberntes Common Setup
- **File:** [Kubernetes Common Setup](./K8s-all-nodes.yml)
- **Description:** Installs common prerequisites for all Kubernetes nodes.

### 4. Kubernetes Master Setup
- **File:** [k8s master setup](./k8s-master-node.yml)
- **Description:** Initializes the Kubernetes master node, sets up the cluster, and deploys network plugin.

### 5. Kubernetes Nodes Setup
- **File:** [k8s worker setup](./k8s-worker-node.yml)
- **Description:** Joins worker nodes to the Kubernetes cluster with necessary configurations.


## Usage


1. To ping and check connectivity:

    ```bash
    ansible-playbook -i host.ini ping.yml -e 'ansible_host_key_checking=False'
    ```

2. To install sonarqube on docker server :

    ```bash
    ansible-playbook -i host.ini docker-sonarqube.yml
    ```
3.   For the Kubernetes master setup:

    ```
    ansible-playbook -i host.ini k8s-master-node.yml
    ```

4. For the worker nodes setup:

    ```bash
    ansible-playbook -i host.ini k8s-worker-node.yml
    ```

5. Check the cluster with:

    ```bash
    kubectl get nodes
    ```

---

To avoid the SSH authenticity check prompt when connecting to hosts for the first time using Ansible, you can disable the SSH host key checking. This can be done by setting the `ANSIBLE_HOST_KEY_CHECKING` environment variable to `False` before running your Ansible playbook. However, be aware that this reduces security by exposing you to potential man-in-the-middle attacks.

Here’s how you can disable SSH host key checking:

1. **Environment Variable**: Set the `ANSIBLE_HOST_KEY_CHECKING` variable in your shell environment.

   ```bash
   export ANSIBLE_HOST_KEY_CHECKING=False
   ```

2. **Ansible Configuration File**: You can also set this in the Ansible configuration file (`ansible.cfg`). Under the `[defaults]` section, add:

   ```ini
   [defaults]
   host_key_checking = False
   ```

   Place this `ansible.cfg` file in your project directory or home directory, and Ansible will pick it up.

3. **Command Line**: Alternatively, you can run your playbook with the `-e` flag to set the environment variable only for the current execution:

   ```bash
   ansible-playbook k.yml -e 'ansible_host_key_checking=False'
   ```

By using one of these methods, Ansible will skip the host key check and will not prompt you to verify the host's authenticity. This is particularly useful in automated environments, but ensure you understand the security implications of doing so in your specific context.
