################################################################################
# VPC
################################################################################
variable "vpc" {
  description = "Config VPC"
  type = object({
    name             = string
    cidr_block       = string
    instance_tenancy = string
  })
  default = {
    name             = "vpc-sd-demo-va"
    cidr_block       = "192.170.0.0/16"
    instance_tenancy = "default"
  }
}

################################################################################
# Internet gateway
################################################################################
variable "igw" {
  description = "Config IGW"
  type        = string
  default     = "IGW-SD-DEMO-VA"
}

################################################################################
# Pulibc subnets
################################################################################
variable "subnets" {
  description = "Public subnets"
  type        = list(map(string))
  default = [
    {
      name       = "SN-SD-DEMO-PRIVATE0-VA-1a"
      cidr_block = "192.170.201.0/24"
      az         = "ap-northeast-1a",
    },
    {
      name       = "SN-SD-DEMO-PRIVATE0-VA-1c"
      cidr_block = "192.170.203.0/24"
      az         = "ap-northeast-1c",
    },
    {
      name       = "SN-SD-DEMO-FRONT0-VA-1c"
      cidr_block = "192.170.202.0/24"
      az         = "ap-northeast-1c"
    },
    {
      name       = "SN-SD-DEMO-FRONT0-VA-1a"
      cidr_block = "192.170.206.0/24"
      az         = "ap-northeast-1a"
    },
    {
      name       = "SN-SD-DEMO-BACK0-VA-1c"
      cidr_block = "192.170.200.0/24"
      az         = "ap-northeast-1c"
    },
    {
      name       = "SN-SD-DEMO-BACK0-VA-1a"
      cidr_block = "192.170.205.0/24"
      az         = "ap-northeast-1a"
    },
    {
      name       = "SN-SD-DEMO-MNG0-VA-1c"
      cidr_block = "192.170.204.0/24"
      az         = "ap-northeast-1c"
    },
    {
      name       = "SN-SD-DEMO-MNG0-VA-1a"
      cidr_block = "192.170.207.0/24"
      az         = "ap-northeast-1a"
    }
  ]
}

################################################################################
# Route tables
################################################################################
variable "route_table_associations" {
  description = "Route table assoctions"
  type        = list(map(string))
  default = [
    {
      route_table_name = "RT-SD-DEMO-PRIVATE0-VA"
      subnet_name      = "SN-SD-DEMO-PRIVATE0-VA-1a"
    },
    {
      route_table_name = "RT-SD-DEMO-PRIVATE1-VA"
      subnet_name      = "SN-SD-DEMO-PRIVATE0-VA-1c"
    },
    {
      route_table_name = "RT-SD-DEMO-FRONT0-VA"
      subnet_name      = "SN-SD-DEMO-FRONT0-VA-1c"
    },
    {
      route_table_name = "RT-SD-DEMO-FRONT0-VA"
      subnet_name      = "SN-SD-DEMO-FRONT0-VA-1a"
    },
    {
      route_table_name = "RT-SD-DEMO-BACK0-VA"
      subnet_name      = "SN-SD-DEMO-BACK0-VA-1c"
    },
    {
      route_table_name = "RT-SD-DEMO-BACK0-VA"
      subnet_name      = "SN-SD-DEMO-BACK0-VA-1a"
    },
    {
      route_table_name = "RT-SD-DEMO-MNG0-VA"
      subnet_name      = "SN-SD-DEMO-MNG0-VA-1c"
    },
    {
      route_table_name = "RT-SD-DEMO-MNG0-VA"
      subnet_name      = "SN-SD-DEMO-MNG0-VA-1a"
    }
  ]
}

variable "route_tables" {
  description = "Route tables"
  type        = list(map(string))
  default = [
    {
      name = "RT-SD-DEMO-PRIVATE0-VA"
    },
    {
      name = "RT-SD-DEMO-PRIVATE1-VA"
    },
    {
      name = "RT-SD-DEMO-FRONT0-VA"
    },
    {
      name = "RT-SD-DEMO-BACK0-VA"
    },
    {
      name = "RT-SD-DEMO-MNG0-VA"
    }
  ]
}

################################################################################
# EIP
################################################################################
variable "eips" {
  type    = list(string)
  default = ["eip-1", "eip-2"]
}

################################################################################
# Nat gateway
################################################################################
variable "natgw" {
  description = "Detail Nat gateway"
  type        = list(map(string))
  default = [
    {
      subnet_name = "SN-SD-DEMO-FRONT0-VA-1c"
      ngw_name    = "NGW-SD-DEMO-VA-1c"
    },
    {
      subnet_name = "SN-SD-DEMO-FRONT0-VA-1a"
      ngw_name    = "NGW-SD-DEMO-VA-1a"
    }
  ]
}

variable "create_route_nat_gateway" {
  description = "Exists route to nat gateway"
  type        = bool
  default     = true
}

variable "create_route_internet_gateway" {
  description = "Exists route to internet gateway"
  type        = bool
  default     = true
}

################################################################################
# Route table
################################################################################
variable "routes_ngw" {
  description = "List route"
  type        = list(map(string))
  default = [
    {
      route_table : "RT-SD-DEMO-PRIVATE0-VA"
      destination_cidr_block : "0.0.0.0/0"
      nat_gateway : "NGW-SD-DEMO-VA-1a"
    },
    {
      route_table : "RT-SD-DEMO-PRIVATE1-VA"
      destination_cidr_block : "0.0.0.0/0"
      nat_gateway : "NGW-SD-DEMO-VA-1c"
    }
  ]

}

variable "create_ingress_rules" {
  description = "Create inbound rules"
  type = bool
  default = true
}

variable "create_egress_rules" {
  description = "Create outbound rules"
  type = bool
  default = true
}

variable "routes_igw" {
  description = "List route"
  type        = list(map(string))
  default = [
    {
      route_table : "RT-SD-DEMO-FRONT0-VA"
      destination_cidr_block : "0.0.0.0/0"
      internet_gateway : "IGW-SD-DEMO-VA"
    },
    {
      route_table : "RT-SD-DEMO-MNG0-VA"
      destination_cidr_block : "0.0.0.0/0"
      internet_gateway : "IGW-SD-DEMO-VA"
    }
  ]

}

variable "security_groups" {
  description = "Security groups"
  type = list(object({
    name        = string
    description = string
    ingress_rules = list(object({
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress_rules = list(object({
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))

  default = [
    {
      name        = "SG-SD-DEMO-FRW-ALB-E"
      description = "Allow TLS inbound traffic"
      ingress_rules = [
        {
          description = "LVN"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["118.70.128.3/32"]
        },
        {
          description = "TLS from VPC"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["113.190.233.137/32"]
        }
      ]
      egress_rules = [
        {
          description = "LVN"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["118.70.128.3/32"]
        }
      ]

    },
    {
      name        = "SG-SD-DEMO-FRW-ECS"
      description = "Allow TLS inbound traffic"
      ingress_rules = [
        {
          description = "LVN"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["118.70.128.3/32"]
        },
        {
          description = "TLS from VPC"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["113.190.233.137/32"]
        }
      ]
      egress_rules = [
        {
          description = "LVN"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["118.70.128.3/32"]
        }
      ]

    }
  ]

}
