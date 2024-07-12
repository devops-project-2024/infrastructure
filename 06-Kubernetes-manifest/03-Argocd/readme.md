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

```sh 
vi argocd-basic.yml
```

```yaml
apiVersion: argoproj.io/v1beta1
kind: ArgoCD
metadata:
  name: argocd
  namespace: argocd
  labels:
    app: argocd
spec: {}
```

Also, create a YAML file named `argocd-service.yml` for the Argo CD Ingress configuration:

```sh 
vi argocd-service.yml
```

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: argocd-server-ingress
  namespace: argocd
spec:
  ingressClassName: nginx-service
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
kubectl apply -f argocd-basic.yml 
kubectl apply -f argocd-service.yml 
```

### Step 4: Verify the Deployment

Check the status of the deployed Ingress to ensure it is correctly set up and note any assigned addresses or ports:

```sh
kubectl edit svc argocd-server -n argocd
```

```sh
kubectl get svc argocd-server -n argocd
```

### Step 5: Access Argo CD

Identify the external access point for Argo CD. If you are using an Ingress, find the load balancer or external URL provided:

```sh
kubectl get ingress -n argocd
```

Use the address provided under the `ADDRESS` column to access the Argo CD UI through your web browser. This address points to the nginx Ingress controller that routes traffic to your Argo CD service.


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

```sh
# Retrieve the secret and decode it
kubectl get secret -n argocd
```
and 

```sh
kubectl edit secret argocd-cluster -n argocd
```

```sh 
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

### Role and Role-binding for argo CD


1. Create a Role in a file named `argo-role.yml`:
   
   ```sh
   vi argo-role.yml
   ```

```yml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: web-app  # Change this to the appropriate namespace
  name: argo-role     # Name of the Role
rules:
- apiGroups: [""]
  resources: ["pods", "deployments", "services"]  # Add other resources as needed
  verbs: ["get", "list", "watch", "create", "update", "delete"]
```

2. Apply the Role to the `web-app` namespace:

   ```bash
   kubectl apply -f argo-role.yml
   ```

3. Create a RoleBinding in a file named `argo-role-binding.yml`:
  
```sh
kubectl get serviceaccount -n argocd
kubectl get rolebindings,clusterrolebindings -n argocd --field-selector metadata.name=argocd-server
kubectl describe serviceaccount argocd-server -n argocd
```

  ```sh
   vi argo-role-binding.yml
  ```

   ```yaml
   apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: argo-role-binding
  namespace: web-app
subjects:
- kind: ServiceAccount
  name: argocd-argocd-server   # Replace with the actual service account used by ArgoCD
  namespace: argocd  # Assuming ArgoCD is deployed in the 'argocd' namespace
roleRef:
  kind: Role
  name: argo-role
  apiGroup: rbac.authorization.k8s.io

   ```

4. Apply the RoleBinding to bind the Role to the ArgoCD service account:

   ```bash
   kubectl apply -f argo-role-binding.yml
   ```

Replace `argo-role` and `argo-role-binding` with meaningful names for your RBAC objects, and ensure that you replace `argo-role.yaml` and `argo-role-binding.yaml` with the actual filenames you use.

After applying these RBAC changes, the ArgoCD service account should have the necessary permissions to manage resources in the `web-app` namespace. You can then try syncing again to see if the "Namespace 'web-app' for Deployment 'web-app' is not managed" error is resolved.