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
  default     = "terraform-cloudwatch"
}

variable "aws-region" {
  description = "aws work with region"
  type        = string
  default     = "ap-northeast-1"
}

################################################################################
# ecs_autoscaling_alarm VARIABLES
################################################################################

variable "scale-target" {
  type = object({
    cluster-name = string
    service-name = string
    min-capacity = optional(number, 1)
    max-capacity = optional(number, 1)
  })

  default = {
    cluster-name = "bluegreen-cluster"
    service-name = "bluegreen-service"
    min-capacity = 1
    max-capacity = 5
  }
}

variable "ecs-metric-alarms-config-data" {
  type = list(object({
    alarm-name = string
    # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm#comparison_operator
    # https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
    alarm-config = object({
      metric-name         = string
      comparison-operator = string
      evaluation-periods  = optional(number, 1)
      namespace           = optional(string, "AWS/EC2")
      period              = optional(number, 60)
      statistic           = string
      threshold           = number
      alarm-actions       = string
      alarm-actions-arns  = optional(list(string), [])
    })
  }))

  default = [
    {
      alarm-name = "ALM-SD-NDEV2-FRW-APP-CPU-SCALEIN"
      alarm-config = {
        metric-name         = "CPUUtilization"
        comparison-operator = "LessThanThreshold"
        statistic           = "Average"
        threshold           = 40
        alarm-actions       = "SCALE-IN"
      }
    },
    {
      alarm-name = "ALM-SD-NDEV2-FRW-APP-CPU-SCALEOUT"
      alarm-config = {
        metric-name         = "CPUUtilization"
        comparison-operator = "GreaterThanOrEqualToThreshold"
        statistic           = "Average"
        threshold           = 70
        alarm-actions       = "SCALE-OUT"
      }
    },
    {
      alarm-name = "ALM-SD-NDEV2-FRW-APP-MEMORY-SCALEIN"
      alarm-config = {
        metric-name         = "MemoryUtilization"
        comparison-operator = "LessThanThreshold"
        statistic           = "Maximum"
        threshold           = 70.1
        alarm-actions       = "SCALE-IN"
      }
    },
    {
      alarm-name = "ALM-SD-NDEV2-FRW-APP-MEMORY-SCALEOUT"
      alarm-config = {
        metric-name         = "MemoryUtilization"
        comparison-operator = "GreaterThanOrEqualToThreshold"
        statistic           = "Maximum"
        threshold           = 70.2
        alarm-actions       = "SCALE-OUT"
      }
    }
  ]
}

################################################################################
# log group VARIABLES
################################################################################

variable "log-groups-config-data" {
  type = list(object({
    name              = string
    retention_in_days = optional(number, 0)
  }))

  default = [
    {
      name              = "/aws/ecs/containerinsights/CLST-SD-NDEV2-FRW/performance"
      retention_in_days = 400
    },
    {
      name              = "/aws/events/CWL-SVC-SD-NDEV2-FRW/serviceevents"
      retention_in_days = 400
    },
    {
      name              = "/CWL-SD-NDEV2-MNG-VPC-JP"
      retention_in_days = 400
    },
    {
      name              = "/ecs/TSK-SD-NDEV2-FRW"
      retention_in_days = 0
    },
    {
      name              = "/var/log/awslogs/SVC-SD-NDEV2-FRW/debug"
      retention_in_days = 0
    },
    {
      name              = "/var/log/awslogs/SVC-SD-NDEV2-FRW/exception"
      retention_in_days = 0
    },
    {
      name              = "/var/log/awslogs/SVC-SD-NDEV2-FRW/report"
      retention_in_days = 0
    },
    {
      name              = "/var/log/awslogs/SVC-SD-NDEV2-FRW/system"
      retention_in_days = 0
    },
    {
      name              = "/aws/rds/cluster/sdfrwdbsnd2va01/error"
      retention_in_days = 0
    },
    {
      name              = "/var/log/awslogs/SVC-SD-NDEV2-FRW/cancel-subscription-api"
      retention_in_days = 0
    },
    {
      name              = "/var/log/awslogs/SVC-SD-NDEV2-FRW/create-order-api"
      retention_in_days = 0
    },
    {
      name              = "/var/log/awslogs/SVC-SD-NDEV2-FRW"
      retention_in_days = 0
    },
    {
      name              = "/var/log/awslogs/SVC-SD-NDEV2-FRW/partner_send_estimation_email_api"
      retention_in_days = 0
    },
  ]
}