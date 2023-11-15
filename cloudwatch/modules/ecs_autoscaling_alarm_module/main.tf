locals {
  cluster-name = var.scale-target.cluster-name
  service-name = var.scale-target.service-name

  scale-resource     = "service/${local.cluster-name}/${local.service-name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.scale-target.min-capacity
  max_capacity       = var.scale-target.max-capacity

  scale_up_policy_arn   = [aws_appautoscaling_policy.scale_up_policy.arn]
  scale_down_policy_arn = [aws_appautoscaling_policy.scale_down_policy.arn]
}

##############################################################################
# AWS Auto Scaling - Metric Alarm
##############################################################################
resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  for_each = { for value in var.ecs-metric-alarms-config-data : value.alarm-name => value }

  alarm_name                = each.value.alarm-name
  comparison_operator       = each.value.alarm-config.comparison-operator
  evaluation_periods        = each.value.alarm-config.evaluation-periods
  metric_name               = each.value.alarm-config.metric-name
  namespace                 = each.value.alarm-config.namespace
  period                    = each.value.alarm-config.period
  statistic                 = each.value.alarm-config.statistic
  threshold                 = each.value.alarm-config.threshold
  alarm_description         = each.value.alarm-name
  insufficient_data_actions = []
  dimensions = {
    ClusterName = local.cluster-name
    ServiceName = local.service-name
  }

  # ECS SCALE-IN  => cần bổ sung thêm tài nguyên  => remove task  => scale_down
  alarm_actions = each.value.alarm-config.alarm-actions == "SCALE-IN" ?  local.scale_down_policy_arn : local.scale_up_policy_arn

  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-autoscaling-metric-alarm"
    }
  )
}

##############################################################################
# AWS Auto Scaling - Scaling Target
##############################################################################
resource "aws_appautoscaling_target" "ecs_target" {
  service_namespace  = "ecs"
  resource_id        = local.scale-resource
  scalable_dimension = local.scalable_dimension
  min_capacity       = local.min_capacity
  max_capacity       = local.max_capacity

  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-autoscaling-target"
    }
  )
}

##############################################################################
# AWS Auto Scaling - Scaling Down Policy
##############################################################################
resource "aws_appautoscaling_policy" "scale_down_policy" {
  name       = "${local.service-name}-scale-down"
  depends_on = [aws_appautoscaling_target.ecs_target]

  policy_type        = "StepScaling"
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"
    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}

##############################################################################
# AWS Auto Scaling - Scaling Up Policy
##############################################################################
resource "aws_appautoscaling_policy" "scale_up_policy" {
  name       = "${local.service-name}-scale-up"
  depends_on = [aws_appautoscaling_target.ecs_target]

  policy_type        = "StepScaling"
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"
    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = 1
    }
  }

}
