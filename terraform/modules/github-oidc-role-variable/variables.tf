variable "aws_account_id" {
  type        = string
  description = "The account ID of the AWS account"

  validation {
    condition     = can(regex("^[0-9]{12}$", var.aws_account_id))
    error_message = "AWS account ID must be 12 digits"
  }
}

variable "iam_role_arn" {
  description = "The ARN of the IAM role to assume"
  type        = string

  validation {
    condition     = length(var.iam_role_arn) > 0
    error_message = "The IAM role ARN must be provided"
  }

  validation {
    condition     = can(regex("^arn:aws:iam::[0-9]{12}:role/[a-zA-Z0-9+=,.@_-]+$", var.iam_role_arn))
    error_message = "IAM role ARN must be a valid ARN"
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
    condition     = can(regex("^[a-z0-9_-]+$", var.repository_name))
    error_message = "The repository name must contain only lowercase letters, numbers, underscores, and hyphens"
  }
}
