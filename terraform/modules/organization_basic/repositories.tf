module "repositories" {
  source = "github.com/bitterbridge/terraform-modules//terraform/modules/repositories?ref=v0.0.84"

  organization_name = var.organization_name
  query             = var.repositories_query
}
