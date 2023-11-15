################################################################################
# Bucket version
################################################################################
resource "aws_s3_bucket_versioning" "versioning_example" {
  count  = length(var.bucket_version)
  bucket = lookup(local.buckets, var.bucket_version[count.index], "")
  versioning_configuration {
    status = "Enabled"
  }
}