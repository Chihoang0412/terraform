################################################################################
# Buckets
################################################################################
resource "aws_s3_bucket" "this" {
  count = length(var.buckets)
  # create bucket
  bucket = var.buckets[count.index].bucket
  # bucket object lock
  object_lock_enabled = var.buckets[count.index].object_lock
  # bucket tags
  tags = {
    Name        = var.buckets[count.index].tags.name
    Environment = var.buckets[count.index].tags.environment
  }
}