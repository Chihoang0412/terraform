locals {
  tags = {
    Name       = "${var.enviroment}-${var.project}"
    Enviroment = var.enviroment
    Terraform  = "true"
  }
}

provider "aws" {
  region = var.aws-region
}

################################################################################
# user group
################################################################################
locals {
  ## USER GROUP CONFIG VARIABLES
  group-config-root-foler = "${path.root}/${var.group-config-root-foler}"
}

module "user_group" {
  source = "./modules/user_group_module"

  count                   = length(var.user-group-list)
  user-group-name         = var.user-group-list[count.index]
  group-config-root-foler = local.group-config-root-foler
  tags                    = local.tags
}

################################################################################
# role
################################################################################
locals {
  ## ROLES CONFIG VARIABLES
  roles-config-root-foler = "${path.root}/${var.roles-config-root-foler}"
}

module "role" {
  source = "./modules/role_module"

  count                   = length(var.roles-list)
  role-name               = var.roles-list[count.index]
  roles-config-root-foler = local.roles-config-root-foler
  tags                    = local.tags
}
