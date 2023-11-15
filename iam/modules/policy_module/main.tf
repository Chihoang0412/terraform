locals {
  polices-config-folder = var.config-folder
  policy_files          = fileset("${local.polices-config-folder}", "/*.json")
  policy-names          = values({ for value in local.policy_files : value => replace(value, ".json", "") })
}

# create all policies with json file in group folder
resource "aws_iam_policy" "this" {
  count = var.polices_create_flag ? length(local.policy-names) : 0

  name        = "${var.polices_name_prefix}${local.policy-names[count.index]}"
  description = "${var.tags.Name}-${local.policy-names[count.index]}-policy"
  policy      = file("${local.polices-config-folder}/${local.policy-names[count.index]}.json")

  tags = merge(var.tags,
    {
      "Name" = "${var.tags.Name}-${local.policy-names[count.index]}-policy"
  })
}
