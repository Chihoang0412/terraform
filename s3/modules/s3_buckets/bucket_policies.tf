################################################################################
# Buckets
################################################################################
locals {
  buckets = {
    for bucket in aws_s3_bucket.this : bucket.tags.Name => bucket.id
  }
}

resource "aws_s3_bucket_policy" "this" {
  count = length(var.bucket_policies)
  # config bucket id
  bucket = lookup(local.buckets, var.bucket_policies[count.index], "")
  # config policy
  policy = file("${path.module}/policies/${var.bucket_policies[count.index]}.json")
  # depends on bucket
  depends_on = [ aws_s3_bucket.this ]
}