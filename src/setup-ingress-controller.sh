#!/bin/bash
#################### eksctl settings ###################
# curl --silent --location "https://github.com/eksctl-io/eksctl/releases/download/v0.167.0/eksctl_Darwin_arm64.tar.gz" | tar xz -C /tmp && \
# sudo mv -v /tmp/eksctl /usr/local/bin && \
# eksctl version && \
#################### eksctl settings ###################


#################### Environment variables settings ###################
AWS_REGION=$(aws configure get region)
ACCOUNT_ID=$(aws sts get-caller-identity | jq -r '.Account')
CLUSTER_NAME=$(terraform output -raw cluster_name)
LOAD_BALANCER_POLICY_NAME=LB-Ctl-IAMPolicy-${CLUSTER_NAME}
echo $AWS_REGION $ACCOUNT_ID $CLUSTER_NAME $LOAD_BALANCER_POLICY_NAME
check_list=(
	$AWS_REGION, $ACCOUNT_ID, $CLUSTER_NAME, $LOAD_BALANCER_POLICY_NAME,
)
idx=0
for obj in "${check_list[@]}"; do
	if [ -z "$obj" ]; then
		echo $idx has no valid value ${check_list[$idx]}
		exit 1
	fi
	((idx++))
done
#################### Environment variables settings ###################


#################### Cluster settings ###################
# update kubeconfig to use the cluster
aws eks --region ${AWS_REGION} update-kubeconfig \
    --name ${CLUSTER_NAME} && \

mkdir -p manifests/alb-ingress-controller && cd manifests/alb-ingress-controller && \
pwd &&

# create an IAM Policy to grant to the AWS Load Balancer Controller
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json && \
aws iam create-policy \
    --policy-name ${LOAD_BALANCER_POLICY_NAME} \
    --policy-document file://iam_policy.json && \

# create ServiceAccount for AWS Load Balancer Controller
eksctl create iamserviceaccount \
    --cluster ${CLUSTER_NAME} \
    --namespace kube-system \
    --name aws-load-balancer-controller \
    --attach-policy-arn arn:aws:iam::${ACCOUNT_ID}:policy/${LOAD_BALANCER_POLICY_NAME} \
    --override-existing-serviceaccounts \
    --approve && \

# add AWS Load Balancer controller to the cluster
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml && \
echo "applied cert-manager.yaml" && \

# download Load balancer controller yaml file
curl -Lo v2_5_4_full.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.5.4/v2_5_4_full.yaml && \
echo "downloaded v2_5_4_full.yaml" && \

# remove the ServiceAccount section in the manifest
sed -i.bak -e '596,604d' $(pwd)/v2_5_4_full.yaml && \

# replace cluster name in the Deployment spec section
sed -i.bak -e "s|your-cluster-name|$CLUSTER_NAME|" $(pwd)/v2_5_4_full.yaml && \
grep "\-\-cluster\-name" ./v2_5_4_full.yaml && \
echo "updated v2_5_4_full.yaml" && \

# deploy AWS Load Balancer controller file
kubectl apply -f v2_5_4_full.yaml && \
echo "apply v2_5_4_full.yaml" && \

# download the IngressClass and IngressClassParams manifest to the cluster and apply the manifest to the cluster.
curl -Lo v2_5_4_ingclass.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.5.4/v2_5_4_ingclass.yaml && \
echo "downloaded v2_5_4_ingclass.yaml" && \

kubectl apply -f v2_5_4_ingclass.yaml && \
echo "apply v2_5_4_ingclass.yaml" && \

# check that the deployment is successed and the controller is running and service account has been created
kubectl get deployment -n kube-system aws-load-balancer-controller && \
kubectl get sa aws-load-balancer-controller -n kube-system -o yaml && \

# detailed property values
kubectl logs -n kube-system $(kubectl get po -n kube-system | egrep -o "aws-load-balancer[a-zA-Z0-9-]+") && \
ALBPOD=$(kubectl get pod -n kube-system | egrep -o "aws-load-balancer[a-zA-Z0-9-]+") && \

kubectl describe pod -n kube-system ${ALBPOD} && \
#################### Cluster settings ###################


#################### metric server settings ###################
# kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml && \
kubectl apply -f components.yaml && \
kubectl get deployment metrics-server -n kube-system
#################### metric server settings ###################
