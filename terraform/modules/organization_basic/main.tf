terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.50.0, < 6.6"
    }
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
    }
  }
}
