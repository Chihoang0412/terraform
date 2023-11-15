################################################################################
# COMMON VARIABLES
################################################################################

variable "tags" {}

variable "config-folder" {}
variable "polices_name_prefix" { default = "" }
variable "polices_create_flag" {
  type    = bool
  default = false
}
