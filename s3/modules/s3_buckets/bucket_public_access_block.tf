################################################################################
# Bucket public access block
################################################################################
resource "aws_s3_bucket_public_access_block" "access_block" {
  count  = length(var.buckets)
  bucket = lookup(local.buckets, var.buckets[count.index].bucket, "")
  # Block all public access
  block_public_acls       = var.buckets[count.index].block_all_public_access
  block_public_policy     = var.buckets[count.index].block_all_public_access
  ignore_public_acls      = var.buckets[count.index].block_all_public_access
  restrict_public_buckets = var.buckets[count.index].block_all_public_access
  # depends on bucket
  depends_on = [aws_s3_bucket.this]
}
