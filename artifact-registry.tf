resource "google_artifact_registry_repository" "repo" {
  format        = "Docker"
  repository_id = var.repository
  description   = "Application Image Regirsty"
  location      = var.region
  project       = var.project
  depends_on    = [google_project_service.apis]
}

output "artifact_registry_repo_path" {
  value = "${var.region}-docker.pkg.dev/${var.project}/${google_artifact_registry_repository.repo.repository_id}"
}
