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
