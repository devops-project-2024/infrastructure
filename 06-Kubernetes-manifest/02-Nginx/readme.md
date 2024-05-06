# Installing NGINX Ingress Controller on Amazon EKS

This guide provides instructions on how to deploy the NGINX Ingress Controller on an Amazon EKS cluster to manage the ingress traffic for your applications.

## Prerequisites

- An active AWS account.
- An EKS cluster running. If you do not have a cluster, you can create one using the AWS Management Console or the AWS CLI.
- `kubectl` configured to communicate with your EKS cluster.
- `helm`, version 3.x or later, installed on your local machine.

## Installation Steps

### Step 1: Add the NGINX Ingress Controller Helm Repository

First, create NGINX manifest files :

```bash
vi nginx-deployment.yml
```

```yml 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
```


```bash
vi nginx-service.yml
```

```yml 
apiVersion: v1 
kind: Service
metadata:
  name: nginx-service
  labels:
    app: nginx
spec:
  selector:
    app: nginx
  ports:
    - name : http 
      port: 80
      protocol: TCP
      targetPort: 80
  type: LoadBalancer
```

### Step 2: Install the NGINX Ingress Controller


```bash
kubectl create namespace nginx-ingress 
kubectl apply -f nginx-deployment.yml -n nginx-ingress
kubectl apply -f nginx-service.yml -n nginx-ingress
```

This command deploys the NGINX Ingress Controller in the `nginx-ingress` namespace. The `controller.publishService.enabled=true` parameter ensures that the service fronting the NGINX Ingress Controller gets the external IP address assigned by the LoadBalancer.

### Step 3: Verify the Installation

Check that the NGINX Ingress Controller and service is running:

```bash
kubectl get pods -n nginx-ingress
```


You should see the NGINX Ingress Controller pod running.

### Step 4: Deploy a Test Application

To test if the NGINX Ingress Controller is working, copy the external Ip of the load balancer:

```bash
kubectl get svc -n nginx-ingress
```

