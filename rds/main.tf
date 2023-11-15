
#defining the provider as aws
provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source                                      = "./modules/rds_vpc"

  vpc_name                                    = "VPC-SD-NDEV2-VA"
  vpc_cidr                                    = var.vpc_cidr
  subnet_count                                = var.subnet_count
  subnet_cidr                                 = var.subnet_cidr
  availability_zone                           = var.availability_zone
  subnet_name                                 = var.subnet_name
  security_group_name                         = "SG-SD-NDEV2-FRW-ECS"
}

#Create subnet group
module "subnet_group" { 
  source                                      = "./modules/rds_db_subnet_group"
  name                                        = "dsgsdfrwdbsnd2va00"
  subnet_ids                                  = module.vpc.subnet_ids
}

data "aws_rds_engine_version" "family" {
  engine   = var.settings.database.engine
  version  = var.settings.database.engine_version
}

module "db_cluster_parameter_group" {
  source                                      = "./modules/rds_db_parameter_group"
  name                                        = "dpgsdfrwdbsnd2va00"
  family                                      = data.aws_rds_engine_version.family.parameter_group_family
}

data "aws_partition" "current" {}

module "db_cluster" {
  source                                        = "./modules/rds_db_cluster"
  
  cluster_identifier                            = "sdfrwdbsnd2va01"
  engine                                        = var.settings.database.engine
  engine_version                                = var.settings.database.engine_version
  availability_zones                            = var.availability_zone
  db_cluster_instance_class                     = var.settings.database.instance_class
  db_cluster_parameter_group_name               = module.db_cluster_parameter_group.cluster_parameter_group_id

  database_name                                 = var.settings.database.db_name
  master_username                               = var.db_username
  master_password                               = var.db_password
  preferred_maintenance_window                  = "Wed:09:45-Wed:10:45"

  copy_tags_to_snapshot                         = true
  db_subnet_group_name                          = module.subnet_group.db_subnet_group_id
  vpc_security_group_ids                        = [module.vpc.db_security_group_id]
  
  backup_retention_period                       = 30
  preferred_backup_window                       = "09:10-09:40"
  }