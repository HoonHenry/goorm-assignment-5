#!/bin/bash
declare -A check_list
check_list["cluster_arn"]=$(terraform output -raw cluster_arn)

for key in "${check_list[@]}"; do
    if [ -z "$key" ]; then
      echo "$key is empty"
      exit 1
    fi
done

# Remove the namespace and all the resources
kubectl delete ns assignment && \
kubectl delete sc ebs-sc ebs-sc-mysql && \

# Remove the AWS EKS cluster info from the kubeconfig file
kubectl config unset current-context && \

# Remove the AWS EKS cluster info from the kubeconfig file
kubectl config delete-cluster ${cluster_arn} && \
kubectl config delete-context ${cluster_arn} && \
kubectl config delete-user ${cluster_arn} && \

# Destroy the Terraform resources from AWS
terraform destroy -auto-approve