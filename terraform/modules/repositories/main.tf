terraform {
  required_version = ">= 1.8.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.50.0, < 6.8"
    }
    github = {
      source  = "integrations/github"
      version = ">= 6.3.0"
    }
  }
}
