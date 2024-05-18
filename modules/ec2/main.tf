# provider "aws" {
#   version = "~> 5.0"
#   region  = var.aws_region
# }


resource "aws_instance" "example" {
  ami                    = var.example_instance.ami
  instance_type          = var.example_instance.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = merge(var.global_tags, var.example_instance.tags)
}
