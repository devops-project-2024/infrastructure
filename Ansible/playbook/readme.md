# Ansible Playbooks README

## Overview

This document details Ansible playbooks for setting up a Kubernetes cluster, including master and worker nodes, network configurations, and Kubernetes components. It also includes playbooks for pinging servers, deploying sonaqube on docker server and handling SSH host key checking.

## Prerequisites

- Ansible installed on your host machine
- Machines (virtual or physical) for Kubernetes configuration
- SSH access to these machines

## Playbook Descriptions

### 1. Kuberntes Common Setup
- **File:** [Kubernetes Common Setup](./K8s-all-nodes.yml)
- **Description:** Installs common prerequisites for all Kubernetes nodes.

### 2. Kubernetes Master Setup
- **File:** [k8s master setup](./k8s-master-node.yml)
- **Description:** Initializes the Kubernetes master node, sets up the cluster, and deploys network plugin.

### 3. Kubernetes Nodes Setup
- **File:** [](./k8s-worker-node.yml)
- **Description:** Joins worker nodes to the Kubernetes cluster with necessary configurations.

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
    ansible-playbook -i host.ini ping.yml -e 'ansible_host_key_checking=False'
    ```
3.   For the Kubernetes master setup:

    ```bash
    ansible-playbook -i host.ini k8s-master-node.yml
    ```

4. For the worker nodes setup:

    ```bash
    ansible-playbook -i host.ini k8s-nodes-playbook.yml
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
