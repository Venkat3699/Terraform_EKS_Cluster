
# Create an VPC

resource "aws_vpc" "Eks-Vpc" {
    cidr_block = var.cidr_block
    instance_tenancy = var.instance_tenancy
    enable_dns_support = var.dns

    tags = var.tags
}