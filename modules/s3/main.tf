# provider "aws" {
#   version = "~> 5.0"
#   region  = var.aws_region
# }

#if possible this should be further parameterized with a for/for_each, depending on usecase.
resource "aws_s3_bucket" "python_lambda_bucket" {
  bucket = "${var.global_tags.company}-${var.global_tags.environment}-${var.global_tags.project}-${var.buckets.python_lambda_bucket.name}"

  tags = merge(var.global_tags, var.buckets.python_lambda_bucket.tags)
  # {
  #   Name        = "MyS3Bucket"
  #   Environment = "Production"
  # }
}

  # versioning {
  #   enabled = var.versioning
  # }

  # server_side_encryption_configuration {
  #   rule {
  #     apply_server_side_encryption_by_default {
  #       sse_algorithm = var.server_side_encryption["sse_algorithm"]
  #     }
  #   }
  # }

resource "aws_s3_bucket_public_access_block" "python_lambda_bucket"{
  
    bucket = "${var.global_tags.company}-${var.global_tags.environment}-${var.global_tags.project}-${var.buckets.python_lambda_bucket.name}"
    block_public_acls       = var.buckets.python_lambda_bucket.public_access_block.block_public_acls
    block_public_policy     = var.buckets.python_lambda_bucket.public_access_block.block_public_policy
    ignore_public_acls      = var.buckets.python_lambda_bucket.public_access_block.ignore_public_acls
    restrict_public_buckets = var.buckets.python_lambda_bucket.public_access_block.restrict_public_buckets
  }


