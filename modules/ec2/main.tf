provider "aws" {
  version = "~> 5.0"
  region  = var.aws_region
}


resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = var.tags
}
