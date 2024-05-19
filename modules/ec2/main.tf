provider "aws" {
  # we need to add required providers block since version is deprecated
  # version = "~> 5.0"
  region  = var.aws_region
}


resource "aws_instance" "example" {
  ami                    = var.example_instance.ami
  instance_type          = var.example_instance.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  associate_public_ip_address = var.example_instance.public_ip
  tags = merge(var.common_tags, var.example_instance.tags, local.example_instance_name)
}
