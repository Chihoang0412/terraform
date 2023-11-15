################################################################################
# COMMON VARIABLES
################################################################################
variable "enviroment" {
  description = "enviroment"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "project"
  type        = string
  default     = "terraform-iam"
}

variable "aws-region" {
  description = "aws work with region"
  type        = string
  default     = "ap-northeast-1"
}


################################################################################
# USER GROUP VARIABLES
################################################################################

variable "user-group-list" {
  description = "create user group"
  type        = list(string)
}

variable "group-config-root-foler" {
  description = "create user group config folder"
  type        = string
}


################################################################################
# ROLES VARIABLES
################################################################################

variable "roles-list" {
  description = "roles list"
  type        = list(string)
}

variable "roles-config-root-foler" {
  description = "roles config root foler"
  type        = string
}