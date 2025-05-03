variable "aws_account_id" {
  type        = string
  description = "The account ID of the AWS account"

  validation {
    condition     = can(regex("^[0-9]{12}$", var.aws_account_id))
    error_message = "AWS account ID must be 12 digits"
  }
}

variable "organization_name" {
  description = "The name of the organization"
  type        = string

  validation {
    condition     = length(var.organization_name) > 0
    error_message = "The organization name must be provided"
  }
}

variable "repository_name" {
  description = "The name of the GitHub repository"
  type        = string

  validation {
    condition     = length(var.repository_name) > 0
    error_message = "The repository name must be provided"
  }

  validation {
    condition     = can(regex("^[.a-z0-9_-]+$", var.repository_name))
    error_message = "The repository name must contain only lowercase letters, numbers, underscores, dots, and hyphens"
  }
}
