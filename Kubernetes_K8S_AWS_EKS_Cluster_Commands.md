# Kubernetes (K8S) AWS EKS Cluster Commands (Create AWS EKS Cluster) #

1) To Install kubectl on Jenkins Server 
```
$ sudo apt update
$ sudo apt install curl
$ curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
$ sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
$ kubectl version --client

```
2) To Install AWS Cli
```
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
$ sudo apt install unzip
$ unzip awscliv2.zip
$ sudo ./aws/install
$ aws --version

```
3) To Install  eksctl
```
$ curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
$ cd /tmp
$ sudo mv /tmp/eksctl /bin
$ eksctl version

```
4) To Setup Kubernetes using eksctl
```
eksctl create cluster --name virtualtechbox-cluster \
--region ap-south-1 \
--node-type t2.small \
--nodes 3 \

```
5) Verify Cluster with below command
```
$ kubectl get nodes

```
