################################################################################
# variable locals, scope module VPC
################################################################################
locals {
  ################################################################################
  # variable locals for subnet
  ################################################################################
  subnets = {
    for subnet in aws_subnet.subnets : subnet.tags.Name => subnet.id
  }
  subnet_mappers = [
    for subnet in var.natgw : {
      subnet_id : lookup(local.subnets, subnet.subnet_name, null)
      ngw_name : subnet.ngw_name
    }
  ]

  ################################################################################
  # variable locals for routes, route -> internet_gateway, route -> nat_gateway
  ################################################################################
  nat_gateways = {
    for nat in try(aws_nat_gateway.nat_gateway, []) : nat.tags.Name => nat.id
  }

  route_tables = {
    for route in aws_route_table.route_tables : route.tags.Name => route.id
  }

  routes_ngw_mapper = [
    for route in (var.create_route_nat_gateway ? var.routes_ngw : []) :
    {
      route_table_id : lookup(local.route_tables, route.route_table, "")
      destination_cidr_block : route.destination_cidr_block
      nat_gateway_id : lookup(local.nat_gateways, route.nat_gateway, "")
    }
  ]

  routes_igw_mapper = [
    for route in (var.create_route_internet_gateway ? var.routes_igw : []) :
    {
      route_table_id : lookup(local.route_tables, route.route_table, "")
      destination_cidr_block : route.destination_cidr_block
      internet_gateway_id : aws_internet_gateway.internet_gateway[0].id
    }
  ]
}
