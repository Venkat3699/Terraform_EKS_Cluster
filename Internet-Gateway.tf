
# Creating Internet Gateway for EKS Cluster

resource "aws_internet_gateway" "Eks-Igw" {
    vpc_id = aws_vpc.Eks-Vpc.id

    tags = var.tags

}