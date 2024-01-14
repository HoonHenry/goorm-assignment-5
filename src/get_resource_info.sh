#!/bin/bash
#kubectl get node -l app=db --show-labels=true && \
#kubectl get node -l app=was --show-labels=true && \
kubectl get all -n assignment -o wide
kubectl get ing -n assignment -o wide
# kubectl describe ing -n assignment
# kubectl describe hpa -n assignment
# kubectl get pod -n assignment
# kubectl top pod -n assignment