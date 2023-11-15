
resource "aws_ecs_service" "this" {
  count = length(var.cluster-services)

  name            = var.cluster-services[count.index].service-name
  cluster         = var.cluster-arn
  task_definition = var.cluster-services[count.index].task-definition-arn
  desired_count   = var.cluster-services[count.index].desired-count

  # network configuration (config for aws_vpc mode)
  dynamic "network_configuration" {
    for_each = toset(var.cluster-services[count.index].task-has-run-on-aws-vpc ?
      [
        {
          security_group_ids = var.cluster-services[count.index].security-group-ids
          subnet_ids         = var.cluster-services[count.index].subnet-ids
        },
      ]
      : []
    )

    content {
      security_groups = network_configuration.value.security_group_ids
      subnets         = network_configuration.value.subnet_ids
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-service"
    }
  )
}
