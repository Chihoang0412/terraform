provider "aws" {
  region = var.aws-region
}

locals {
  ## variable => map
  topics-config-map             = { for topic in var.topic-config-data : topic.name => topic }
  topics-custom-policies-map    = { for topic in var.topic-config-data : topic.name => topic.policies.custom-policies }
  topics-add-default-policy-map = { for topic in var.topic-config-data : topic.name => topic.policies.add-default-policy }

  ## output my_topic
  created-topic-infos = { for topic in aws_sns_topic.my_topic : topic.name => topic }

  tags = {
    Name       = "${var.enviroment}-${var.project}"
    Enviroment = var.enviroment
    Terraform  = "true"
  }
}

################################################################################
# aws_sns_topic 
################################################################################
# Create new topic
resource "aws_sns_topic" "my_topic" {
  for_each = local.topics-config-map

  name         = each.key
  display_name = "${each.key} - topic"

  tags = local.tags
}

# create policy for topic
resource "aws_sns_topic_policy" "default" {
  for_each = local.created-topic-infos

  arn = each.value.arn

  policy = data.aws_iam_policy_document.sns_topic_policy[each.key].json
}

# create policies
# add-default-policy = true  => add one __default_statement_ID to policies for topic

data "aws_iam_policy_document" "sns_topic_policy" {
  for_each = local.created-topic-infos

  policy_id = "${each.key}-policies"

  #### ADD DEFAULT POLICY
  dynamic "statement" {
    for_each = toset(lookup(local.topics-add-default-policy-map, each.key) ? ["__default_statement_ID"] : [])

    content {
      sid    = "__default_statement_ID"
      effect = "Allow"

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      actions = [
        "SNS:Subscribe",
        "SNS:SetTopicAttributes",
        "SNS:RemovePermission",
        "SNS:Receive",
        "SNS:Publish",
        "SNS:ListSubscriptionsByTopic",
        "SNS:GetTopicAttributes",
        "SNS:DeleteTopic",
        "SNS:AddPermission",
      ]

      condition {
        test     = "StringEquals"
        variable = "AWS:SourceOwner"

        values = [lookup(local.created-topic-infos[each.key], "owner"), ]
      }

      resources = [
        lookup(local.created-topic-infos[each.key], "arn"),
      ]
    }
  }

  #### ADD CUSTOM POLICY
  dynamic "statement" {
    for_each = lookup(local.topics-custom-policies-map, each.key)

    content {
      sid     = statement.value.sid
      effect  = statement.value.effect
      actions = statement.value.actions
      principals {
        type        = statement.value.principals.type
        identifiers = statement.value.principals.identifiers
      }
      resources = [
        lookup(local.created-topic-infos[each.key], "arn"),
      ]
    }
  }

  depends_on = [aws_sns_topic.my_topic]
}

################################################################################
#  aws_sns_topic_subscription
################################################################################

locals {
  topics-subscriptions-map = { for topic in var.topic-config-data : topic.name => topic.subscriptions }
}

module "topic_subscriptions" {
  for_each = { for key, value in local.created-topic-infos : key => lookup(local.topics-subscriptions-map, key) }
  source   = "./modules/topic_subscriptions_module"

  topic-arn     = local.created-topic-infos[each.key].arn
  subscriptions = each.value
}