#!/bin/bash
#################### terraform settings ###################
# for ubuntu/debian, amd64
sudo apt-get update && \

sudo apt-get install -y gnupg software-properties-common && \

wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg && \

gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint && \

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list && \

sudo apt update && \

sudo apt-get install terraform && \

terraform version && \
#################### terraform settings ###################


#################### aws cli settings ###################
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \

sudo apt install -y zip && \

unzip awscliv2.zip && \

sudo ./aws/install && \

export PATH=/usr/local/bin:$PATH && \

source ~/.bashrc && \

aws --version && \

rm -rf ./aws awscliv2.zip && \
#################### aws cli settings ###################


#################### kubectl settings ###################
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.5/2024-01-04/bin/linux/amd64/kubectl && \

curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.5/2024-01-04/bin/linux/amd64/kubectl.sha256 && \

sha256sum -c kubectl.sha256 && \

openssl sha1 -sha256 kubectl && \

sudo mv -v ./kubectl /usr/local/bin/kubectl && \

sudo chmod +x /usr/local/bin/kubectl && \

kubectl version --client && \

rm kubectl.sha256 && \
#################### kubectl settings ###################


#################### eksctl settings ###################
# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH="amd64" && \
PLATFORM=$(uname -s)_$ARCH && \
echo $PLATFORM && \

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz" && \

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | \
    grep $PLATFORM | \
    sha256sum --check && \

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && \

rm eksctl_$PLATFORM.tar.gz && \

sudo mv -v /tmp/eksctl /usr/local/bin && \

eksctl version
#################### eksctl settings ###################
