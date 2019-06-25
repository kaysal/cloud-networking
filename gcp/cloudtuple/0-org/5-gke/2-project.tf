# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# GKE Service Project
resource "google_project" "gke_service_project" {
  name            = "gke-service-project-${random_id.suffix.hex}"
  project_id      = "gke-service-project-${random_id.suffix.hex}"
  folder_id       = google_folder.gke_folder.name
  billing_account = var.billing_account_id

  lifecycle {
    prevent_destroy = true
  }
}

