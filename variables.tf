variable "project" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Primary region (e.g., asia-northeast3)"
  type        = string
  default     = "asia-northeast3"
}

variable "repository" {
  description = "Artifact Registry repository ID"
  type        = string
  default     = "project-repository"
}

variable "service_name" {
  description = "Cloud Run service name"
  type        = string
  default     = "sample-run"
}

variable "image_name" {
  description = "Container image name (no registry prefix)"
  type        = string
  default     = "sample-app"
}
