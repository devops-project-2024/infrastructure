## Join EKS Cluster 

```sh
aws eks update-kubeconfig --name my-eks-cluster --region us-east-1
```
```sh
kubectl get nodes
```

## Install Operator Lifecycle Manager (OLM), a tool to help manage the Operators running on your cluster.

```sh
sudo curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v0.27.0/install.sh | bash -s v0.27.0
```

## Install Operator Lifecycle Manager (OLM) tool for ArgoCD.

```sh                      
kubectl create -f https://operatorhub.io/install/argocd-operator.yaml
```
```sh 
kubectl get all -n operators
```

## Create and deploy ArgoCD Deployment File 

Create Argo CD deploymeny file 

```bash 
vi argocd-basic.yml
```

```yml 
apiVersion: argoproj.io/v1beta1
kind: ArgoCD
metadata:
  name: argocd
  labels:
    example: basic
spec: {}
```

deploy to argocd namespace 

```sh 
kubectl apply -f argocd-basic.yml -n argocd
```


kubectl create -f https://operatorhub.io/install/grafana-operator.yaml

kubectl create -f https://operatorhub.io/install/prometheus.yaml

kubectl get all  -n operators


Create Argo CD deploymeny file 

```yml 
apiVersion: argoproj.io/v1beta1
kind: ArgoCD
metadata:
  name: example-argocd
  labels:
    example: basic
spec: {}
```

deploy to argocd namespace 

```sh 
kubectl apply -f argocd-basic.yml -n argocd
```

get services 
```sh
kubectl get svc -n argocd
```

edit service to nodeport             
