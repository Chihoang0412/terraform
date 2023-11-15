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
  default     = "terraform-sns"
}

variable "aws-region" {
  description = "aws work with region"
  type        = string
  default     = "ap-northeast-1"
}

################################################################################
# SNS-topic config VARIABLES
################################################################################

variable "topic-config-data" {
  type = list(object({
    name = string
    policies = object({
      add-default-policy = optional(bool, true) # add default policy flag
      custom-policies = list(object({
        sid     = string
        effect  = optional(string, "Allow")
        actions = list(string)
        principals = object({
          type        = string
          identifiers = optional(list(string), ["*"])
        })
      }))
    })
    subscriptions = optional(list(object({
      protocol  = optional(string, "email")
      end-point = string
    })), [])
  }))

  default = [
    {
      name = "SNT-SD-NDEV2-VA-EMAIL"
      policies = {
        add-default-policy = true
        custom-policies = [
          {
            actions = ["sns:Publish"]
            effect  = "Allow"
            principals = {
              identifiers = ["events.amazonaws.com"]
              type        = "Service"
            }
            sid = "my-policy-1"
          }
        ]
      }
      subscriptions = [
        {
          end-point = "tranvinhthinh@luvina.net"
          protocol  = "email"
        },
        {
          end-point = "nguyencanhhoang@luvina.net"
          protocol  = "email"
        },
      ]
    },
    {
      name = "SNT-SD-NDEV2-VA-SecurityGroupCheckByConfig"
      policies = {
        add-default-policy = true
        custom-policies    = []
      }
      subscriptions = [
        {
          end-point = "tranvankhoi@luvina.net"
          protocol  = "email"
        },
      ]
    }
  ]
}