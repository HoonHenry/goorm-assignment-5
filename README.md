# goorm-assignment-5

This is for AWS EKS.
This version works in MacOS(arm64, local machine), and linux(aws Ubuntu 20.04/22.04, amd64)
updated 2024.01.14.03:19AM(KST)

## Prerequisites

1. prepare a new terraform cloud id if you don't have one
2. register a terraform organizaion name in the terraform cloud
3. install aws cli
4. install kubectl (please double-check the version and the architecture, such as amd64, arm64 etc., in shell script)
5. install eksctl (please double-check the architecture, such as amd64, arm64 etc., in shell script)
6. register the terraform token from the terraform cloud
7. register the aws access token into the aws configure
8. update aws eks credentials

```bash
#!/bin/bash
# move to the root directory
cd src

# if using mac OS
./setup_macos.sh # or run a few command that you need from the script file

# if using linux(amd64, ubuntu 20.04)
./setup_linux.sh # or run a few command that you need from the script file
```

## Set up the cluster

```bash
#!/bin/bash
# register the aws access token
aws configure

# run the terrafrom
terraform apply -auto-approve

# update aws eks credentials
aws eks update-kubeconfig --region $(terraform output -raw region) --name $(terraform output -raw cluster_name)

# run the k8s
./start_k8s.sh

# (optional) setup the metrics server
./setup_metrics_server.sh
```

## destroy the cluster

```bash
#!/bin/bash
cd src

# remove the namespace that includes all the k8s
# and remove the aws eks credentials
# and destroy terraform
./rm_all.sh
```
