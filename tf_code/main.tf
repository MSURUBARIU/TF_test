data "aws_availability_zones" "available" {
  state = "available"
}

module "network" {
  source          = "../modules/network"
  vpc_cidr        = local.settings.networking.cidr #var.vpc_cidr
  aws_region      = local.settings.general.aws_region
  subnet_cidrs    = tolist(local.settings.networking.subnet_cidrs) #doing this so the type specified in module is consistent 
  security_groups = local.settings.networking.security_groups
  env_name        = local.settings.common_tags.environment

}

module "ec2" {
  source                 = "../modules/ec2"
  example_instance       = local.settings.ec2.instances.example
  common_tags            = local.settings.common_tags
  subnet_id              = module.network.subnet_ids[0]
  vpc_security_group_ids = module.network.security_group_ids
  aws_region             = local.settings.general.aws_region


}

module "s3" {
  source      = "../modules/s3"
  buckets     = local.settings.storage.s3
  global_tags = local.settings.common_tags
  aws_region  = local.settings.general.aws_region
}

module "lambda" {
  source           = "../modules/lambda"
  lambda_s3_access = local.settings.serverless.lambdas.lambda_s3_access
  global_tags      = local.settings.common_tags
  s3_bucket_name   = module.s3.lambda_s3_access_bucket_id
  aws_region       = local.settings.general.aws_region
  kms_key_arn = module.s3.s3_kms_key.arn
}
