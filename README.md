# goorm-assignment-5

This is for AWS EKS.
This version works in MacOS(arm64, local machine), and linux(aws Ubuntu 20.04/22.04, amd64)
updated 2024.01.14.03:19AM(KST)

## Prerequisites

1. Prepare a new terraform cloud id if you don't have one
2. Register a terraform organizaion name, named as "semi-project", in the terraform cloud
    1) At the general setting of the registerd organization, please select the default execute mode as "local"
    2) Update the setting
3. Install aws cli
4. Install kubectl (please double-check the version and the architecture, such as amd64, arm64 etc., in shell script)
5. Install eksctl (please double-check the architecture, such as amd64, arm64 etc., in shell script)
6. Register the terraform token from the terraform cloud
7. Register the aws access token into the aws configure
8. Update aws eks credentials

```bash
#!/bin/bash
# Move to the root directory
cd goorm-assignment-5/src

# If using mac OS
# In the bare-metal
./setup_macos.sh # or run a few command that you need from the script file

# If using linux(amd64, ubuntu 20.04)
# In the bare-metal
./setup_linux.sh # or run a few command that you need from the script file
```

## Set up the cluster

```bash
#!/bin/bash
# Move to the root folder
cd goorm-assignment-5/src

# Login into the terraform cloud
terraform login

# Initialize the terraform
terraform init

# Register the AWS access token if you don't have one
aws configure

# Run the terrafrom
terraform apply -auto-approve

# Update aws eks credentials into the local machine/aws instance
# This will allows you to access/control the cluster in AWS EKS
aws eks update-kubeconfig --region $(terraform output -raw region) --name $(terraform output -raw cluster_name)

# Run the k8s
./start_k8s.sh

# (Optional) Setup the metrics server
./setup_metrics_server.sh
```

## Destroy the entire cluster including k8s

```bash
#!/bin/bash
cd goorm-assignment-5/src

# Remove the namespace that includes all the k8s
# and remove the aws eks credentials
# and destroy terraform
./rm_all.sh
```
