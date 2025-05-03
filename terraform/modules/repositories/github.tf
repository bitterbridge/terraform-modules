data "github_repositories" "all" {
  query           = "org:${var.organization_name} ${var.query}"
  include_repo_id = true

  lifecycle {
    postcondition {
      condition     = length(self.names) > 0
      error_message = "No repositories found"
    }
  }
}

data "github_repository" "all" {
  for_each = toset(data.github_repositories.all.names)

  full_name = "${var.organization_name}/${each.key}"
}
