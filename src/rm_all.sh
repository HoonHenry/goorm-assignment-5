#!/bin/bash
region=$(terraform output -raw region)
cluster_name=$(terraform output -raw cluster_name)
check_list=($region, $cluster_name)
for i in "${check_list[@]}"; do
    if [ -z "$i" ]; then
      echo "data is empty"
      exit 1
    fi
done

kubectl delete ns assignment && \
kubectl delete config ${cluster_name}
terraform destroy -auto-approve && \