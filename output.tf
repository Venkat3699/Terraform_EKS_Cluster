
# Outputs of all the Services.

output "Eks-Vpc" {
    value = "aws_vpc.Eks-Vpc.id"
    description = "Vpc ID ouput"
}

output "Eks-subnets-1" {
    value = "aws_subnet.public-1.id"
    description = "public-1 subnet output"
}

output "Eks-subnets-2" {
    value = "aws_subnet.public-2.id"
    description = "public-2 subnet output"
}

output "Eks-Igw" {
    value = "aws_internet_gateway.Eks-Igw.id"
    description = "Igw ID output"
}

output "Eks-Sgs" {
    value = "aws_security_group.Eks-Sg.id"
    description = "Output of Eks Security group"
}



output "Eks-Endpoints" {
    value = "aws_eks_cluster.EKS-Cluster.endpoint"
}