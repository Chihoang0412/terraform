output "cluster_parameter_group_id" {
  description = "The db parameter group id"
  value       = try(aws_rds_cluster_parameter_group.this[0].id, "")
}

output "cluster_parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = try(aws_rds_cluster_parameter_group.this[0].arn, "")
}


output "db_parameter_group_id" {
  description = "The db parameter group id"
  value       = try(aws_db_parameter_group.this[0].id, "")
}

output "db_parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = try(aws_db_parameter_group.this[0].arn, "")
}