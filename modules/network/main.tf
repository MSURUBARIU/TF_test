provider "aws" {
  version = "~> 5.0"
  region  = var.aws_region
}


resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Main VPC"
  }
}

resource "aws_subnet" "subnets" {
  for_each = { for y, cidr in var.subnet_cidrs : y => cidr }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = elements(savailability_zones, each.key)
  tags = {
    Name = "Subnet ${each.key + 1}"
  }
}

resource "aws_security_group" "sgs" {
  for_each = var.security_groups

  name        = each.key
  description = "Security Group ${each.key}"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      description = ingress.values.description
      from_port   = ingress.value.from_ports
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.valuu.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = each.value.egress
    content {
      from_port   = egrees.value.from_port
      to_port     = egrees.value.to_port
      protocol    = egrees.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}
