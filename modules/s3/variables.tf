variable "aws_region" {
  description = "AWS region for the S3 bucket"
  type        = string
  # default     = "us-east-1"
}

variable "buckets" {}

# variable "bucket_name" {
#   description = "Name of the S3 bucket"
#   type        = string
# }

# variable "versioning" {
#   description = "State of versioning for the S3 bucket"
#   type        = bool
#   default     = true
# }

# variable "server_side_encryption" {
#   description = "Server-side encryption configuration"
#   type        = map(any)
#   default = {
#     sse_algorithm = "AES256"
#   }
# }

# variable "block_public_access" {
#   description = "Block public access settings for the S3 bucket"
#   type        = map(bool)
#   default = {
#     block_public_acls       = true
#     block_public_policy     = true
#     ignore_public_acls      = true
#     restrict_public_buckets = true
#   }
# }

variable "global_tags" {}