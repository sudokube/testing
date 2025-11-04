resource "google_clouddeploy_delivery_pipeline" "pipeline" {
  location = var.region
  name     = "pipeline"

  serial_pipeline {
    stages {
      target_id = "staging"
    }
    stages {
      target_id = "production"
    }
  }
}

resource "google_clouddeploy_target" "staging" {
  location = var.region
  name     = "staging"

  execution_configs {
    service_account = google_service_account.deploy_sa.email
    usages          = ["RENDER", "DEPLOY"]
  }

  run {
    location = "projects/${var.project_id}/locations/${var.region}"
  }
}

resource "google_clouddeploy_target" "production" {
  location = var.region
  name     = "production"

  execution_configs {
    service_account = google_service_account.deploy_sa.email
    usages          = ["RENDER", "DEPLOY"]
  }

  run {
    location = "projects/${var.project_id}/locations/${var.region}"
  }
}
