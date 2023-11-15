################################################################################
# Bucket server_access_logging
################################################################################
resource "aws_s3_bucket_logging" "this" {
count = length(var.bucket_server_access_log)
  bucket = var.bucket_server_access_log[count.index].bucket
  target_bucket = var.bucket_server_access_log[count.index].bucket_target
  target_prefix = "log/"
  # depends on bucket
  depends_on = [ aws_s3_bucket.this ]
}