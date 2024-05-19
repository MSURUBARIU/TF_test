output "vpc_id" {
  value = "${local.settings.common_tags.environment} ${module.network.vpc_id}"
}

output "subnet_ids" {
  value = [for subnet in module.network.subnet_ids : "${local.settings.common_tags.environment} ${subnet}"]
}

output "security_group_ids" {
  value = module.network.security_group_ids
}

output "example_ec2_instance_id" {
  value = module.ec2.instance_id
}
output "example_ec2_instance_pub_ip" {
  value = module.ec2.instance_public_ip
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
