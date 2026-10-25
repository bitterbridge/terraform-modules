variable "organization_name" {
  description = "The name of the organization"
  type        = string

  validation {
    condition     = length(var.organization_name) > 0
    error_message = "The organization name must be provided"
  }
}

variable "repositories" {
  description = "List of repository names to configure"
  type        = list(string)

  validation {
    condition     = length(var.repositories) > 0
    error_message = "At least one repository must be provided"
  }
}

variable "state_bucket_name" {
  description = "Name of the Terraform state bucket. Defaults to <organization_name>.terraform; set this when the organization name isn't a valid S3 bucket name (e.g. it contains capitals)."
  type        = string
  default     = null

  validation {
    condition     = var.state_bucket_name == null || can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.state_bucket_name))
    error_message = "state_bucket_name must be a valid S3 bucket name: 3-63 lowercase letters, digits, dots, and hyphens."
  }
}

variable "oidc_subject_owner" {
  description = "Owner part of the OIDC subject the role trusts. Defaults to <organization_name>; set it to <organization_name>@<owner-id> for orgs whose tokens use GitHub's immutable subject format (repo:org@id/repo@id:...)."
  type        = string
  default     = null

  validation {
    condition     = var.oidc_subject_owner == null || can(regex("^[A-Za-z0-9-]+@[0-9]+$", var.oidc_subject_owner))
    error_message = "oidc_subject_owner must look like <organization_name>@<numeric owner id>."
  }
}

variable "oidc_repositories" {
  description = "Repositories (owner/repo, optionally :subject-suffix) whose workflows may assume the OIDC role. Defaults to every repository in the organization; set it to limit the role's AdministratorAccess to the repos that apply infrastructure."
  type        = list(string)
  default     = null

  validation {
    condition = var.oidc_repositories == null ? true : (
      length(var.oidc_repositories) > 0 &&
      alltrue([for r in var.oidc_repositories : can(regex("^[A-Za-z0-9-]+(@[0-9]+)?/[^/:]+(:.+)?$", r))])
    )
    error_message = "oidc_repositories must be a non-empty list of owner/repo entries."
  }
}
