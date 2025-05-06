variable "organization_name" {
  description = "The name of the organization"
  type        = string

  validation {
    condition     = length(var.organization_name) > 0
    error_message = "The organization name must be provided"
  }
}
