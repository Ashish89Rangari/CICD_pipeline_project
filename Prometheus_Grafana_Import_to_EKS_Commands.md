# Prometheus_Grafana_Import_to_EKS_Commands #

1) To Install Helm 
```
$ sudo snap install helm --classic,    $ helm version
                    OR
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh
$ helm version

```
2) To Install Prometheus on EKS
```
$ helm repo add stable https://charts.helm.sh/stable          ///We need to add the Helm Stable Charts for our local client

$ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts     ///Add Prometheus Helm repo

$ kubectl create namespace prometheus            ///Create Prometheus namespace

$ helm install stable prometheus-community/kube-prometheus-stack -n prometheus      ///Install Prometheus

$ kubectl get pods -n prometheus          ///To check whether Prometheus is installed

$ kubectl get svc -n prometheus           ///to check the services file (svc) of the Prometheus

```
3) To expose Prometheus to the external world using LoadBalancer
```
$ kubectl edit svc stable-kube-prometheus-sta-prometheus -n prometheus    ///type:LoadBalancer, change port & targetport to 9090, save and close

$ kubectl get svc -n prometheus    //copy dns name of LB and browse with 9090

```

