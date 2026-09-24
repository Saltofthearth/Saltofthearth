# GitHub Repository & Actions Infrastructure Module
# Configures repository secrets, environments, and CI/CD parameters for Zero-Cost Multicloud

resource "github_repository" "zero_cost_repo" {
  name        = "zero-cost-multicloud-core"
  description = "Autonomous Zero-Cost Multicloud Infrastructure & Workload Scheduling"
  visibility  = "public" # Public repos enjoy unlimited GitHub Actions minutes

  has_issues   = true
  has_projects = true
  has_wiki     = false

  vulnerability_alerts = true
}

# GitHub Actions Environment
resource "github_repository_environment" "prod_environment" {
  environment = "production"
  repository  = github_repository.zero_cost_repo.name
}

# Outputs
output "repository_full_name" {
  value       = github_repository.zero_cost_repo.full_name
  description = "GitHub Repository Name"
}
