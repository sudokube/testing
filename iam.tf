resource "google_service_account" "run_sa" {
  account_id   = "run-sa"
  display_name = "Cloud Run SA"
}

resource "google_service_account" "deploy_sa" {
  account_id   = "deploy-sa"
  display_name = "Cloud Deploy SA"
}

resource "google_service_account" "n8n_sa" {
  account_id   = "n8n-sa"
  display_name = "n8n SA"
}

resource "google_project_iam_member" "run_artifact_reader_role" {
  member  = "serviceAccount:${google_service_account.run_sa.email}"
  role    = "roles/artifactregistry.reader"
  project = var.project_id
}

resource "google_project_iam_member" "deploy_run_admin_role" {
  member  = "serviceAccount:${google_service_account.deploy_sa.email}"
  role    = "roles/run.admin"
  project = var.project_id
}

resource "google_project_iam_member" "deploy_artifact_role" {
  member  = "serviceAccount:${google_service_account.deploy_sa.email}"
  role    = "roles/artifactregistry.reader"
  project = var.project_id
}

resource "google_project_iam_member" "n8n_clouddeploy_operator_role" {
  member  = "serviceAccount:${google_service_account.n8n_sa.email}"
  role    = "roles/clouddeploy.operator"
  project = var.project_id
}

resource "google_project_iam_member" "n8n_monitoring_viewer_role" {
  member  = "serviceAccount:${google_service_account.n8n_sa.email}"
  role    = "roles/monitoring.viewer"
  project = var.project_id
}

resource "google_project_iam_member" "n8n_logging_viewer_role" {
  member  = "serviceAccount:${google_service_account.n8n_sa.email}"
  role    = "roles/logging.viewer"
  project = var.project_id
}

resource "google_service_account_iam_member" "deploy_sa_impersonate_run_sa" {
  service_account_id = google_service_account.run_sa.name
  member             = "serviceAccount:${google_service_account.deploy_sa.email}"
  role               = "roles/iam.serviceAccountUser"
}
