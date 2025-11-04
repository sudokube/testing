data "google_project" "project" {
  project_id = var.project_id
}

# IAM
resource "google_service_account" "github_actions_sa" {
  account_id   = "github-actions-sa"
  display_name = "GitHub Actions SA"
}

resource "google_project_iam_member" "github_actions_artifact_writer" {
  member  = google_service_account.github_actions_sa.member
  role    = "roles/artifactregistry.writer"
  project = var.project_id
}

resource "google_project_iam_member" "github_actions_deploy_operator" {
  member  = google_service_account.github_actions_sa.member
  role    = "roles/clouddeploy.operator"
  project = var.project_id
}

resource "google_iam_workload_identity_pool" "github_pool" {
  workload_identity_pool_id = "github-pool"
  display_name              = "GitHub Actions Pool"
  project                   = var.project_id
}

resource "google_iam_workload_identity_pool_provider" "github_pool_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "GitHub OIDC Provider"
  project                            = var.project_id

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_member" "github_wif_user" {
  service_account_id = google_service_account.github_actions_sa.name
  member             = "principalSet://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github_pool.workload_identity_pool_id}/subject/repository/${var.github_org}/${var.github_repo}:ref:refs/heads/${var.github_branch}"
  role               = "roles/iam.workloadIdentityUser"
}

# Outputs
output "github_actions_service_account_email" {
  description = "Email of the SA for GitHub Actions"
  value       = google_service_account.github_actions_sa.email
}

output "workload_identity_provider_name" {
  description = "The full name of the WIF provider for GitHub Actions YAML"
  value       = google_iam_workload_identity_pool_provider.github_provider.name
}
