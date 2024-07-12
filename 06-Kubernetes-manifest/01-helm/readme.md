### Step 1: Add the Ingress-Nginx Repository to Helm

Before installing the NGINX Ingress Controller, you need to add the official ingress-nginx repository to Helm:


```sh
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```

### Step 2: Install NGINX Ingress Controller

Once the repository is added and updated, you can attempt to install the NGINX Ingress Controller again:

```sh
helm install nginx-ingress ingress-nginx/ingress-nginx --namespace kube-system --set controller.publishService.enabled=true
```

This command installs the NGINX Ingress Controller in the `ingress-nginx` namespace with the setting `controller.publishService.enabled=true`, which is used to enable the integration of the service with cloud provider’s load balancers.

### Optional: Check the Installation

After installation, you might want to verify that everything is running correctly:

```sh
kubectl get pods -n kube-system
```

### Step 1: Create the Ingress Resource

You'll define an Ingress resource to handle the path-based routing. This resource specifies rules that direct traffic to different services based on the URL path:

```sh
vi ingress-class.yml
```

```yml
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  name: nginx
spec:
  controller: k8s.io/ingress-nginx
```

kubectl create --save-config -f ingress-class.yaml

```sh
vi nginx-ingress.yml
```

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  namespace: argocd
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: argocd.a940eb1476ab44729a62d28d866fb9c1-935096736.us-east-1.elb.amazonaws.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: argocd-server
            port:
              number: 80


```


### Step 3: Apply the Ingress Resource

Apply the Ingress resource to your cluster by saving the above YAML to a file and running:

```sh
kubectl apply -f nginx-ingress.yml
```

### Step 4: Verify Your Configuration

After applying the Ingress, you can check its status with:

```sh
kubectl get ingress
```
