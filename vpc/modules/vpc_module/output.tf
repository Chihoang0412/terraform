################################################################################
# Output modules
################################################################################
output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.main.id, null)
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = try(aws_vpc.main.arn, null)
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = try(aws_vpc.main.cidr_block, null)
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = try(aws_vpc.main.default_security_group_id, null)
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = try(aws_vpc.main.default_network_acl_id, null)
}

output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  value       = try(aws_vpc.main.owner_id, null)
}

################################################################################
# Subnets
################################################################################
output "subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.subnets[*].id
}
