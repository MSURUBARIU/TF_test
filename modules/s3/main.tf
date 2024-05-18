# provider "aws" {
#   version = "~> 5.0"
#   region  = var.aws_region
# }

#if possible this should be further parameterized with a for/for_each, depending on use-case.
resource "aws_s3_bucket" "python_lambda_bucket" {
  
  bucket = "${var.global_tags.company}-${var.global_tags.environment}-${var.global_tags.project}-${var.buckets.python_lambda_bucket.name}"

  tags = merge(var.global_tags, var.buckets.python_lambda_bucket.tags)

}

resource "aws_s3_bucket_versioning" "python_lambda_bucket" {
    bucket = aws_s3_bucket.python_lambda_bucket.id
    versioning_configuration {
      status = var.buckets.python_lambda_bucket.versioning_configuration.status
      mfa_delete = var.buckets.python_lambda_bucket.versioning_configuration.mfa_delete
    } 
   
}

resource "aws_s3_bucket_server_side_encryption_configuration" "python_lambda_bucket"{
    bucket = "${var.global_tags.company}-${var.global_tags.environment}-${var.global_tags.project}-${var.buckets.python_lambda_bucket.name}"
    
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm =  var.buckets.python_lambda_bucket.server_side_encryption_configuration.sse_algorithm
      }
    }
  }


resource "aws_s3_bucket_public_access_block" "python_lambda_bucket"{
    for_each = local.public_access_block_settings_python_lambda_bucket
    bucket = "${var.global_tags.company}-${var.global_tags.environment}-${var.global_tags.project}-${var.buckets.python_lambda_bucket.name}"
    block_public_acls       = each.value.block_public_acls
    block_public_policy     = each.value.block_public_policy
    ignore_public_acls      = each.value.ignore_public_acls
    restrict_public_buckets = each.value.restrict_public_buckets
  }


