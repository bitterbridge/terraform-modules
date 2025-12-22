module "github_app_variables" {
  source = "github.com/bitterbridge/terraform-modules//terraform/modules/github_app_variables?ref=v0.0.400"

  for_each = toset(keys(module.repositories.repositories))

  organization_name = var.organization_name
  repository_name   = each.key
}
