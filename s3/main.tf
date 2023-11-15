module "s3" {
  source = "./modules/s3_buckets"
}

# output "json_data" {
#   value = module.s3.json_data
# }


# module "policies" {
#     source = "./modules/s3_policies"
# }