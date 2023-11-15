resource "aws_ecs_cluster" "this" {
  for_each = var.clusters-config-data

  name = each.value.cluster-name
  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-cluster"
    }
  )
}