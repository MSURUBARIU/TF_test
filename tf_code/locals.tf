locals {


  #getting most variable values from the environments/$env.yaml
  workspace_path = "../vars/${terraform.workspace}.yaml"
  workspace      = fileexists(local.workspace_path) ? file(local.workspace_path) : yamlencode({})
  ws_settings    = yamldecode(local.workspace)
  workspace_tags = lookup(local.ws_settings, "common_tags", {})
  environment    = terraform.workspace

  #var.extra_tags can be used to add tags from CICD pipeline
  common_tags = merge(local.workspace_tags) #, var.extra_tags)
  # from here we can use all variables in $env.yaml file you difine is like:

  settings = merge(
    local.ws_settings,
    { "common_tags" = local.common_tags },

  )

}