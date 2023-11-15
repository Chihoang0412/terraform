################################################################################
# routes table
################################################################################
resource "aws_route" "routes_ngw" {
  count                  = var.create_route_nat_gateway ? length(local.routes_ngw_mapper) : 0
  route_table_id         = local.routes_ngw_mapper[count.index].route_table_id
  destination_cidr_block = local.routes_ngw_mapper[count.index].destination_cidr_block
  nat_gateway_id         = local.routes_ngw_mapper[count.index].nat_gateway_id
  depends_on             = [aws_route_table.route_tables]
}

resource "aws_route" "routes_igw" {
  count                  = var.create_route_internet_gateway ? length(local.routes_igw_mapper) : 0
  route_table_id         = local.routes_igw_mapper[count.index].route_table_id
  destination_cidr_block = local.routes_igw_mapper[count.index].destination_cidr_block
  gateway_id             = local.routes_igw_mapper[count.index].internet_gateway_id
  depends_on             = [aws_route_table.route_tables]
}

################################################################################
# Route tables
################################################################################
resource "aws_route_table" "route_tables" {
  count  = length(var.route_tables)
  vpc_id = aws_vpc.main.id

  tags = {
    Name : var.route_tables[count.index].name
  }
}
################################################################################
# association subnets to route table
################################################################################
resource "aws_route_table_association" "association_route_table" {
  count          = length(var.route_table_associations)
  subnet_id      = lookup(local.subnets, var.route_table_associations[count.index].subnet_name, null)
  route_table_id = lookup(local.route_tables, var.route_table_associations[count.index].route_table_name, null)
  depends_on     = [aws_route_table.route_tables]
}