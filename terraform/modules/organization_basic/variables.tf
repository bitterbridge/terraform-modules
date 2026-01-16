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
