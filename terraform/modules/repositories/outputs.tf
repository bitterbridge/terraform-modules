locals {
  desired_settings = {
    allow_auto_merge       = true,
    allow_merge_commit     = true,
    allow_rebase_merge     = true,
    allow_squash_merge     = true,
    allow_update_branch    = true,
    default_branch         = "main",
    delete_branch_on_merge = true,
    fork                   = false,
    has_discussions        = false,
    has_downloads          = true,
    has_issues             = true,
    has_projects           = true,
    has_wiki               = false,
    visibility             = "public",
  }
  repositories__wrong_settings_unfiltered = {
    for repo_name, repo_settings in data.github_repository.all : repo_name => {
      for setting_name, setting_value in local.desired_settings : setting_name => repo_settings[setting_name] if setting_value != repo_settings[setting_name]
    }
  }
  repositories__wrong_settings = {
    for repo_name, setting_set in local.repositories__wrong_settings_unfiltered : repo_name => setting_set if length(setting_set) > 0
  }
}

output "repositories" {
  description = "All repositories"
  value       = data.github_repository.all
}

output "repositories__wrong_settings" {
  description = "A map of repositories to the (incorrect) settings they have (or '(none)' if no settings are incorrect)."
  value       = local.repositories__wrong_settings
}
