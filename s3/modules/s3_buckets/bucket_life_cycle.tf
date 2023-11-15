################################################################################
# Life cycle
################################################################################
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = length(var.bucket_life_cycle)
  bucket = lookup(local.buckets, var.bucket_life_cycle[count.index].bucket, "")

  rule {
    id     = var.bucket_life_cycle[count.index].life_cycle.id
    status = var.bucket_life_cycle[count.index].life_cycle.status
    # Config expiration
    expiration {
      days = var.bucket_life_cycle[count.index].life_cycle.expiration.days
    }
  }
  # depends on bucket
  depends_on = [ aws_s3_bucket.this ]
}
