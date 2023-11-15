################################################################################
# Internet gateway
################################################################################
resource "aws_internet_gateway" "internet_gateway" {
  count = var.create_route_internet_gateway ? 1 : 0
  vpc_id = aws_vpc.main.id

  tags = {
    Name = try(var.igw, "igw-${aws_vpc.main.id}")
  }
}

################################################################################
# Nat gateway
################################################################################
resource "aws_eip" "eips" {
  count = length(var.eips)

  vpc = true

  tags = {
    Name = try(var.eips[count.index], "eip-${count.index}")
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = var.create_route_nat_gateway ? length(local.subnet_mappers) : 0
  allocation_id = aws_eip.eips[count.index].id
  subnet_id     = local.subnet_mappers[count.index].subnet_id

  tags = {
    Name = local.subnet_mappers[count.index].ngw_name
  }

  depends_on = [aws_eip.eips]
}
