#!/bin/bash
terraform_cluster_arn=$(terraform output -raw cluster_arn)

# if the current context of the local ~/.kube/config is not configured
# or the current context is not identical with the Terraform cluster arn,
# then update/switch the the cluster to the kubectl for the AWS EKS cluster
if [[ $(kubectl config current-context) -ne 0 ]] || \
    [[ $(kubectl config current-context) != $terraform_cluster_arn ]]; then
    echo "Switching to cluster"

    aws eks update-kubeconfig \
        --region $(terraform output -raw region) \
        --name $(terraform output -raw cluster_name)

    echo "Cluster switched"
fi
echo "The current context of the local machine: $(kubectl config current-context)"

#nodes=$(kubectl get node -o name | head -n 2)
#
#i=1
#for node in $nodes; do
#    if [ "$i" -eq 1 ]; then
#        kubectl label $node app=db
#    else
#        kubectl label $node app=was
#    fi
#    i=$((i + 1))
#done

if ! kubectl get namespace assignment > /dev/null 2>&1; then
    echo "Creating namespace assignment"
    kubectl create ns assignment
fi
kubectl apply -k ./manifests

# if [ -z "$1" ]; then
#     echo "No name provided"
# else
#     NAME=$1
#     echo "Creating $NAME for the ingress group name"
#     sed -i.bak -e "s|your-ingress-group-name|$NAME|" ./manifests/wordpress/deployment.yaml && \
#     kubectl apply -k ./manifests
# fi
