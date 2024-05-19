variable "aws_region" {
  description = "AWS region to launch the EC2 instance"
  type        = string
  # default     = "us-east-1"
}

# variable "ami" {
#   description = "The AMI ID for the EC2 instance"
#   type        = number
# }

variable "example_instance" {
}
variable "common_tags" {

}

variable "instances_type" {
  description = "The instance type of the EC2 instance"
  #well, this was wrong :)
  type    = string
  default = "t2.micro"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  # type        = list(string)
}

variable "tag" {
  description = "A mapping of tags to assign to the resource"
  type        = list(string)
  default     = []
}
