config {
  module     = true
  deep_check = false
}

rule "terraform_dash_in_resource_name" {
  enabled = true
}
# will be added in a future tflint release
# rule "terraform_dash_in_output_name" {
#   enabled = true
# }
rule "terraform_documented_outputs" {
  enabled = true
}
rule "terraform_documented_variables" {
  enabled = true
}
rule "terraform_module_pinned_source" {
  enabled = true
}
rule "terraform_module_semver_source" {
  enabled = true
}

rule "aws_elasticache_cluster_default_parameter_group" {
  # parameter_group_name is required and it doesn't make sense to
  # create a copy of the default parameter group
  enabled = false
}
