################################################################################
# Subnets
################################################################################
resource "aws_subnet" "subnets" {
  count             = length(var.subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets[count.index].cidr_block
  availability_zone = var.subnets[count.index].az

  depends_on = [aws_vpc.main]
  tags = {
    Name = var.subnets[count.index].name
  }
}
