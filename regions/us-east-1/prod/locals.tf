locals {


  #getting most variable values from the environments/$env.yaml
  workspace_path = "../../../vars/${terraform.workspace}.yaml"
  workspace      = fileexists(local.workspace_path) ? file(local.workspace_path) : yamlencode({})
  ws_settings    = yamldecode(local.workspace)
  workspace_tags = lookup(local.ws_settings, "common_tags", {})
  environment    = terraform.workspace

  # subnets_public_tmp = {
  #   for n in range(0, local.settings.subnet_count) : n => {
  #     subnet_name   = "tf-subnet-pub-${n + 1}"
  #     subnet_ip     = "${local.settings.subnet_prefix}.${(local.settings.subnet_count_prefix + n) * 10}.0/${local.settings.subnet_mask}"
  #     subnet_region = local.settings.global.aws_region
  #   }
  # }
  # #adding extra variables dynalically.
  # subnets_public = [
  #   for sub in local.subnets_public_tmp :
  #   merge(sub, local.settings.subnet_public_options)
  # ]

  # subnets_private_tmp = {
  #   for n in range(0, local.settings.subnet_count) : n => {
  #     subnet_name   = "tf-subnet-prv-${n + 1}"
  #     subnet_ip     = "${local.settings.subnet_prefix}.${local.settings.subnet_count_prefix + n}.0/${local.settings.subnet_mask}"
  #     subnet_region = local.settings.global.aws_region
  #   }
  # }
  # #adding extra variables dynalically.
  # subnets_private = [
  #   for sub in local.subnets_private_tmp :
  #   merge(sub, local.settings.subnet_private_options)
  # ]
  # subnets = concat(local.subnets_private, local.subnets_public)
  #var.extra_tags can be used to add tags from CICD pipeline
  common_tags = merge(local.workspace_tags) #, var.extra_tags)
  # from here we can use all variables in $env.yaml file you difine is like:
  # something_someresource = local.settings.variable_name_in_$env_file
  settings = merge(
    local.ws_settings,
    { "common_tags" = local.common_tags },
    # { "extra_role_mappings" = local.extra_role_mappings }
  )

}