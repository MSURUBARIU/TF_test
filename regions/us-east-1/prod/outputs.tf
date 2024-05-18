output "vpc_id" {
  value = "${local.settings.common_tags.environment} ${module.network.vpc_id}"
}

output "subnet_ids" {
  value = [for subnet in module.network.subnet_ids : "${local.settings.common_tags.environment} ${subnet}"]
}

output "security_group_ids" {
  # value = "${local.settings.common_tags.environment} env sg-ids ${module.network.security_group_ids}"
  # value = [for sg in module.network.security_group_ids : "${local.settings.common_tags.environment} env sg-ids ${sg.id}"]
  value = module.network.security_group_ids #[for sg in module.network.security_group_ids : sg.id]

}

# output "prod_ec2_instance_id" {
#   value = module.ec2.instance_id
# }

# output "prod_s3_bucket_id" {
#   value = module.s3.bucket_id
# }

# output "prod_lambda_function_name" {
#   value = module.lambda.lambda_function_name
# }

# output "prod_kms_key_arn" {
#   value = module.s3.kms_key_arn
# }
