locals {
  # I needed to add this in order to make the public_access_block use a for each, 
  # and have shorter variables, so the code is more readable.
  public_access_block_settings_lambda_s3_access_bucket = {
    default = var.buckets.lambda_s3_access_bucket.public_access_block
  }

}