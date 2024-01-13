# goorm-assignment-5
This is for AWS EKS.

## Prerequisites
terraform cloud id
terraform organizaion name
terraform login
```
# mac OS
cd src
./setup_macos.sh

# linux(amd64)
cd src
./setup_linux.sh
```

## Set up the cluster
```
cd src
terraform init
terraform apply
aws eks update-kubeconfig --region $(terraform output -raw region) --name $(terraform output -raw cluster_name)
```

## destroy the cluster
```
cd src
./rm_all.sh
```