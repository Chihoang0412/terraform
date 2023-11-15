resource "aws_security_group" "security_groups" {
  count       = length(var.security_groups)
  name        = var.security_groups[count.index].name
  description = var.security_groups[count.index].description
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.create_ingress_rules ? var.security_groups[count.index].ingress_rules : []
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.create_egress_rules ? var.security_groups[count.index].egress_rules : []
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name : var.security_groups[count.index].name
  }
}
