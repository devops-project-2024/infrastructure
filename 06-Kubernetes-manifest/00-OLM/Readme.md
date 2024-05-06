# Step-by-Step Guide to Installing Operator Lifecycle Manager (OLM) Tools

## Prerequisites

Before you begin, ensure that you have `kubectl` installed and configured to interact with your Kubernetes cluster.

## Step 1: Install Operator Lifecycle Manager (OLM)

OLM is a tool that helps manage the Operators running on your Kubernetes cluster. To install OLM, run the following command:

```sh
sudo curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v0.27.0/install.sh | bash -s v0.27.0
```

## Step 2: Install OLM Tool for ArgoCD

To install the ArgoCD Operator using OLM, execute this command:

```sh
kubectl create -f https://operatorhub.io/install/argocd-operator.yaml
```

## Step 3: Install OLM Tool for Grafana

To install the Grafana Operator using OLM, use the following command:

```sh
kubectl create -f https://operatorhub.io/install/grafana-operator.yaml
```

## Step 4: Install OLM Tool for Prometheus

For the Prometheus Operator, run this command:

```sh
kubectl create -f https://operatorhub.io/install/prometheus.yaml
```

## Step 5: Review Installed Operators

After installing the operators, you can review all the resources managed by these operators within the `operators` namespace. Use this command:

```sh
kubectl get all -n operators
```

This command will display all the pods, services, and other resources related to the installed operators.

