mock_provider "aws" {}
mock_provider "github" {}

override_module {
  target = module.github_oidc
  outputs = {
    oidc_role = "arn:aws:iam::665449637458:role/test-github-oidc"
  }
}

run "defaults_to_org_name" {
  command = plan

  variables {
    organization_name = "goldentooth"
    repositories      = ["terraform"]
  }

  assert {
    condition     = aws_s3_bucket.terraform_state.bucket == "goldentooth.terraform"
    error_message = "State bucket should default to <organization_name>.terraform"
  }
}

run "override" {
  command = plan

  variables {
    organization_name = "BottomUpAI"
    state_bucket_name = "bottomupai.terraform"
    repositories      = ["terraform"]
  }

  assert {
    condition     = aws_s3_bucket.terraform_state.bucket == "bottomupai.terraform"
    error_message = "State bucket should use state_bucket_name when set"
  }
}

run "rejects_uppercase" {
  command = plan

  variables {
    organization_name = "BottomUpAI"
    state_bucket_name = "BottomUpAI.terraform"
    repositories      = ["terraform"]
  }

  expect_failures = [var.state_bucket_name]
}
