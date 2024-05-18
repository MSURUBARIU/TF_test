output "lambda_s3_access_bucket_id" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.lambda_s3_access_bucket.id
}

output "bucket_arn" {
  description = "The ARN of the bucket"
  value       = aws_s3_bucket.lambda_s3_access_bucket.arn
}

output "s3_kms_key" {
  description = "The ARN of the KMS key used to encrypt the bucket contents"
  value       = aws_kms_key.s3_kms_key
}