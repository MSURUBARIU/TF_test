provider "aws" {
  version = "~> 5.0"
  region  = var.aws_region
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  versioning {
    enabled = var.versioning
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.server_side_encryption["sse_algorithm"]
      }
    }
  }

  public_access_block {
    block_public_acls       = var.block_public_access["block_public_acls"]
    block_public_policy     = var.block_public_access["block_public_policy"]
    ignore_public_acls      = var.block_public_access["ignore_public_acls"]
    restrict_public_buckets = var.block_public_access["restrict_public_buckets"]
  }

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}

