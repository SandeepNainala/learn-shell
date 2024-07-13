#!/bin/bash

# Set variables
AMI_ID="ami-041e2ea9402c46c32"      # Replace with your AMI ID
INSTANCE_TYPE="t3.micro"            # Replace with your instance type           # Replace with your key pair name
SECURITY_GROUP="sg-052d406550420b45d"  # Replace with your security group ID
SUBNET_ID="subnet-0c9a0fc0e56365b3c"  # Replace with your subnet ID
TAG_NAME="workstation"              # Tag for identifying the instance

# User data script to install eksctl and kubectl
USER_DATA=$(cat <<EOF
#!/bin/bash
# Update the package repository
sudo yum update -y

# Install AWS CLI v2
sudo yum install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Install kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin

# Verify installation
eksctl version
kubectl version --client
EOF
)

# Launch EC2 instance
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-group-ids $SECURITY_GROUP \
    --subnet-id $SUBNET_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$TAG_NAME}]" \
    --user-data "$USER_DATA" \
    --query 'Instances[0].InstanceId' \
    --output text)

# Output the instance ID
echo "Instance ID: $INSTANCE_ID"

# Wait for the instance to be in the 'running' state
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

# Get the public DNS name of the instance
INSTANCE_PUBLIC_DNS=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicDnsName' --output text)

# Output the public DNS name
echo "Instance Public DNS: $INSTANCE_PUBLIC_DNS"
