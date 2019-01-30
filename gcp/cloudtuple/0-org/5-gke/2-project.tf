# Org admin creates all projects
# to make TF deployment simpler
#-------------------------------
resource "random_id" "suffix" {
  byte_length = 1
}

# GKE Service Project
resource "google_project" "gke_service_project" {
  name = "gke-service-project-${random_id.suffix.hex}"
  project_id = "gke-service-project-${random_id.suffix.hex}"
  folder_id  = "${google_folder.gke_folder.name}"
  billing_account = "${var.billing_account_id}"
}

# Give the terraform and vm service account projects owner role
#----------------------------------------------------
resource "google_project_iam_binding" "gke_service_project_owner" {
  project    = "${google_project.gke_service_project.id}"
  role = "roles/owner"

  members = [
    "serviceAccount:${google_service_account.node_gke_service_project.email}",
    "serviceAccount:${google_service_account.tf_gke_service_project.email}"
  ]
}

resource "google_project_iam_binding" "gke_service_project_k8s_app" {
  project    = "${google_project.gke_service_project.id}"
  role = "roles/owner"

  members = [
    "serviceAccount:${google_service_account.k8s_app_gke_service_project.email}",
  ]
}
