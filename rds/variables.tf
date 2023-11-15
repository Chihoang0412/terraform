################################################################################
# COMMON VARIABLES
################################################################################

variable "aws_region" {
  description = "aws work with region"
  type        = string
  default     = "ap-northeast-1"
}

variable "settings" {
  description = "Configuration settings"
  type        = map(any)
  default     = {
    "database"  = {
      engine            = "aurora-mysql"
      engine_version    = "5.7.mysql_aurora.2.07.9"
      storage_type      = "io1"
      allocated_storage = 100
      instance_class    = "db.t2.medium"
      db_name           = "magento"
    }
  }
}

variable "db_username" {
  description = "Database master user"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database master user password"
  type        = string
  sensitive   = true
}

variable "vpc_cidr" {
  description = "CIDR for creating the VPC"
  type        = string
  default     = "192.170.0.0/16"
}

variable "subnet_count" {
  description = "Number of subnets."
  type        = number
  default     = 2
}

variable "subnet_cidr" {
  description = "Available cidr blocks for subnets."
  type        = list(string)
  default     = [
    "192.170.200.0/24",
    "192.170.201.0/24",
  ]
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = list(string)
  default     = [
    "ap-northeast-1a",
    "ap-northeast-1c",
  ]
}

variable "subnet_name" {
  description = "Subnet name blocks for private subnets."
  type        = list(string)
  default     = [
    "subnet-04dde4f4427c5a0e9",
    "subnet-0e9b32022680cd0f4",
  ]
}