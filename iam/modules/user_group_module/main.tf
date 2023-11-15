locals {
  group-config-data = file("${var.group-config-root-foler}/${var.user-group-name}.json")
  config-data       = jsondecode(local.group-config-data)

  aws-managed-policies   = local.config-data.aws-managed-policies
  my-policies-create-flg = local.config-data.my-policies-create-flg

  tags = merge(var.tags,
    { "Name" = "${var.user-group-name}-group" }
  )
}

#####  Create user group
resource "aws_iam_group" "this" {
  name = var.user-group-name
}

#####  Create policies for group
module "user_group_policies" {
  source = "../policy_module"

  config-folder       = "${var.group-config-root-foler}/${var.user-group-name}"
  polices_name_prefix = "${var.user-group-name}_"
  polices_create_flag = local.my-policies-create-flg
  tags                = local.tags

  depends_on = [aws_iam_group.this]
}

#####  attachment policies to group
resource "aws_iam_group_policy_attachment" "my_policies_attachment" {
  count = length(module.user_group_policies.policy-arns)

  group      = aws_iam_group.this.name
  policy_arn = module.user_group_policies.policy-arns[count.index]

  depends_on = [module.user_group_policies]
}


#####  attachment aws managed policies to role
data "aws_iam_policy" "policies" {
  count = length(local.aws-managed-policies)
  name  = local.aws-managed-policies[count.index]
}

locals {
  aws-managed-policies-arns = [for policy in data.aws_iam_policy.policies : policy.arn]
}

resource "aws_iam_group_policy_attachment" "aws_managed_policies_attachment" {
  count = length(local.aws-managed-policies-arns)

  group      = aws_iam_group.this.name
  policy_arn = local.aws-managed-policies-arns[count.index]
}