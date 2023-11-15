locals {

  role-config-data = file("${var.roles-config-root-foler}/${var.role-name}.json")
  config-data      = jsondecode(local.role-config-data)

  # load config form json file
  instance-profile-name = try(local.config-data.instance-profile-name, null)
  trust-relationships = jsonencode(
    try(local.config-data.trust-relationships, null)
  )
  aws-managed-policies   = try(local.config-data.aws-managed-policies, [])
  my-policies-create-flg = try(local.config-data.my-policies-create-flg, false)

  tags = merge(var.tags,
    { "Name" = "${var.role-name}-Role" }
  )
}

#####  Create Role
resource "aws_iam_role" "this" {
  name               = var.role-name
  assume_role_policy = local.trust-relationships
}

#####  Create instance profile
resource "aws_iam_instance_profile" "this" {
  count = local.instance-profile-name != null ? 1 : 0

  name = local.instance-profile-name
  role = aws_iam_role.this.name
}

#####  Create policies for role
module "role_policies" {
  source = "../policy_module"

  config-folder       = "${var.roles-config-root-foler}/${var.role-name}"
  polices_name_prefix = "${var.role-name}_"
  polices_create_flag = local.my-policies-create-flg
  tags                = local.tags

  depends_on = [aws_iam_role.this]
}

#####  attachment policies to role
resource "aws_iam_role_policy_attachment" "my_policies_attachment" {
  count = length(module.role_policies.policy-arns)

  role       = aws_iam_role.this.name
  policy_arn = module.role_policies.policy-arns[count.index]

  depends_on = [module.role_policies]
}

#####  attachment aws managed policies to role
data "aws_iam_policy" "policies" {
  count = length(local.aws-managed-policies)
  name  = local.aws-managed-policies[count.index]
}

locals {
  aws-managed-policies-arns = [for policy in data.aws_iam_policy.policies : policy.arn]
}

resource "aws_iam_role_policy_attachment" "aws_managed_policies_attachment" {
  count = length(local.aws-managed-policies-arns)

  role       = aws_iam_role.this.name
  policy_arn = local.aws-managed-policies-arns[count.index]
}