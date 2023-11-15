
resource "aws_sns_topic_subscription" "topic-subscriptions" {
  count = length(var.subscriptions)

  topic_arn = var.topic-arn
  protocol  = var.subscriptions[count.index].protocol
  endpoint  = var.subscriptions[count.index].end-point
}