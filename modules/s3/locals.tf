locals {
  # I needed to add this in order to make the public_access_block use a for each, 
  # and have shorter variables, so the code is more readable.
  public_access_block_settings_python_lambda_bucket = {
    default = var.buckets.python_lambda_bucket.public_access_block
  }

}