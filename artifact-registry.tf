resource "google_artifact_registry_repository" "repo" {
  format        = "Docker"
  repository_id = var.repository_id
  location      = var.region
  project       = var.project_id
}

output "artifact_registry_repo_path" {
  value = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.repo.repository_id}"
}
