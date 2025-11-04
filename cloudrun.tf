locals {
  image_reference = "us-docker.pkg.dev/cloudrun/container/hello"
}

resource "google_cloud_run_v2_service" "production" {
  name                = "${var.service_name}-production"
  location            = var.region
  description         = "Production Environment"
  ingress             = "INGRESS_TRAFFIC_ALL"
  deletion_protection = false

  template {
    service_account = google_service_account.run_sa.email
    containers {
      image = local.image_reference
    }
  }

  scaling {
    min_instance_count = 0
    max_instance_count = 100
  }
}

resource "google_cloud_run_v2_service" "staging" {
  name                = "${var.service_name}-staging"
  location            = var.region
  description         = "Staging Environment"
  ingress             = "INGRESS_TRAFFIC_ALL"
  deletion_protection = false

  template {
    service_account = google_service_account.run_sa.email
    containers {
      image = local.image_reference
    }
  }

  scaling {
    min_instance_count = 0
    max_instance_count = 10
  }
}

resource "google_cloud_run_v2_service_iam_member" "public" {
  location = google_cloud_run_v2_service.production.location
  name     = google_cloud_run_v2_service.production.name
  project  = google_cloud_run_v2_service.production.project

  member = "allUsers"
  role   = "roles/run.invoker"
}