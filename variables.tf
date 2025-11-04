variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Primary region"
  type        = string
}

variable "repository_id" {
  description = "Artifact Registry repository ID"
  type        = string
}

variable "service_name" {
  description = "Service name"
  type        = string
}

variable "image_name" {
  description = "Image name"
  type        = string
}

variable "github_org" {
  description = "Your GitHub organization or username"
  type        = string
}

variable "github_repo" {
  description = "Your GitHub repository name"
  type        = string
}

variable "github_branch" {
  description = "The main branch of your GitHub repository"
  type        = string
  default     = "main"
}
