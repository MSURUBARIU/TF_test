provider "aws" {
  # we need to add required providers block since version is deprecated
  # version = "~> 5.0"
  region = var.aws_region
}

#if possible this should be further parameterized with a for/for_each, depending on use-case.
resource "aws_s3_bucket" "lambda_s3_access_bucket" {

  bucket = "${var.global_tags.environment}-${var.aws_region}-${var.global_tags.project}-${var.buckets.lambda_s3_access_bucket.name}"

  tags = merge(var.global_tags, var.buckets.lambda_s3_access_bucket.tags)

}

resource "aws_s3_bucket_versioning" "lambda_s3_access_bucket" {
  bucket                  = aws_s3_bucket.lambda_s3_access_bucket.bucket # "${var.global_tags.company}-${var.global_tags.environment}-${var.global_tags.project}-${var.buckets.lambda_s3_access_bucket.name}"
 
  # bucket = aws_s3_bucket.lambda_s3_access_bucket.id
  versioning_configuration {
    status     = var.buckets.lambda_s3_access_bucket.versioning_configuration.status
    mfa_delete = var.buckets.lambda_s3_access_bucket.versioning_configuration.mfa_delete
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "lambda_s3_access_bucket" {
  # bucket = "${var.global_tags.company}-${var.global_tags.environment}-${var.global_tags.project}-${var.buckets.lambda_s3_access_bucket.name}"
  bucket                  = aws_s3_bucket.lambda_s3_access_bucket.bucket # "${var.global_tags.company}-${var.global_tags.environment}-${var.global_tags.project}-${var.buckets.lambda_s3_access_bucket.name}"

  rule {
    apply_server_side_encryption_by_default {
      #I switched to kms encription 
      sse_algorithm = var.buckets.lambda_s3_access_bucket.server_side_encryption_configuration.sse_algorithm
      kms_master_key_id = aws_kms_key.s3_kms_key.arn
    }
  }
}


resource "aws_s3_bucket_public_access_block" "lambda_s3_access_bucket" {
  for_each                = local.public_access_block_settings_lambda_s3_access_bucket
  #the bucket name does not follow the logic of the for_each. if time permits this should be fixed.
  bucket                  = aws_s3_bucket.lambda_s3_access_bucket.bucket # "${var.global_tags.company}-${var.global_tags.environment}-${var.global_tags.project}-${var.buckets.lambda_s3_access_bucket.name}"
  block_public_acls       = each.value.block_public_acls
  block_public_policy     = each.value.block_public_policy
  ignore_public_acls      = each.value.ignore_public_acls
  restrict_public_buckets = each.value.restrict_public_buckets
}


resource "aws_kms_key" "s3_kms_key" {
  description = "${var.global_tags.environment}-kms-key"

tags = merge(var.global_tags)
}