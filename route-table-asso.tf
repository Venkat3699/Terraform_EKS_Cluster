
# Creating Route Table association for EKS Cluster with IGW.

resource "aws_route_table_association" "Eks-Rta-1" {
    subnet_id = aws_subnet.public-1.id
    route_table_id = aws_route_table.Eks-Route.id

}

resource "aws_route_table_association" "Eks-Rta-2" {
    subnet_id = aws_subnet.public-2.id
    route_table_id = aws_route_table.Eks-Route.id
}
