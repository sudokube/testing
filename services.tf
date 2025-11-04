locals {
  required_services = [
    "run.googleapis.com",
    "artifactregistry.googleapis.com",
    "clouddeploy.googleapis.com",
    "cloudbuild.googleapis.com",
    "iam.googleapis.com",
    "containeranalysis.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com"
  ]
}

resource "google_project_service" "apis" {
  for_each           = toset(local.required_services)
  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}
