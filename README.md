# Installing Helm 3 on Amazon EKS

This guide details the steps to install Helm 3, a Kubernetes package manager, which you can use to deploy and manage applications on your Amazon EKS cluster.

## Prerequisites

- An Amazon EKS cluster set up and running. You can create one via the AWS Management Console or using the AWS CLI.
- AWS CLI installed and configured with access to your AWS account.
- `kubectl` installed and configured to communicate with your EKS cluster.

## Installation Steps

### Step 1: Download Helm

To install Helm, you must first download the latest version of the Helm binary. You can download it from the Helm releases page or use a package manager to install it.


#### Using a Script (Linux or macOS):
n also use Helm's provided script to install it on 
You caany Unix-based system:

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

### Step 2: Configure Helm with Your EKS Cluster

Once Helm is installed, you need to ensure it is configured to interact with your EKS cluster.

1. **Set up your Kubernetes configuration file if not already done**. Typically, when you set up `kubectl` to interact with your EKS cluster, it automatically configures your kubeconfig file (`~/.kube/config`). Helm uses the same configuration file.

2. **Check the Helm version to ensure it's installed correctly**:

```bash
helm version
```

<!-- ### Step 3: Add a Helm Chart Repository

Helm charts are stored in repositories. Before you can install a chart, you must add a repository. Here's how you can add the official Helm stable charts repository:

```bash
helm repo add stable https://charts.helm.sh/stable
helm repo update
```

### Step 4: Install a Helm Chart

As an example, to install the NGINX Ingress controller using Helm, you can run:

```bash
helm install nginx-ingress stable/nginx-ingress --namespace kube-system --create-namespace
```

This command installs the NGINX Ingress controller in the `kube-system` namespace. You can adjust the chart parameters according to your specific needs.

### Step 5: Verify the Installation

To check if the NGINX Ingress controller (or any other installed application) is running:

```bash
kubectl get pods -n kube-system
```
 -->
