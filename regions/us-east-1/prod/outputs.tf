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

output "example_ec2_instance_id" {
  value = module.ec2.instance_id
}

output "lambda_s3_access_bucket_id" {
  value = module.s3.lambda_s3_access_bucket_id
}

output "lambda_function_name" {
  value = module.lambda.lambda_function_name
}

output "s3_kms_key" {
  value = module.s3.s3_kms_key
}
