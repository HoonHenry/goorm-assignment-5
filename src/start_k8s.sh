#!/bin/bash
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
#     sed -i.bak -e "s|your-ingress-group-name|$NAME|" ./wordpress-deployment.yaml && \
#     kubectl apply -k ./manifests
# fi
