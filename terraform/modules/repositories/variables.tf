variable "organization_name" {
  description = "The name of the organization"
  type        = string
}

variable "query" {
  description = "Additional query to filter repositories"
  type        = string
  default     = ""
}
