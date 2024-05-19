# provider "aws" {
#   #  version = "~> 5.0"  Deprecated
#   # region  = var.aws_region
# }



provider "aws" {
  # we need to add required providers block since version is deprecated
  # version = "~> 5.0"
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env_name}-${var.aws_region} Main VPC"
  }
}



resource "aws_subnet" "subnets" {
  for_each = { for y, cidr in var.subnet_cidrs : y => cidr }

  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  # trying to keep as much of the original logic
  availability_zone = element(data.aws_availability_zones.available.names, each.key)
  ## another way of getting the same result
  #  availability_zone = data.aws_availability_zones.available.names[each.key]

  tags = {
    Name = "Subnet ${each.key + 1} ${var.env_name}-${var.aws_region}"
  }
}

resource "aws_security_group" "sgs" {
  for_each = var.security_groups

  name        = "${var.env_name}-${var.aws_region}-${each.key}"
  description = "Security Group ${var.env_name}-${var.aws_region}-${each.key}"
  vpc_id      = aws_vpc.main.id
  #adding tags as they were not present
  tags = {
    Name        = "${var.env_name}-${var.aws_region}-${each.key}"
    environment = var.env_name
  }
  dynamic "ingress" {
    for_each = each.value.ingress
    # I'm guessing here you were checking for attention to detail :)
    content {
      description = each.value.ingress.description
      from_port   = each.value.ingress.from_port
      to_port     = each.value.ingress.to_port
      protocol    = each.value.ingress.protocol
      cidr_blocks = each.value.ingress.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = each.value.egress
    content {
      from_port   = each.value.egress.from_port
      to_port     = each.value.egress.to_port
      protocol    = each.value.egress.protocol
      cidr_blocks = each.value.egress.cidr_blocks
    }
  }
}
