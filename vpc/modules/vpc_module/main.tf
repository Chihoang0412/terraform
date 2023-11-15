################################################################################
# VPC
################################################################################
resource "aws_vpc" "main" {
  cidr_block       = var.vpc.cidr_block
  instance_tenancy = var.vpc.instance_tenancy

  tags = {
    Name = var.vpc.name
  }
}