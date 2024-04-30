# Installing Argo CD on Amazon EKS

This guide provides step-by-step instructions on how to deploy Argo CD on an Amazon EKS cluster. It includes setting up a basic Argo CD deployment, deploying it to a dedicated namespace, and setting up Ingress for secure and controlled access.

## Prerequisites

- An active AWS account.
- A running EKS cluster. You can create one using the AWS Management Console or the AWS CLI.
- `kubectl` configured to communicate with your EKS cluster.
- `nginx` Ingress controller installed in your cluster. If not already installed, follow the [official nginx ingress installation guide](https://kubernetes.github.io/ingress-nginx/deploy/).

## Installation Steps

### Step 1: Create the Argo CD Namespace

Create a namespace specifically for Argo CD:

```sh
kubectl create namespace argocd
```

### Step 2: Create the Argo CD Deployment and Service Files

Create a YAML file named `argocd-basic.yml` to define the Argo CD deployment:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: ArgoCD
metadata:
  name: argocd
  namespace: argocd
  labels:
    app: argocd
spec: {}
```

Also, create a YAML file named `argocd-service.yml` for the Argo CD Ingress configuration:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: argocd-server-ingress
  namespace: argocd
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: argocd-server
            port:
              number: 443
```

### Step 3: Deploy Argo CD

Deploy the Argo CD components to your cluster:

```sh
kubectl apply -f argocd-basic.yml -n argocd
kubectl apply -f argocd-service.yml -n argocd
```

### Step 4: Verify the Deployment

Check the status of the deployed Ingress to ensure it is correctly set up and note any assigned addresses or ports:

```sh
kubectl describe ingress argocd-server-ingress -n argocd
```

### Step 5: Access Argo CD

Identify the external access point for Argo CD. If you are using an Ingress, find the load balancer or external URL provided:

```sh
kubectl get ingress -n argocd
```

Use the address provided under the `ADDRESS` column to access the Argo CD UI through your web browser. This address points to the nginx Ingress controller that routes traffic to your Argo CD service.


Certainly! Here is a continuation of the README instructions specifically designed for managing and retrieving secrets in an Argo CD environment within your EKS cluster. This section can be appended to your existing README to provide comprehensive guidance on handling secrets securely.

---

## Managing and Retrieving Secrets in Argo CD

Argo CD leverages Kubernetes secrets to store sensitive data required for its operation, such as repository credentials, application configurations, and more. Here's how you can retrieve and manage these secrets securely.

### Steps to Retrieve Secrets

#### Step 1: Identify Relevant Secrets

List all secrets in the Argo CD namespace to identify the ones related to your applications or configurations:

```sh
kubectl get secrets -n argocd
```

#### Step 2: Retrieve and Decode Secrets

Select the secret you need to inspect or modify. To view the contents of the secret in a readable format, retrieve it using `kubectl` and decode it from Base64:

JDJhJDEwJHNBbE1wREN0Lmpqc1NDT0FpZmNpMy5WdnYwblZiNWxOeHJLemlpUnBTZkdSNGpPOFUzRUpx

```sh
# Retrieve the secret and decode it
kubectl get secret <secret-name> -n argocd -o jsonpath="{.data}" | jq 'map_values(@base64d)'
```
or 

```sh
# Replace admin.password and decode it
echo admin.password | base64 -d
```

Replace `<secret-name>` with the name of your specific secret. This command uses `jq` to decode all base64-encoded values directly from the JSON output.

#### Step 3: Edit a Secret

If you need to update a secret, you can edit it directly using `kubectl`:

```sh
kubectl edit secret <secret-name> -n argocd
```

This command will open the secret in your default text editor. Make sure to encode your changes in Base64 before saving.

#### Step 4: Use Secrets in Argo CD Applications

When setting up applications in Argo CD that require sensitive information, reference these secrets directly in your Kubernetes manifests or Helm values to avoid hardcoding sensitive data:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  containers:
    - name: example-container
      image: example-image
      env:
        - name: SECRET_KEY
          valueFrom:
            secretKeyRef:
              name: <secret-name>
              key: <key-name>
```

### Best Practices for Secret Management

- **Limit Access**: Use Kubernetes RBAC to control who can access secrets in the `argocd` namespace. Only allow necessary read and/or write permissions.

- **Audit Regularly**: Regularly review and audit secrets and access policies to ensure only current and appropriate accesses are granted.

- **Use External Secret Management**: For enhanced security, consider integrating Argo CD with external secrets management solutions like HashiCorp Vault, AWS Secrets Manager, or others that provide robust access controls, secret rotation, and audit trails.

