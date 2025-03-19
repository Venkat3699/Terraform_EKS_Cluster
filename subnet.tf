
# Creating Subnets for the EKS Cluster

resource "aws_subnet" "public-1" {
    cidr_block = var.public-cidr-1
    map_public_ip_on_launch = var.public-ip
    vpc_id = aws_vpc.Eks-Vpc.id
    availability_zone = var.public1-azs

    tags = var.tags
}

resource "aws_subnet" "public-2" {
    cidr_block = var.public-cidr-2
    map_public_ip_on_launch = var.public-ip
    vpc_id = aws_vpc.Eks-Vpc.id
    availability_zone = var.public2-azs

    tags = var.tags
}