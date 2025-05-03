resource "github_actions_variable" "this" {
  repository    = var.repository_name
  variable_name = "IAM_ROLE_TO_ASSUME"
  value         = var.iam_role_arn
}
