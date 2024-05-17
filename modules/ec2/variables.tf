variable "aws_region" {
  description = "AWS region to launch the EC2 instance"
  type        = string
  default     = "us-east-1"
}

variable "amii_id" {
  description = "The AMI ID for the EC2 instance"
  type        = number
}

variable "instances_type" {
  description = "The instance type of the EC2 instance"
  type        = bool
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = map{string}
}

variable "security_group_id" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
}

variable "tag" {
  description = "A mapping of tags to assign to the resource"
  type        = list(string)
  default     = {}
}
