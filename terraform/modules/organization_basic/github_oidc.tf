locals {
  oidc_repositories = (
    var.oidc_repositories != null
    ? var.oidc_repositories
    : ["${coalesce(var.oidc_subject_owner, var.organization_name)}/*"]
  )
}

module "github_oidc" {
  source  = "terraform-module/github-oidc-provider/aws"
  version = "2.3.0"

  create_oidc_provider      = false
  oidc_provider_arn         = "arn:aws:iam::665449637458:oidc-provider/token.actions.githubusercontent.com"
  create_oidc_role          = true
  repositories              = local.oidc_repositories
  oidc_role_attach_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  role_name                 = "${var.organization_name}-github-oidc"
}

output "github_oidc_role" {
  value = module.github_oidc.oidc_role
}
