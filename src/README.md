# goorm-assignment-5
This is for AWS EKS.

## Prerequisites
terraform cloud id
terraform organizaion name
terraform login
aws cli
kubectl (please check the version and the architecture, such as amd64, arm64 etc)
eksctl (please check the architecture, such as amd64, arm64 etc)
```
# mac OS
cd src
./setup_macos.sh # or run a few command that you need from the script file

# linux(amd64)
cd src
./setup_linux.sh # or run a few command that you need from the script file
```

## Set up the cluster
```
cd src
terraform init
terraform apply
aws eks update-kubeconfig --region $(terraform output -raw region) --name $(terraform output -raw cluster_name)
./start_k8s.sh

# (optional) setup the metrics server
./setup_metrics_server.sh
```

## destroy the cluster
```
cd src
./rm_all.sh
```