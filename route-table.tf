
# Creating Route Table For EKS

resource "aws_route_table" "Eks-Route" {
    vpc_id = aws_vpc.Eks-Vpc.id

    route {
        cidr_block = var.route
        gateway_id = aws_internet_gateway.Eks-Igw.id
    }

    tags = var.tags
}