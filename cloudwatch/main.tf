provider "aws" {
  region = var.aws-region
}

locals {

  tags = {
    Name       = "${var.enviroment}-${var.project}"
    Enviroment = var.enviroment
    Terraform  = "true"
  }
}

################################################################################
# log_group
################################################################################
module "log_group" {
  source = "./modules/log_group_module"

  log-groups-config-data = var.log-groups-config-data

  tags = local.tags
}

################################################################################
# ecs_autoscaling_alarm_module
################################################################################

module "ecs_autoscaling_alarm_module" {
  source = "./modules/ecs_autoscaling_alarm_module"

  scale-target                  = var.scale-target
  ecs-metric-alarms-config-data = var.ecs-metric-alarms-config-data

  tags = local.tags
}

