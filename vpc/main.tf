################################################################################
# VPC Module
################################################################################

module "vpc" {
  source                        = "./modules/vpc_module"
  vpc                           = var.vpc
  subnets                       = var.subnets
  security_groups               = var.security_groups
  igw                           = var.igw
  eips                          = var.eips
  create_ingress_rules          = var.create_ingress_rules
  create_egress_rules           = var.create_egress_rules
  create_route_internet_gateway = var.create_route_internet_gateway
  create_route_nat_gateway      = var.create_route_nat_gateway
  natgw                         = var.natgw
  route_table_associations      = var.route_table_associations
  route_tables                  = var.route_tables
  routes_ngw                    = var.routes_ngw
  routes_igw                    = var.routes_igw
}
