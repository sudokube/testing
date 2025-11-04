output "staging_service_endpoint" {
  value = google_cloud_run_v2_service.staging.uri
}

output "production_service_endpoint" {
  value = google_cloud_run_v2_service.production.uri
}

output "cloud_run_service_account_email" {
  value = google_service_account.run_sa.email
}

output "cloud_deploy_service_account_email" {
  value = google_service_account.deploy_sa.email
}

output "n8n_service_account_email" {
  value = google_service_account.n8n_sa.email
}
