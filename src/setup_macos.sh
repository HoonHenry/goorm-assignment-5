#!/bin/zsh
#################### terraform settings ###################
brew tap hashicorp/tap && \

brew install hashicorp/tap/terraform && \

brew update && \

brew upgrade hashicorp/tap/terraform && \
#################### terraform settings ###################


#################### aws cli settings ###################
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg" && \
sudo installer -pkg ./AWSCLIV2.pkg -target / && \
which aws && \
aws --version && \
#################### aws cli settings ###################


#################### kubectl settings ###################
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.5/2024-01-04/bin/darwin/amd64/kubectl && \

curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.5/2024-01-04/bin/darwin/amd64/kubectl.sha256 && \

openssl sha1 -sha256 kubectl && \

sudo mv -v kubectl /usr/local/bin/ && \

chmod +x /usr/local/bin/kubectl && \

kubectl version --client=true --short=true && \
#################### kubectl settings ###################


#################### eksctl settings ###################
# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=arm64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz" && \

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check && \

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz && \

sudo mv /tmp/eksctl /usr/local/bin && \
eksctl version
#################### eksctl settings ###################
