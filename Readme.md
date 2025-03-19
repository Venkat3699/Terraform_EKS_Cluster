
# To Create an EKS Cluster the pre-requisites are:

    1) Create a VPC
    2) Create a Subnets for public
    3) Create an Internet Gateway
    4) Create a Route Table for IGW
    5) Create a Route Table Association for Subnets
    6) Create a Security Group for SSH Connection
    7) Create an EKS Cluster along with one EC2 Instance.

# Install AWS Cli 

    sudo apt update

    sudo apt  install awscli 

# Provide your credentials like: 

    aws configure

    provide access_key

    provide secret_key

    region of Eks Cluster

==> Run This commands also

# After Successfully Creation of EKS Cluster

==> Install Kubectl Commands in the Kubelet Server

    curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.17/2023-11-14/bin/linux/amd64/kubectl

    sha256sum -c kubectl.sha256

    openssl sha1 -sha256 kubectl

    chmod +x ./kubectl

    mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH

    kubectl version --short --client

==> Run This commands also

    aws eks --region ap-south-1 describe-cluster --name <Cluster-Name> --query cluster.status

    aws eks --region ap-south-1 update-kubeconfig --name <Cluster-Name>
    
    kubectl get nodes