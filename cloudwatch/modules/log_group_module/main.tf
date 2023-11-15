resource "aws_cloudwatch_log_group" "this" {
  count = length(var.log-groups-config-data)

  name              = var.log-groups-config-data[count.index].name
  retention_in_days = var.log-groups-config-data[count.index].retention_in_days

  tags = merge(
    var.tags,
    {
      Name = "${var.tags.Name}-log-group"
    }
  )
}