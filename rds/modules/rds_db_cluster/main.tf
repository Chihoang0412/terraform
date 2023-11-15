resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier              = var.cluster_identifier
  engine                          = var.engine
  engine_version                  = var.engine_version
  availability_zones              = var.availability_zones
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  
  database_name                   = var.database_name
  master_username                 = var.master_username
  master_password                 = var.master_password

  db_subnet_group_name            = var.db_subnet_group_name
  vpc_security_group_ids          = var.vpc_security_group_ids
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  backup_retention_period         = var.backup_retention_period
  skip_final_snapshot             = var.skip_final_snapshot
  preferred_backup_window         = var.preferred_backup_window
}

resource "aws_rds_cluster_instance" "cluster_instance" {
  count                = 2
  identifier           = "${var.cluster_identifier}${count.index}"
  engine               = var.engine
  engine_version       = var.engine_version
  availability_zone    = var.availability_zones[count.index]
  preferred_maintenance_window    = var.preferred_maintenance_window

  cluster_identifier   = "${aws_rds_cluster.rds_cluster.id}"
  instance_class       = var.db_cluster_instance_class
  db_subnet_group_name = var.db_subnet_group_name
}

resource "aws_db_option_group" "option_group" {
  name                     = "aurora-mysql-5-7"
  engine_name              = var.engine
  major_engine_version     = "5.7"

}


# # Create an RDS maintenance window
# data "aws_db_maintenance_window" "example" {
#   name     = "example-maintenance-window"
#   duration = 30 # The duration is in minutes (30 minutes)

#   # Writer window: Monday (1) 16:36 - 17:06 UTC+7
#   # Writer is identified by "writer"
#   maintenance_window_start_time {
#     day_of_week = 1 # Monday
#     start_time  = "16:36"
#     end_time    = "17:06"
#     apply_only_to = ["writer"]
#   }

#   # Reader window: Monday (1) 11:50 - 12:20 UTC+7
#   # Reader is identified by "reader"
#   maintenance_window_start_time {
#     day_of_week = 1 # Monday
#     start_time  = "11:50"
#     end_time    = "12:20"
#     apply_only_to = ["reader"]
#   }

#   allow_cancellation = true # Allow users to cancel RDS maintenance operations
# }