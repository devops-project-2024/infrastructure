# Kubernetes Playbooks README

## Overview

This document details Ansible playbooks for setting up a Kubernetes cluster, including master and worker nodes, network configurations, and Kubernetes components. It also includes playbooks for pinging servers and handling SSH host key checking.

## Prerequisites

- Ansible installed on your control machine
- Machines (virtual or physical) for Kubernetes installation
- SSH access to these machines

## Playbook Descriptions

### 1. Kubernetes Master Setup

- **File:** `k8s-master-playbook.yml`
- **Description:** Initializes the Kubernetes master node, sets up the cluster, and deploys Calico as the network plugin.

### 2. Kubernetes Nodes Setup

- **File:** `k8s-nodes-playbook.yml`
- **Description:** Joins worker nodes to the Kubernetes cluster with necessary configurations.

### 3. Common Setup

- **File:** `common-setup-playbook.yml`
- **Description:** Installs common prerequisites like Docker and Kubernetes on all nodes.

### 4. Ping Servers

- **File:** `ping-servers-playbook.yml`
- **Description:** Ensures connectivity to all servers in the inventory by sending ping requests.

### 5. Disable Host Key Checking

- **Purpose:** To avoid manual SSH host key verification prompts during playbook runs.
- **Method:** Set `ANSIBLE_HOST_KEY_CHECKING=False` in your environment or `ansible.cfg`, or use `-e 'ansible_host_key_checking=False'` with `ansible-playbook` command.

## Usage

1. Populate `hosts.ini` with your nodes' IP addresses.

2. To ping and check connectivity:

    ```bash
    ansible-playbook -i hosts.ini ping.yml
    ```
3.   For the Kubernetes master setup:

    ```bash
    ansible-playbook -i hosts.ini k8s-master-playbook.yml
    ```

4. For the worker nodes setup:

    ```bash
    ansible-playbook -i hosts.ini k8s-nodes-playbook.yml
    ```

5. Check the cluster with:

    ```bash
    kubectl get nodes
    ```

## Configuration

Modify `group_vars/all.yml` for any playbook-wide settings like Kubernetes version or network configurations.

## Contributing

Contributions are welcome. Submit pull requests or issues through the project's repository.

## License

Indicate the license governing the use and distribution of these playbooks.

## Acknowledgments

- Acknowledge individuals or organizations that contributed or inspired these playbooks.

---
