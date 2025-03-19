
# Creating Security Group for the EKS Cluster.

resource "aws_security_group" "Eks-Sg" {
    name        = "allow_tls"
    description = "Allow TLS inbound traffic"
    vpc_id      = aws_vpc.Eks-Vpc.id

    ingress {
        description      = "TLS from VPC"
        from_port        = var.from_port
        to_port          = var.to_port
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = var.tags
}