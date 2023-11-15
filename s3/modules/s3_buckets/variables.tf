variable "buckets" {
  description = "List of bucket"
  type = list(object({
    bucket                  = string
    block_all_public_access = bool
    object_lock             = bool
    tags                    = map(string)
  }))
  default = [
    {
      bucket                  = "20231030-bucket-terraform-01",
      block_all_public_access = false,
      object_lock             = true,
      tags = {
        name        = "20231030-bucket-terraform-01",
        environment = "DEV"
      }
    },
    {
      bucket                  = "20231030-bucket-terraform-02",
      block_all_public_access = true,
      object_lock             = false,
      tags = {
        name        = "20231030-bucket-terraform-02",
        environment = "DEV"
      }
    }
  ]
}

variable "bucket_version" {
  description = "Turn or of version bucket"
  type        = list(string)
  default     = []
}

variable "bucket_policies" {
  description = "List bucket set policy"
  type        = list(string)
  default     = ["20231030-bucket-terraform-01"]
}


variable "bucket_life_cycle" {
  description = "Bucket life cycle"
  type = list(object({
    bucket = string
    life_cycle = object({
      id     = string
      status = string
      expiration = object({
        days = number
      })

    })
  }))
  default = []
}

variable "bucket_server_access_log" {
  description = "Config server access log"
  type = list(object({
    bucket        = string
    bucket_target = string
  }))
  default = []
}
