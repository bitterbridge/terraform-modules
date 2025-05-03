locals {
  variable_name   = "IAM_ROLE_TO_ASSUME"
  variable_exists = length(data.github_actions_variables.this.variables) > 0
}

data "github_actions_variables" "this" {
  name = local.variable_name
}

resource "github_actions_variable" "this" {
  count = local.variable_exists ? 0 : 1

  repository    = var.repository_name
  variable_name = local.variable_name
  value         = var.iam_role_arn
}
