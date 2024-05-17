module "network" {
  source = "../../../modules/network"
  vpc_cidr = local.settings.networking.cidr #var.vpc_cidr
  aws_region = local.settings.general.aws_region
  subnet_cidrs = tolist(local.settings.networking.subnet_cidrs) #doing this so the type specified in module is consistent 
  security_groups = local.settings.networking.security_groups # var.security_groups
}

# module "ec2" {
#   source = "../../../modules/ec2"
#   instance_type = var.instance_type
#   ami_id = var.ami_id
#   subnet_id = module.network.subnet_ids[0]
#   security_group_ids = module.network.security_group_ids
#   ec2_tags = var.ec2_tags
# }

# module "s3" {
#   source = "../../../modules/s3"
#   bucket_name = var.bucket_name
#   versioning = var.versioning
#   block_public_access = var.block_public_access
# }

# module "lambda" {
#   source = "../../../modules/lambda"
#   lambda_function_name = var.lambda_function_name
#   s3_bucket_name = module.s3.bucket_id
#   lambda_handler = var.lambda_handler
#   runtime = var.runtime
#   lambda_zip_path = var.lambda_zip_path
#   kms_key_arn = module.s3.kms_key_arn
# }