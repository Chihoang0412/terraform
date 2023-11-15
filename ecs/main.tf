provider "aws" {
  region = var.aws-region
}

locals {
  cluster-config-data = { for cluster in var.ecs-config-data : cluster.cluster-name => cluster }

  tags = {
    Name       = "${var.enviroment}-${var.project}"
    Enviroment = var.enviroment
    Terraform  = "true"
  }
}

###################################################
### CREATE ECS CLUSTER
###################################################
module "ecs_cluster" {

  source               = "./modules/ecs_cluster_module"
  clusters-config-data = local.cluster-config-data

  tags = local.tags
}

###################################################
### CREATE ECS SERVICE
###################################################
locals {
  created-cluster-names = toset([for key, value in module.ecs_cluster.clusters-info : key])
}

module "ecs_service" {
  source = "./modules/ecs_service_module"

  for_each = local.created-cluster-names

  cluster-arn      = module.ecs_cluster.clusters-info[each.key].arn
  cluster-services = local.cluster-config-data[each.key].services

  tags = local.tags

  depends_on = [module.ecs_cluster]
}
