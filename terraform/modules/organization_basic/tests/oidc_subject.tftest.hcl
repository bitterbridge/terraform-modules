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
    condition     = local.oidc_repositories == ["goldentooth/*"]
    error_message = "OIDC trust should default to <organization_name>/*"
  }
}

run "immutable_subject_owner" {
  command = plan

  variables {
    organization_name  = "BottomUpAI"
    oidc_subject_owner = "BottomUpAI@345462692"
    repositories       = ["terraform"]
  }

  assert {
    condition     = local.oidc_repositories == ["BottomUpAI@345462692/*"]
    error_message = "OIDC trust should use oidc_subject_owner when set"
  }
}

run "rejects_owner_without_id" {
  command = plan

  variables {
    organization_name  = "BottomUpAI"
    oidc_subject_owner = "BottomUpAI"
    repositories       = ["terraform"]
  }

  expect_failures = [var.oidc_subject_owner]
}
