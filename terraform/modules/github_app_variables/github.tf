locals {
  app_id_secret_path      = "${var.organization_name}/github/app/id"
  private_key_secret_path = "${var.organization_name}/github/app/private_key"
}

resource "github_actions_variable" "id_secret_path" {
  repository    = var.repository_name
  variable_name = "APP_ID_SECRET_PATH"
  value         = local.app_id_secret_path
}

resource "github_actions_variable" "private_key_secret_path" {
  repository    = var.repository_name
  variable_name = "APP_PRIVATE_KEY_SECRET_PATH"
  value         = local.private_key_secret_path
}
