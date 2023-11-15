terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket = "895748805273-sd-terraform-states-ecs"
    key    = "dev/terraform.tfstate"
    region = "ap-northeast-1"
  }

  required_version = ">= 1.2.0"
}