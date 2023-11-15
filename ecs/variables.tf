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
  default     = "terraform-ecs"
}

variable "aws-region" {
  description = "aws work with region"
  type        = string
  default     = "ap-northeast-1"
}

################################################################################
# ecs-config-data VARIABLES
################################################################################
variable "ecs-config-data" {
  description = "ecs config resource"
  type = list(object({
    cluster-name = string
    services = list(object({
      service-name            = string
      desired-count           = number
      task-definition-arn     = string
      task-has-run-on-aws-vpc = bool
      subnet-ids              = list(string)
      security-group-ids      = list(string)
    }))
  }))

  default = [
    {
      cluster-name = "CLST-SD-NDEV2-FRW",
      services = [
        {
          service-name            = "SVC-SD-NDEV2-FRW-API",
          desired-count           = 1
          task-definition-arn     = "arn:aws:ecs:ap-northeast-1:895748805273:task-definition/bluegreen-task-definitions:4"
          task-has-run-on-aws-vpc = true
          subnet-ids              = ["subnet-227d5c79", "subnet-5dbb4c15", "subnet-daa658f1"]
          security-group-ids      = ["sg-d401e1aa", ]
        },
        {
          service-name            = "SVC-SD-NDEV2-FRW",
          desired-count           = 1
          task-definition-arn     = "arn:aws:ecs:ap-northeast-1:895748805273:task-definition/bluegreen-task-definitions:3"
          task-has-run-on-aws-vpc = false
          subnet-ids              = []
          security-group-ids      = []
        },
      ]
    },
    {
      cluster-name = "cicd-jenkins-slave-cluster",
      services     = []
    },
  ]
}