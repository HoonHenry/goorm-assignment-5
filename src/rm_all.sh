#!/bin/bash
cluster_arn=$(terraform output -raw cluster_arn)
check_list=($cluster_arn)
for i in "${check_list[@]}"; do
    if [ -z "$i" ]; then
      echo "data is empty"
      exit 1
    fi
done

kubectl delete ns assignment && \
kubectl config unset current-context && \
kubectl config delete-cluster ${cluster_arn} && \
kubectl config delete-context ${cluster_arn} && \
kubectl config delete-user ${cluster_arn} && \
terraform destroy -auto-approve && \