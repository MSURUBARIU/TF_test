terraform {
  backend "s3" {
    bucket         = "ms-tfstate-global-bucket"
    key            = "state/terraform.tfstate" 
    region         = "us-east-1"
    dynamodb_table = "tf-lock-table"
    encrypt        = true
  }
required_version = "~> 1.5.7"
}