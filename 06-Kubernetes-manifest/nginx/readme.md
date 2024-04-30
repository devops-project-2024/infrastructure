# Installing NGINX Ingress Controller on Amazon EKS

This guide provides instructions on how to deploy the NGINX Ingress Controller on an Amazon EKS cluster to manage the ingress traffic for your applications.

## Prerequisites

- An active AWS account.
- An EKS cluster running. If you do not have a cluster, you can create one using the AWS Management Console or the AWS CLI.
- `kubectl` configured to communicate with your EKS cluster.
- `helm`, version 3.x or later, installed on your local machine.

## Installation Steps

### Step 1: Add the NGINX Ingress Controller Helm Repository

First, add the NGINX Ingress Controller repository to your Helm repositories:

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```

### Step 2: Install the NGINX Ingress Controller

Use Helm to install the NGINX Ingress Controller:

```bash
kubectl create namespace ingress-nginx
helm install nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-nginx --set controller.publishService.enabled=true
```

This command deploys the NGINX Ingress Controller in the `ingress-nginx` namespace. The `controller.publishService.enabled=true` parameter ensures that the service fronting the NGINX Ingress Controller gets the external IP address assigned by the LoadBalancer.

### Step 3: Verify the Installation

Check that the NGINX Ingress Controller is running:

```bash
kubectl get pods -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx --watch
```

You should see the NGINX Ingress Controller pod running.

### Step 4: Deploy a Test Application

To test if the NGINX Ingress Controller is working, deploy a simple demo application:

```bash
kubectl create deployment demo --image=nginxdemos/hello --namespace ingress-nginx
kubectl expose deployment demo --port=80 --target-port=80 --name=demo-service --namespace ingress-nginx
```

### Step 5: Configure Ingress Resource

Create an Ingress resource to expose the demo application:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: demo-ingress
  namespace: ingress-nginx
spec:
  rules:
  - http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: demo-service
            port:
              number: 80
```

Apply this configuration using `kubectl`:

```bash
kubectl apply -f demo-ingress.yaml
```

### Step 6: Access the Application

Find the external IP of the NGINX Ingress Controller:

```bash
kubectl get svc -n ingress-nginx
```

Look for the external IP of the `nginx-ingress-ingress-nginx-controller` service. Use this IP address in your browser to access the deployed demo application.

## Cleanup

To remove the installed resources, run:

```bash
helm uninstall nginx-ingress -n ingress-nginx
kubectl delete namespace ingress-nginx
```

## Conclusion

You have successfully deployed the NGINX Ingress Controller in your EKS cluster and tested it with a demo application. This setup can be adapted to manage ingress traffic for any application running within your EKS environment.

